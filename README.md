# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.

## Layout

```
macportseda/
└── cad/
    ├── OpenSTA/
    │   └── Portfile
    └── cudd/
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
