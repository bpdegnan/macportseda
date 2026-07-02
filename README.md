# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.  Tested on MacOS 13 and MacOS 15 (see the macOS 15 notes below). (I tried the new MacOS and they used more power and did less)
This work is motivated by the fact that my needs that generally don't overlap with most communities.  
I always felt bad contributing to macports because I'm not a very good at software engineering, and the lack of experience made me a bad collaborator.  I'm still poor at GIT.

Tested on my macOS 13 and macOS 15 machines.


## Layout

```
macportseda/
└── cad/
    ├── eda-icall/      # METAPORT: installs the whole sky130 toolchain
    │   └── Portfile
    ├── OpenSTA/
    │   └── Portfile
    ├── cudd/
    │   └── Portfile
    ├── netgen-lvs/
    │   └── Portfile
    ├── klayout/
    │   └── Portfile
    ├── gtkwave/        # vendored stock snapshot
    │   └── Portfile
    ├── openvaf/        # Verilog-A -> OSDI compiler (Reloaded fork)
    │   └── Portfile
    ├── yosys/          # Verilog RTL synthesis suite (bundles ABC)
    │   └── Portfile
    ├── sby/            # SymbiYosys — formal verification front-end
    │   └── Portfile
    ├── eda-or-tools/   # pinned OR-Tools (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-lemon/      # pinned LEMON graph lib (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-fmt/        # pinned fmt 12.1 (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-spdlog/     # pinned spdlog 1.16 vs eda-fmt (private prefix) for OpenROAD
    │   └── Portfile
    ├── openroad/       # OpenROAD RTL-to-GDS P&R (builds & runs — see notes)
    │   └── Portfile
    └── (see science/ and x11/ for the rest)
x11/
└── xcircuit/          # vendored stock snapshot
    └── Portfile
science/
├── xschem/
│   └── Portfile
├── iverilog/          # vendored stock snapshot
│   └── Portfile
├── verilator/         # vendored stock snapshot (LibreLane lint step)
│   └── Portfile
├── magic/             # vendored snapshot, bumped to 8.3.660 for LibreLane
│   └── Portfile
├── trilinos16/         # serial Trilinos subset for Xyce
│   └── Portfile
├── xyce/
│   └── Portfile
├── trilinos-charon/    # MPI + Panzer Trilinos (private prefix)
│   └── Portfile
├── charon/
│   └── Portfile        # Sandia TCAD device simulator
└── kicad/              # KiCad 10.0.4 + symbol/footprint/3D/template subports
    ├── Portfile
    └── files/
python/
├── py-pcpp/
│   └── Portfile
├── py-zstandard/
│   └── Portfile
└── py-volare/
    └── Portfile
aqua/
└── skim-app/           # Skim PDF/PostScript/EPS reader (prebuilt .app)
    └── Portfile
```

Ports live under a category directory (`cad`) as MacPorts expects.

## Using this tree

1. Register the tree in `sources.conf`. Put the local `file://` line *above*
   the rsync line so local ports take precedence:

   ```
   sudo $EDITOR $(port dir macports-base >/dev/null 2>&1; echo)/opt/local/etc/macports/sources.conf
   ```

   (Usually `/opt/local/etc/macports/sources.conf`.) Add:

   ```
   file:///Users/degs/private/projects/software/macportseda
   rsync://rsync.macports.org/macports/release/tarballs/ports.tar [default]
   ```

2. Build the port index (run inside this directory):

   ```
   cd /Users/degs/private/projects/software/macportseda
   portindex
   ```

3. Install. For the full sky130 toolchain in one shot:

   ```
   sudo port install eda-icall
   ```

   (a metaport pulling yosys, sby, iverilog, verilator, OpenSTA, openroad,
   openroad-ll, xschem, ngspice, xyce, openvaf, magic, netgen-lvs, klayout,
   xcircuit, gtkwave, py-volare, skim-app — kicad and charon/TCAD stay
   separate). Mind the variant prerequisites in the macOS 15 notes and the
   build-time gates below if ports build from source; `port notes eda-icall`
   summarizes them. Or install ports individually:

   | Port | Command | Notes |
   |------|---------|-------|
   | OpenSTA | `sudo port install OpenSTA` | `+cudd` default; `+basic` for no CUDD; `+readline`. Pulls `cudd`. |
   | klayout | `sudo port install klayout` | Qt6 GUI (native Cocoa, no XQuartz). Long build. |
   | netgen-lvs | `sudo port install netgen-lvs` | LVS; *not* `netgen` (that's a FEM mesher). X11 GUI → XQuartz. |
   | openvaf | `sudo port install openvaf` | Verilog-A→OSDI; binary is `openvaf-r`. |
   | gtkwave / xcircuit / iverilog / magic | `sudo port install <name>` | Vendored stock snapshots. `magic`/`xcircuit` are X11 → XQuartz. |
   | xschem | `sudo port install xschem` | Schematic capture. **X11 → needs XQuartz** (see notes). |
   | xyce | `sudo port install xyce` | Parallel SPICE; pulls `trilinos16`. |
   | py-volare | `sudo port install py-volare` | PDK manager; py313, installs `volare`. |
   | skim-app | `sudo port install skim-app` | Skim PDF/EPS reader → `/Applications/MacPorts`. |
   | kicad | see below ⚠️ | Full EDA suite + libraries. **Needs `boost` deactivated to build.** |
   | trilinos-charon / charon | see below ⚠️ | TCAD; **need `trilinos16` deactivated to build.** |

   Installing `OpenSTA` pulls in the local `cudd` port automatically.

   **Build-time deactivation gotchas** (MacPorts can't do these automatically —
   the build *fails* without them):

   - **kicad** conflicts with the umbrella `boost` port during the build:
     ```
     sudo port -f deactivate boost
     sudo port install kicad            # long build; pulls symbols/footprints/3D/templates
     sudo port activate boost
     ```
   - **charon** and **trilinos-charon** are shadowed by `trilinos16`'s stub
     `mpi.h` during the build:
     ```
     sudo port -f deactivate trilinos16
     sudo port install charon           # or trilinos-charon
     sudo port activate trilinos16       # rev-upgrade usually re-activates it anyway
     ```

   GUI tools that use X11 (`xschem`, `magic`, `netgen-lvs`, `xcircuit`) need a
   running X server — install **XQuartz** (see the xschem notes). `klayout`
   (Qt6) and `skim-app` are native Cocoa and don't.

## distfiles archive (offline / standalone insurance)

- `distfiles/` (gitignored — 2.4+ GB, and GitHub hard-rejects files >100 MB,
  so it can never live in git) holds a copy of every source tarball the tree's
  ports fetch. Upstream URLs rot: lemon.cs.elte.hu already 404s (the eda-lemon
  port gained a Spack mirror fallback) and the charon tarball lives at a
  fragile sandia.gov uploads URL.
- MacPorts uses an already-present, checksum-verified distfile without
  touching the network, so restoring on any machine is just:
  ```
  sudo rsync -a distfiles/ /opt/local/var/macports/distfiles/
  ```
  then install normally. The Portfile checksums authenticate every file, so
  the archive needs no special trust.
- To (re)populate after adding or bumping ports:
  ```
  sudo port mirror <portname...>     # fetches into /opt/local/var/macports/distfiles
  rsync -a /opt/local/var/macports/distfiles/<portname> distfiles/
  ```
- Keep a copy of `distfiles/` with your normal backups (it is NOT pushed with
  the repo).
- **Off-machine copy**: the archive is also published as per-port tars (+
  SHA256SUMS) on the repo's GitHub Releases page — release assets escape the
  100 MB git limit (2 GB/file). Current: tag `distfiles-2026-07`. To refresh
  after port bumps: re-run `port mirror`, re-tar the changed port dirs, and
  `gh release upload <tag> <tars> --clobber` (or cut a new dated release).
  Note `gh release create` also creates a git tag on the remote.

## macOS 15 (Sequoia) notes

The whole tree builds on macOS 15.3 / Xcode 16.2 with the following caveats:

- **Dependency variants** — MacPorts Portfiles
  cannot force variants of their dependencies, and the macOS 15 defaults
  differ from ther other macOS 13 build. Before building the X11 GUI ports, make sure:
  ```
  sudo port upgrade --enforce-variants tk +x11 -quartz     # xschem needs X11 Tk
  sudo port install gtk2 +quartz                            # gtkwave needs quartz gtk2
  ```
  **Do not pass `-x11` when enforcing gtk2 +quartz** — `--enforce-variants`
  propagates the requested variants to the whole dependency tree and will strip
  the x11 backend out of `cairo`/`pango`, which silently breaks every
  already-built X11 port (xschem dies with
  `Symbol not found: _cairo_xlib_surface_create`). `cairo` and `pango` must
  stay `+quartz+x11` (both backends coexist in one library). If they get
  switched, reactivate the fat builds, e.g.
  `sudo port -f activate cairo @1.18.4_2+quartz+x11`.
- **xcircuit** needed a real fix (in-tree): Xcode 16 clang turns
  implicit-function-declaration / int-conversion into hard errors; the Portfile
  now appends `-Wno-error=` for both (no-ops on the older clang).
- **gcc13 from the binary packages is broken with CLT 16.2** (SDK 15.2): its
  fixincluded `_stdio.h` references `_bounds.h`, which only exists in SDK
  15.4+. Any pure-gcc C compile fails with
  `fatal error: _bounds.h: No such file or directory` — this hits the
  `trilinos-charon`/`charon` builds (their C compiler is gcc13 via openmpi).
  Fix: rebuild gcc13 against the local SDK (`sudo port -N -s upgrade --force
  gcc13`) or update the Command Line Tools to 16.3+. (`trilinos16`/`xyce` are
  unaffected: they use Apple clang for C/C++ and gcc13 only for Fortran.)
- **gtkwave** builds, but gtk2-quartz cannot even print `--version` without a
  window server, so it cannot be smoke-tested over SSH — verify it from a
  local GUI session.

## LibreLane / OpenLane 2 notes (RTL-to-GDS flow driver)

- **Use LibreLane, not the `openlane` PyPI package.** OpenLane 2 froze at 2.3.x
  when Efabless shut down; LibreLane (same lead dev) is its continuation and is
  what actually works with current tools: `openlane` 2.3.10 hard-codes the old
  boost::python pyosys API and the pre-OpenSTA-3 `sta::corners` TCL, both dead
  ends with 2026 tools.
- **Native mode** (upstream supports only Nix/Docker, but this works, verified
  end-to-end): the `librelane` wrapper script in `~/.local/bin` runs a uv venv
  (`~/.venvs/librelane`, python 3.12, `pip install librelane`) with MacPorts
  tools on PATH. `spm` example: full 80-stage flow to GDS with **0 magic DRC,
  0 klayout DRC, 0 netgen LVS errors**.
- What native mode needed (all in-tree / in the wrapper):
  - **`openroad-ll` port**: OpenROAD pinned to LibreLane's validated rev
    (2026-02-17) in the private prefix `libexec/openroad-ll`. The tag-tracking
    `openroad` port (26Q3) has confirmed upstream regressions against the flow
    (resizer buffer explosion → >100% utilization, librelane#944 /
    OpenROAD#10622; I/O pins placed outside the die). Same build gates as
    `openroad` (deactivate `boost spdlog protobuf3-cpp OpenSTA` to build).
  - **`yosys +pyosys` variant**: LibreLane runs synthesis as Python scripts via
    `yosys -y`, so yosys needs its pybind11 Python bindings (new
    `py-cxxheaderparser` port is a build dep). Python pinned to 3.12 to match
    the venv (the embedded interpreter imports `click` from it via PYTHONPATH).
  - **magic bumped to 8.3.660** (nix-eda's pin; 8.3.508 lacks the `units`
    command the magic scripts use). Needs `gsed` for its GNU-sed depend rule.
  - **Wrapper PATH order matters**: venv bin first (LibreLane's klayout steps
    export the venv's sys.path as PYTHONPATH and call plain `python3` — it must
    resolve to the venv's 3.12, else stdlib version-crossing → "SRE module
    mismatch"), then `libexec/openroad-ll/bin`, then `/opt/local/bin`.
- **PDK**: LibreLane's bundled ciel downloads its pinned open_pdks sky130A
  build into `PDK_ROOT` (~/.volare) on first run. Don't point it at the raw
  skywater-pdk checkout — that is not an open_pdks build.
- netgen 1.5.321 and klayout 0.30.9 match LibreLane's pins; standalone OpenSTA
  is untouched (the flow does STA through openroad).
- OpenLane **1** was skipped deliberately: Docker/Makefile-first, legacy,
  fully superseded by LibreLane for this use case.

## cocotb notes (Python testbenches)

- **cocotb 2.0** for simulation-based digital verification (complements sby's
  formal): Python coroutine testbenches driving the MacPorts simulators.
  Like LibreLane it's a Python package, not a port: uv venv at
  `~/.venvs/cocotb` (python 3.12, `pip install cocotb pytest`).
- Verified against both installed simulators (a counter testbench passes on
  **icarus** and **verilator**). Remember a `` `timescale `` directive in the
  HDL — icarus defaults to 1 s precision and cocotb's Clock errors out.
- Preferred workflow is the cocotb 2.x Python runner
  (`cocotb_tools.runner.get_runner("icarus"|"verilator")`) run with
  `~/.venvs/cocotb/bin/python`; a `cocotb-config` shim in `~/.local/bin`
  covers the legacy Makefile flow.

## OpenSTA notes

- Upstream (`parallaxsw/OpenSTA`) publishes no git tags or releases, so the
  Portfile pins a specific `master` commit. The `version` is the `project()`
  version from `CMakeLists.txt` at that commit. To update: change the commit
  and version in the Portfile, then run `port -v checksum OpenSTA` and paste the
  reported values into the `checksums` block.
- CUDD support is on by default via the `+cudd` variant, satisfied by the
  sibling `cudd` port. `+cudd` and `+basic` are mutually exclusive; requesting
  `+basic` overrides the default and builds without CUDD (losing some BDD-based
  optimizations).
- OpenSTA's bundled `FindTCL.cmake` hard-codes Homebrew paths on macOS, so the
  Portfile passes `-DTCL_LIB_PATHS=${prefix}/lib`; without it the build cannot
  find the MacPorts Tcl.
- `tclreadline` (interactive line editing) is in MacPorts (`devel/tclreadline`)
  and off by default. Enable with `+readline`. It is forced off otherwise so the
  build does not silently link an already-installed tclreadline without
  declaring the dependency.

## cudd notes

- Built from the `cuddorg/cudd` `3.0.0` release tag (the version OpenSTA
  recommends). It installs `cudd.h` into `${prefix}/include` and `libcudd` into
  `${prefix}/lib`, which is where OpenSTA's `FindCUDD.cmake` looks given
  `-DCUDD_DIR=${prefix}`.
- This port is not yet known to MacPorts until the tree is registered and
  `portindex` has run; until then `port lint OpenSTA` reports
  `Unknown dependency: cudd`, which is expected and resolves after indexing.

## netgen-lvs notes

- Tim Edwards' netgen (LVS), built from the `RTimothyEdwards/netgen` `1.5.321`
  tag. Named `netgen-lvs` to avoid colliding with MacPorts' unrelated
  `math/netgen` (a FEM mesh generator) — `port install netgen-lvs`.
- Needs `tk-x11`: netgen's Tcl build refuses to compile without X11, so the X11
  Tk is pulled in even though batch LVS opens no window.
- The build uses the `tcllibrary` / `install-tcl-real` make targets directly
  because netgen's default targets pipe through `make.log`/`install.log`, which
  hide output and can mask failures by always exiting 0.

## klayout notes

- KLayout (`KLayout/klayout` tag `v0.30.9`), Qt6 GUI with Ruby + Python
  scripting. Long build (~100 MB source + full Qt link).
- Uses a bespoke `build.sh` (qmake-based) that builds and installs every
  artefact into one self-contained directory. The Portfile drives the phases by
  hand: `build.sh` stages into `${workpath}` with the final RPATH
  (`${prefix}/lib/klayout`) baked in, and destroot copies the tree into
  `${prefix}/lib/klayout`, symlinking the tools (`klayout`, `strm*`) into
  `${prefix}/bin`.
- The libgit2-based package manager is disabled (`-nolibgit2`) to keep the
  external-library surface small; it is irrelevant to layout/DRC.

## py-volare notes (PDK version manager)

- `py-volare` is a Python package; it pulls in two helper ports that were also
  missing from MacPorts: `py-pcpp` (pure Python) and `py-zstandard` (builds a C
  extension against its own bundled zstd, no external dependency). All three
  build 311/312/313 subports and default to Python 3.13.
- The `volare` executable is installed as `volare-3.13`; the default-version
  subport also symlinks an unsuffixed `volare` into `${prefix}/bin`.
- Largely redundant if you already have your PDKs installed; useful for pinning
  PDK versions or fetching new builds.

## openvaf notes (Verilog-A compiler)

- **OpenVAF-Reloaded** — the maintained community continuation of OpenVAF (the
  original by Pascal Kuthe has been unmaintained since end of 2023). Compiles
  Verilog-A compact device models to OSDI shared libraries for ngspice / Xyce.
  Rust + LLVM.
- **Status: working.** `openvaf-r model.va` compiles a Verilog-A model to a
  `model.osdi` Mach-O shared library (verified on a resistor and a diode model).
- Built with the `cargo` PortGroup. The full crates.io dependency set (147
  crates) is pinned inline from upstream's `Cargo.lock`; one extra dependency
  (`salsa`) is an unpublished git fork (`pascalkuthe/salsa`), pulled via
  `cargo.crates_github` (a `post-extract` exposes its `salsa-macros` member as
  its own directory-source entry and drops the PortGroup's stray `branch` line).
- **Pinned to a mob-branch commit, not the tag.** The only tag (`v24.0.0mob`)
  has 2022-era codegen that **segfaults** emitting OSDI metadata on LLVM 18;
  mob HEAD fixed it, so the Portfile pins commit `dafc73c` (2026-06-24).
- **LLVM:** the fork supports LLVM 18-21 selected by a cargo feature. The
  Portfile uses MacPorts `llvm-18` (`--features llvm18`,
  `LLVM_SYS_181_PREFIX=${prefix}/libexec/llvm-18`) and forces **static** LLVM
  linking (flips llvm-sys `prefer-dynamic`→`force-static`), so `openvaf-r` is
  self-contained. To switch LLVM major, change `--features llvmNN` and
  `LLVM_SYS_NN1_PREFIX` together.
- Builds only the CLI driver; the installed binary is **`openvaf-r`** (upstream's
  name). `external/vacask` is a test-only git submodule, not needed to build.

## yosys notes (Verilog synthesis)

- Yosys 0.66, the open Verilog RTL synthesis suite (the synthesis front-end of
  the digital flow). Built from the official **`yosys-src.tar.gz`** release
  tarball, which **bundles ABC** and carries `.gitcommit` — so no network fetch
  or git is needed during the build (installs `yosys` + `yosys-abc`).
- Makefile build (`use_configure no`): `make CONFIG=clang PREFIX=${prefix}`.
  Yosys's Makefile **auto-detects MacPorts** (adds `${prefix}` include/lib/
  pkgconfig when `port` is on PATH), so deps resolve cleanly:
  bison/flex/pkgconfig (build) + tcl/readline/libtommath/zlib (lib).
- The release tarball is *flat* (no top directory), hence `extract.mkdir yes`.
- Verified: synthesizes RTL to gates and runs ABC technology mapping.
- This is the synthesis half only; the digital P&R side (OpenROAD) is not
  packaged (heavy Bazel/OR-Tools dependency cascade, and not needed for the
  analog-focused flow).

## openroad notes (RTL-to-GDS P&R — builds & runs)

- OpenROAD **26Q3**, built via **CMake** (26Q3 also has Bazel; CMake avoids that).
  C++20 → MacPorts **clang-19 + libc++ 19 headers** (same recipe as kicad). The
  binary runs: `openroad -version`, Tcl interpreter, `+GPU +Python` (`-GUI`).
- **`eda-` dependency strategy** — version-pinned deps that conflict with MacPorts
  go in the private prefix `/opt/local/libexec/eda`:
  - **`eda-or-tools`** — repackages Google's *prebuilt* macOS OR-Tools 9.14
    (bundles the exact abseil/protobuf 6.31/re2 or-tools needs; MacPorts' are
    ABI-incompatible). Its partial bundled Boost is stripped.
  - **`eda-lemon`** — COIN-OR LEMON 1.3.1 (MacPorts `lemon` is the SQLite parser);
    its headers are patched for C++20 (removed `std::allocator::construct`).
  - **`eda-fmt`** (fmt 12.1) + **`eda-spdlog`** (spdlog 1.16 built against eda-fmt).
    OpenROAD's slang frontend needs fmt ≥12.1 but MacPorts spdlog is bound to
    fmt 10 → `fmt::v10`-vs-`v12` link mismatch; the eda pair keeps one fmt ABI.
- OpenROAD's `src/sta` (its OpenSTA *fork*), `third-party/abc`, and
  `third-party/slang-elab` (+ nested slang/fmt) are vendored as pinned distfiles.
  System deps: tcl/eigen3/cudd/yaml-cpp/gtest/readline/zlib/libomp/python313 +
  swig/bison/flex/llvm-19.
- **Building requires deactivating four ports whose `/opt/local/include` headers
  shadow the private/fork copies** (a plain `-I/opt/local/include` from tcl etc.
  beats the `-isystem` eda paths). Deactivate, build, reactivate:
  ```
  sudo port -f deactivate boost spdlog protobuf3-cpp OpenSTA
  sudo port install openroad        # ~40 min C++20 compile
  sudo port activate boost spdlog protobuf3-cpp
  sudo port activate OpenSTA @3.1.0_1+cudd
  ```
  (openroad no longer installs its own `sta`/headers/libOpenSTA.a, so it coexists
  with the standalone OpenSTA port once reactivated.)
- Full blow-by-blow, incl. the libomp link fix and every gate, in memory
  ([[openroad-port-facts]]).

## sby notes (SymbiYosys formal verification)

- SymbiYosys (`sby`), the formal-verification front-end for Yosys (BMC,
  k-induction, cover, equivalence). Pure-Python; pinned to a recent `main`
  commit (no version tags track current yosys). `supported_archs noarch`.
- Drives `yosys` + `yosys-smtbmc` with an SMT solver; the port depends on
  **z3** (default engine). `yices` and `boolector` are also in MacPorts and
  work if you select them in the `[engines]` section of a `.sby` file.
- Install quirks: the Makefile derives its version from `.gittag` (falling back
  to `git describe`, which fails in a tarball), so `post-extract` writes a clean
  `.gittag`; `post-destroot` repoints the `sby` script's `#!/usr/bin/env python3`
  at `${prefix}/bin/python3.13`.
- Verified: passes true assertions and fails false ones (with counterexample)
  via `sby -f design.sby`.

## skim-app notes (Skim PDF/EPS reader)

- Skim, the macOS PDF/PostScript reader/annotator, for viewing EPS plots from
  the EDA tools. Named **`skim-app`** to avoid the unrelated MacPorts `skim`
  (a Rust fuzzy finder) — `port install skim-app`.
- Installs the **official prebuilt universal app** (no source build): the port
  fetches `Skim-<ver>.dmg`, and `destroot` mounts it with `hdiutil` (via
  `system`) and `ditto`s `Skim.app` into `/Applications/MacPorts/`.
- EPS: Skim registers `com.adobe.encapsulated-postscript` and opens EPS/PS via
  macOS's built-in PostScript importer (present on Ventura). If an EPS won't
  render on a newer macOS, convert first with ghostscript (`epstopdf`); see the
  port's `notes`.

## kicad notes (KiCad 10.0.4)

- Adapted from the stock MacPorts `kicad` port (which is stuck at 7.0.11) to
  **10.0.4**, Unix-style: real binaries in `/opt/local/bin` plus `.app`
  launchers in `/Applications/MacPorts/KiCad/`. Builds, runs, rev-upgrade clean.
- The fight to get it building on Ventura (all in the Portfile / `files/`):
  - Re-ported the `KICAD_MACOSX_APP_BUNDLE=OFF` patch across 3 major versions
    (pcbnew CMake restructure, `paths.cpp` guard split, `kicad-cli` install).
  - New v10 deps: `zstd`, `libgit2`, `fontconfig`, `protobuf3-cpp`, `nng`,
    `gnutar`. `conflicts_build boost` ⇒ deactivate `boost` for the build
    (`sudo port -f deactivate boost`, reactivate after).
  - **C++23 stdlib:** KiCad 10 uses `std::ranges::views::values` etc. that the
    Ventura SDK libc++ (15) lacks, so it builds with **`macports-clang-19` + its
    libc++ 19 headers** (system libc++ runtime).
  - wxWidgets 3.3→3.2 API fallback, an mbedtls link fix for the static
    `libnng.a`, GNU-tar for the bitmap archive, and a klayout-style
    install-name rewrite (`files/fix-install-names.sh`) so the `.kiface`/3D
    plugins resolve the kicad libs.
- **Data libraries** (`kicad-symbols`/`-footprints`/`-packages3D`/`-templates`)
  are subports installed from GitLab 10.0.4 archives. The `kicad-docs` subport
  was **dropped**: CERN's prebuilt docs tarballs stop at 8.0.0-rc3, so there is
  no `kicad-doc-10.0.4`; KiCad's Help menu uses the online docs instead.
- See [[kicad-port-facts]] in memory for the full blow-by-blow.

## vendored stock ports (gtkwave, xcircuit, iverilog, magic, verilator)

- These five are **snapshots of the stock MacPorts ports** (Portfile +
  any `files/` patches), copied in so this tree is a self-contained EDA catalog.
  They shadow the stock ports because the local `file://` source sits above the
  rsync line in `sources.conf`. gtkwave, iverilog and verilator are verbatim;
  two carry local changes:
  - **xcircuit**: `-Wno-error` flags for Xcode 16 clang (see the macOS 15
    notes; stock is still broken there).
  - **magic**: bumped to **8.3.660** (LibreLane's magic scripts need its
    `units` command; stock MacPorts was at 8.3.508) plus a `gsed` fix for the
    GNU-sed `-i` usage in 8.3.660's depend rule.
- **verilator** (5.028) was vendored for the LibreLane flow's lint step; the
  version matches LibreLane's own nix pin.
- This is a deliberate **snapshot/pin**, not a fork to maintain. Since I'm the
  sole user, I'd rather freeze a known-good revision than chase upstream — these
  intentionally won't pick up MacPorts version bumps until re-copied.
- To refresh one to the current upstream revision, re-copy it, e.g.:
  ```
  cp -R /opt/local/var/macports/sources/rsync.macports.org/macports/release/tarballs/ports/science/magic/. \
        science/magic/ && portindex
  ```
- `gtkwave` has historically been finicky to build here, which is exactly why
  pinning a working revision in-tree is worthwhile.
- `ngspice` and `openEMS` are deliberately **left on stock MacPorts** (not
  vendored). Both are used here occasionally; neither is pinned by any flow,
  so tracking stock is fine.

## xschem notes

- Schematic capture (3.4.6). Builds against the X11 Tk (`tk +x11`).
- **X server required.** macOS ships none, and the MacPorts `xorg-server` is
  deprecated/broken on Ventura and later — with it installed, xschem fails with
  "can't open display". Fix: `sudo port -f uninstall xorg-server
  xorg-server-devel`, install the official **XQuartz** from
  <https://www.xquartz.org>, then log out/in so `$DISPLAY` registers. The port's
  `notes` (shown on install, or via `port notes xschem`) spells this out.
- The same X server requirement applies to the other X11 GUIs here
  (`magic`, `netgen-lvs`, the `klayout` GUI).

## trilinos16 / xyce notes

- Migrated from a separate local tree. `trilinos16` is the *serial* Trilinos
  subset Xyce needs (Epetra/Teuchos/AztecOO/...); `xyce` (7.9) links it.
- Both build C/C++ with Apple clang and Fortran with gcc13; they install into
  `${prefix}` normally. Xyce upstream only rigorously tests Trilinos 14.4, so
  these versions are pinned deliberately — bumping Trilinos is risky.

## trilinos-charon notes

- A *second*, independent Trilinos build configured with **MPI + the full Panzer
  stack** (Tpetra, Panzer, Phalanx, Intrepid2, STK, SEACAS, MueLu, ...), needed
  by Charon. Built with `openmpi-gcc13` and gcc's native `libstdc++`.
- Installs into a **private prefix** `${prefix}/libexec/trilinos-charon` so it
  coexists with the serial `trilinos16` (no shared `lib/cmake/Trilinos` or
  library-name collisions).
- Build requires the full gcc13/2024-toolchain fix set (see the Portfile):
  `libstdc++`, `-Wl,-no_warn_duplicate_libraries`, `-include cstdint`,
  `-DNETCDF_ENABLE_LEGACY_MACROS`, `-DBOOST_STACKTRACE_GNU_SOURCE_NOT_REQUIRED`,
  `-fpermissive`, serial-HDF5 bypass, and STK subpackage trims.

## charon notes (Sandia TCAD)

- Charon v2.2 is a TriBITS *project* that builds Trilinos (as an extra
  repository) **from source alongside itself** — it does not link an installed
  Trilinos. The Portfile fetches two distfiles (Charon + vanilla Trilinos 13.4)
  and drops the Trilinos source at `tcad-charon/Trilinos` where Charon expects
  it. Installs to the private prefix `${prefix}/libexec/charon`.
- Charon-specific build notes: BoostLib needs non-`-mt` symlinks (MacPorts boost
  is `-mt`-suffixed); `CMAKE_BUILD_TYPE=Release` (TriBITS rejects the portgroup's
  `MacPorts` type); HDF5 re-enabled after `General.opts` (MacPorts netCDF is
  netCDF-4, so Exodus needs `libhdf5`); Percept disabled (broken vanilla
  `CMakeLists`).
- The solver binary is `charon_mp.exe`; a `post-activate` hook symlinks it to
  `${prefix}/bin/charon` (with a `pre-deactivate` cleanup).
- **Build-time caveat:** `trilinos16`'s serial stub `${prefix}/include/mpi.h`
  shadows openmpi's real header during the compile. Both `charon` and
  `trilinos-charon` now inject `files/openmpi-first.cmake` via
  `CMAKE_PROJECT_TOP_LEVEL_INCLUDES`, which prepends openmpi's include dir to
  the global search so the real `mpi.h` wins even with `trilinos16` active.
  Deactivating `trilinos16` for the build (`sudo port -f deactivate trilinos16`
  before, `sudo port activate trilinos16` after) is still the belt-and-braces
  procedure — note that MacPorts' rev-upgrade can re-activate `trilinos16` on
  its own mid-batch (it did so right after `trilinos-charon` finished
  installing, which is what originally broke the follow-on charon build).
