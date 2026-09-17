# eda_common

Foundation role for the `icanalytica.eda` collection. Every tool role lists it
as a meta-dependency, so it converges first and exactly once.

What it does:

- Asserts the host is RedHat-family Linux or macOS.
- RedHat: enables CRB and EPEL (`eda_manage_repos: false` to skip), installs
  the base build toolchain, adds `{{ eda_prefix }}/bin` to the default PATH
  (`/etc/profile.d/eda.sh`), and registers `{{ eda_prefix }}/lib{,64}` with the
  dynamic linker.
- macOS: asserts Xcode Command Line Tools and Homebrew are present, installs
  GNU autotools via Homebrew, and adds the prefix to PATH via `/etc/paths.d`.
- Creates the shared prefix layout: `/opt/eda` (tools), `/opt/eda/vendor`
  (pinned libraries only OpenROAD-class builds may see), `/opt/eda/src`
  (build trees and install stamps).

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `eda_prefix` | `/opt/eda` | Install prefix for all tools |
| `eda_vendor_prefix` | `{{ eda_prefix }}/vendor` | Private prefix for pinned vendor libs |
| `eda_src_root` | `{{ eda_prefix }}/src` | Build trees + install stamps |
| `eda_make_jobs` | vCPU count | Parallel build jobs |
| `eda_mirror_base` | `sources` release URL | Flat mirror for pinned source tarballs; `""` fetches upstream |
| `eda_manage_repos` | `true` | Enable CRB/EPEL on RedHat |

The dedicated `/opt/eda` prefix is deliberate: it avoids the shared-prefix
header-shadowing problems that plagued the MacPorts tree (`/opt/local`), stays
out of dnf's `/usr` and Homebrew's `/opt/homebrew`, and lets pinned vendor
libraries coexist with distro packages.
