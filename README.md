# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.

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
    └── klayout/
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
- NOT yet build-verified — most likely points to iterate are the Qt6 qmake
  handshake, Ruby/Python auto-detection in `build.sh`, and macOS RPATH.
