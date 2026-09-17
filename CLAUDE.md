# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The **Ansible collection `icanalytica.eda`**: one role per open-source EDA
tool (yosys, OpenSTA, magic, xyce, openvaf, klayout, OpenROAD, ...), building
each from a pinned, sha256-verified source tarball into the dedicated prefix
`/opt/eda` on Rocky Linux 9 and macOS. Consumed by the org's control repo
(`~/code/ansible`) via a git entry in `collections/requirements.yml` and FQCN
role references (`icanalytica.eda.yosys`).

**Transition state:** the repo is mid-conversion from a MacPorts port tree.
The legacy directories `aqua/ cad/ python/ science/ x11/` and
`README-macports.md` are **frozen reference material** — the Portfiles hold
the authoritative version pins, checksums, and build workarounds until each
tool's role lands. Never edit the legacy tree; port knowledge out of it. It is
deleted entirely in the final cleanup PR.

## Commands

```bash
uv sync                 # dev deps into .venv (uv pinned via .tool-versions)
make lint               # ansible-lint (profile: min)
make lint-fix
make yamllint
make test-<role>        # molecule test for one role, e.g. make test-eda_common
make build              # ansible-galaxy collection build (also a lint sanity check)
```

Molecule needs Docker running. Run everything through `uv run` / the Makefile;
do not activate the venv manually.

## Architecture

- **`roles/eda_common`** is a meta-dependency of every tool role: OS assert
  (RedHat|Darwin), CRB+EPEL on RedHat, base toolchain, `/opt/eda` layout
  (`bin`, `vendor`, `src`), PATH via `/etc/profile.d/eda.sh` (Linux) or
  `/etc/paths.d/50-eda` (macOS), `ld.so.conf.d` + ldconfig handler.
  Collection-wide knobs live in its defaults: `eda_prefix`, `eda_vendor_prefix`,
  `eda_src_root`, `eda_make_jobs`, `eda_mirror_base`, `eda_manage_repos`.
- **Role template** (mirrors `~/code/ansible/roles/ngspice`, the org pattern):
  - `defaults/main.yml` — `<t>_version`, `<t>_checksum` (sha256), `<t>_source_url`
    (`eda_mirror_base` default; upstream and `file://` overrides), prefix/flags/
    jobs/`<t>_force_rebuild`.
  - `vars/redhat.yml` + `vars/darwin.yml` — build/runtime package lists (dnf vs
    Homebrew). Heavy roles are RedHat-only and assert so.
  - `tasks/main.yml` — OS assert → include_vars by `os_family` → package installs
    → include `tasks/<tool>.yml` → **verification block that runs the real tool**
    and asserts behavior (fail the play if the tool is broken).
  - `tasks/<tool>.yml` — get_url with `checksum: sha256:` → unarchive/configure/
    make/install guarded by `creates:` + a versioned stamp file under
    `{{ eda_src_root }}/<tool>/`.
  - `molecule/default/` — Docker, `geerlingguy/docker-rockylinux9-ansible`,
    testinfra tests. FQCNs resolve via the committed symlink
    `.molecule/ansible_collections/icanalytica/eda -> ../../..`.
  - `README.md` — pin + rationale ported from the Portfile "why" comments.
- **Prefix discipline:** tools install to `/opt/eda`; version-pinned libraries
  that would conflict with distro packages (or-tools, lemon, fmt, spdlog, boost
  for OpenROAD) go to `/opt/eda/vendor` and are exposed only via
  `CMAKE_PREFIX_PATH` in the roles that need them. `openroad_ll` (LibreLane's
  validated OpenROAD rev) twin-installs to `/opt/eda/openroad-ll`, off PATH.
- **Headless by design:** no XQuartz/X server anywhere. X11-linked tools build
  against X client libraries only and are verified in batch mode
  (`magic -dnull -noconsole`, `netgen -batch`, `xschem -n --no_x`).

## Conventions

- Pins are sacred: every source fetch carries a sha256; version bumps change
  `<t>_version` + `<t>_checksum` together. Preserve the "why" comments when
  porting knowledge from Portfiles — they are the value of this repo.
- Keep roles independently usable: no hard references to another role's vars
  except through the `eda_*` knobs and meta-dependencies.
- macOS specifics: Homebrew tasks must not run under `become` (brew refuses
  root). Darwin-gated patches only where genuinely macOS-specific.
- Git/PRs follow ICA conventions (branch + PR, conventional-commit subjects
  with emoji, squash merge, assignee `@me`).
