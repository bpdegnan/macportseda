# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.  
This work is motivated by the fact that needs that generally don't overlap with most communities.  
I always felt bad contributing to macports because I'm not a very good software engineering, and the lack of experience made me a bad collaborator.


## Layout

```
macportseda/
└── cad/
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
    └── (see science/ and x11/ for the rest)
x11/
└── xcircuit/          # vendored stock snapshot
    └── Portfile
science/
├── xschem/
│   └── Portfile
├── iverilog/          # vendored stock snapshot
│   └── Portfile
├── magic/             # vendored stock snapshot
│   └── Portfile
├── trilinos16/         # serial Trilinos subset for Xyce
│   └── Portfile
├── xyce/
│   └── Portfile
├── trilinos-charon/    # MPI + Panzer Trilinos (private prefix)
│   └── Portfile
└── charon/
    └── Portfile        # Sandia TCAD device simulator
python/
├── py-pcpp/
│   └── Portfile
├── py-zstandard/
│   └── Portfile
└── py-volare/
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

3. Install:

   ```
   sudo port install OpenSTA          # with CUDD (default)
   sudo port install OpenSTA +basic   # without CUDD
   ```

   Installing `OpenSTA` pulls in the local `cudd` port automatically.

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
  default to Python 3.12 to match the rest of the tree.
- The `volare` executable is installed as `volare-3.12`; the default-version
  subport also symlinks an unsuffixed `volare` into `${prefix}/bin`.
- Largely redundant if you already have your PDKs installed; useful for pinning
  PDK versions or fetching new builds.

## openvaf notes (Verilog-A compiler)

- **OpenVAF-Reloaded** — the community fork of OpenVAF (the original by Pascal
  Kuthe has been unmaintained since end of 2023). Compiles Verilog-A compact
  device models to OSDI shared libraries for ngspice / Xyce. Rust + LLVM.
- Built with the `cargo` PortGroup. The full crates.io dependency set (147
  crates) is pinned inline from upstream's `Cargo.lock`; one extra dependency
  (`salsa`) is an unpublished git fork, pulled via `cargo.crates_github`.
- **LLVM:** the fork supports LLVM 18-21 selected by a cargo feature. The
  Portfile uses MacPorts `llvm-18` and points `llvm-sys` at its private prefix
  (`LLVM_SYS_181_PREFIX=${prefix}/libexec/llvm-18`). To switch versions, change
  the `--features llvmNN` build arg and the `LLVM_SYS_NN1_PREFIX` env together.
- Builds only the CLI driver; the installed binary is **`openvaf-r`** (upstream's
  name for the driver). `external/vacask` is a test-only git submodule and is
  not needed to build the compiler.
- **First stab, not yet build-verified.** Most likely iteration point is the
  llvm-sys / llvm-18 link step (static vs. dynamic LLVM libs); see the comment
  block at the bottom of the Portfile.

## vendored stock ports (gtkwave, xcircuit, iverilog, magic)

- These four are **verbatim snapshots of the stock MacPorts ports** (Portfile +
  any `files/` patches), copied in so this tree is a self-contained EDA catalog.
  They are not modified; they simply shadow the stock ports because the local
  `file://` source sits above the rsync line in `sources.conf`.
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
- `ngspice` is deliberately **left on stock MacPorts** (not vendored).

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
  shadows openmpi's real header during the compile, so `trilinos16` must be
  deactivated for the build: `sudo port -f deactivate trilinos16` before, and
  `sudo port activate trilinos16` after (rev-upgrade reactivates it anyway).
  The same applies to building `trilinos-charon`.
