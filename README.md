# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools. Tested on macOS 13, 15 and 26 on arm64. (I tried the new macOS and it used more power and did less.)

I built this because my needs generally don't overlap with most communities'. I always felt bad about contributing to MacPorts: I'm not very good at software engineering, and that lack of experience made me a bad collaborator. I'm still poor at git.

For SkyWater's 130 nm PDK I've never tried py-volare. I use the [https://github.com/bpdegnan/spicesupport](https://github.com/bpdegnan/spicesupport) repo and the [installskywater.sh](https://raw.githubusercontent.com/bpdegnan/spicesupport/refs/heads/main/installskywater.sh) script in it.

## Layout

```
macportseda/
└── cad/
    ├── eda-icall/      # METAPORT: installs the complete EDA toolchain
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
    ├── sby/            # SymbiYosys, formal verification front-end
    │   └── Portfile
    ├── netlistsvg/     # SVG schematics from yosys JSON (sky130 PDK dep)
    │   └── Portfile
    ├── sv2v/           # SystemVerilog -> Verilog-2005 (Haskell, source-built)
    │   └── Portfile
    ├── ghdl/           # GHDL VHDL simulator (per-arch prebuilt, llvm backend)
    │   └── Portfile
    ├── eqy/            # equivalence checking with yosys (RTL vs netlist)
    │   └── Portfile
    ├── mcy/            # mutation cover with yosys (testbench quality)
    │   └── Portfile
    ├── cvc-rv/         # CVC_RV ERC/reliability checks on CDL netlists
    │   └── Portfile
    ├── eda-vtk/        # minimal VTK IO subset (private prefix) for openEMS
    │   └── Portfile
    ├── eda-ngspice/    # metaport -> the default versioned ngspice
    │   ├── eda-ngspice46/  # ngspice 46 (own prefix, select-able)
    │   ├── eda-ngspice47/  # ngspice 47 (own prefix, select-able)
    │   ├── eda-ngspice_select/  # the `port select` group
    │   └── Portfile
    ├── CSXCAD/         # openEMS geometry lib (shadows stock; eda-vtk based)
    │   └── Portfile
    ├── openEMS/        # EC-FDTD EM solver, octave-free (shadows stock)
    │   └── Portfile
    ├── eda-or-tools/   # pinned OR-Tools (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-lemon/      # pinned LEMON graph lib (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-fmt/        # pinned fmt 12.1 (private prefix) for OpenROAD
    │   └── Portfile
    ├── eda-spdlog/     # pinned spdlog 1.16 vs eda-fmt (private prefix) for OpenROAD
    │   └── Portfile
    ├── openroad/       # OpenROAD RTL-to-GDS P&R (builds & runs; see notes)
    │   └── Portfile
    ├── openroad-ll/    # OpenROAD @ LibreLane's validated rev (private prefix)
    │   └── Portfile
    ├── eda-cace/       # CACE analog characterization engine (cace, cace-web)
    │   └── Portfile
    ├── eda-coin/       # Coin3D 4.x Open Inventor toolkit (private prefix)
    │   └── Portfile
    ├── eda-pivy/       # pivy Coin3D python bindings (vs eda-coin)
    │   └── Portfile
    ├── eda-freecad/    # FreeCAD 1.1.3 parametric 3D CAD (enclosures)
    │   └── Portfile
    ├── openscad/       # script-based 3D CAD, dev snapshot (shadows stock; CGAL 6)
    │   └── Portfile
    └── (see science/ and x11/ for the rest)
x11/
├── gtksheet/          # GtkSheet widget lib (lepton-attrib dependency)
│   └── Portfile
└── xcircuit/          # vendored stock snapshot
    └── Portfile
science/
├── nec2c/             # NEC-2 antenna simulation, command-line (MoM)
│   └── Portfile
├── xschem/
│   └── Portfile
├── lepton-eda/        # gEDA/gaf fork: lepton-schematic, -netlist, -attrib
│   └── Portfile
├── iverilog/          # vendored stock snapshot
│   └── Portfile
├── irsim/             # vendored stock snapshot + clang-15/Tcl-dylib fixes
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
├── py-cxxheaderparser/ # build dep of yosys +pyosys
│   └── Portfile
├── py-gdstk/           # GDSII/OASIS layout scripting (C++ ext)
│   └── Portfile
├── py-csxcad/          # python bindings for CSXCAD (openEMS frontend)
│   └── Portfile
├── py-openems/         # python bindings for openEMS
│   └── Portfile
├── py-ciel/            # PDK version manager (volare successor; eda-cace dep)
│   └── Portfile
├── py-pyside6/         # vendored stock snapshot + 2 fixes (eda-freecad dep)
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
   sudo $EDITOR /opt/local/etc/macports/sources.conf
   ```

   Add:

   ```
   file:///Users/degs/private/projects/macportseda
   rsync://rsync.macports.org/macports/release/tarballs/ports.tar [default]
   ```

2. Build the port index (run inside this directory):

   ```
   cd /Users/degs/private/projects/macportseda
   portindex
   ```

3. Install. For the full EDA toolchain in one go:

   ```
   sudo port install eda-icall
   ```

   `eda-icall` is a metaport. It pulls in yosys, sby, eqy, mcy, iverilog,
   verilator, OpenSTA, openroad, openroad-ll, netlistsvg, sv2v, xschem,
   eda-ngspice, xyce, openvaf, eda-cace (and py-ciel), irsim, magic,
   netgen-lvs, cvc-rv, klayout, xcircuit, py-gdstk, gtkwave, py-volare and
   skim-app. kicad, eda-freecad, ghdl, lepton-eda, openEMS and charon/TCAD are
   left out and installed separately.

   If ports build from source, read the variant prerequisites in the macOS 15
   notes and the build-time gates below first. `port notes eda-icall` sums
   them up. Or install ports one at a time:

   | Port | Command | Notes |
   |------|---------|-------|
   | OpenSTA | `sudo port install OpenSTA` | `+cudd` is the default; `+basic` builds without CUDD; `+readline` is optional. Pulls in `cudd`. |
   | klayout | `sudo port install klayout` | Qt6 GUI (native Cocoa, no XQuartz). Long build. |
   | netgen-lvs | `sudo port install netgen-lvs` | LVS. Not `netgen`, which is a FEM mesher. The X11 GUI needs XQuartz. |
   | openvaf | `sudo port install openvaf` | Verilog-A to OSDI. The binary is `openvaf-r`. |
   | gtkwave / xcircuit / iverilog / magic | `sudo port install <name>` | Vendored stock snapshots. `magic` and `xcircuit` are X11 and need XQuartz. |
   | xschem | `sudo port install xschem` | Schematic capture. X11, so it needs XQuartz (see the xschem notes). |
   | lepton-eda | `sudo port install lepton-eda` | gEDA/gaf fork. GTK3/X11 GUIs, so XQuartz. Needs `libepoxy +x11` and `glib2 +x11` (see the notes). Pulls in `gtksheet`. |
   | xyce | `sudo port install xyce` | Parallel SPICE. Pulls in `trilinos16`. |
   | py-volare | `sudo port install py-volare` | PDK manager. py313; installs `volare`. |
   | skim-app | `sudo port install skim-app` | Skim PDF/EPS reader, installed into `/Applications/MacPorts`. |
   | netlistsvg | `sudo port install netlistsvg` | SVG schematics from yosys JSON. A build dependency of the sky130 PDK. |
   | sv2v | `sudo port install sv2v` | SystemVerilog to Verilog-2005. Built from source (Haskell, all dependencies vendored offline). Native on x86_64 and arm64. |
   | eqy / mcy | `sudo port install eqy mcy` | Formal equivalence (RTL vs netlist) and mutation coverage. Version-locked to yosys 0.66. |
   | cvc-rv | `sudo port install cvc-rv` | ERC and reliability checks on extracted CDL netlists. The binary is `cvc_rv`. |
   | irsim | `sudo port install irsim` | Switch-level simulator. Vendored and fixed: stock builds but is silently broken on Xcode 15+. |
   | py-gdstk | `sudo port install py313-gdstk` | GDS/OASIS layout scripting for Python 3.13. |
   | ghdl | `sudo port install ghdl` | VHDL simulator (VHDL-87 to 2008, partial 2019). Uses upstream's official prebuilt bundles: native on x86_64 (macOS 13 and later) and arm64 (macOS 14 and later). GHW waveforms open in gtkwave. |
   | eda-ngspice | `sudo port install eda-ngspice46 eda-ngspice47` | Versioned and coexisting. Pick one with `sudo port select --set eda-ngspice eda-ngspice47`. Each stays callable as `eda-ngspice46` / `eda-ngspice47`. See the eda-ngspice notes. |
   | openEMS (python) | `sudo port install py313-openems` | Octave-free EM solver. Pulls in eda-vtk, CSXCAD, openEMS and py313-csxcad. |
   | eda-cace | `sudo port install eda-cace` | Analog characterization (`cace`, `cace-web`). An application port on py312; pulls in `py-ciel`. Set `PDK_ROOT` at run time. See the CACE notes. |
   | nec2c | `sudo port install nec2c` | NEC-2 method-of-moments antenna simulation, command line (`nec2c -i in.nec -o out.txt`). The stock `xnec2c` GUI doesn't replace it; see the nec2c notes. |
   | py-ciel | `sudo port install py-ciel` | PDK version manager that succeeds volare; installs `ciel`. Also a dependency of eda-cace. |
   | eda-freecad | `sudo port install eda-freecad` | FreeCAD 1.1.3 for enclosures (KiCad StepUp). Pulls in `eda-coin`, `eda-pivy`, `py312-pyside6`, plus `vtk`, `libmed` and `boost181`. Build PySide6 with `-addonmodules`. No boost gate needed, because it uses boost181. Builds and runs; see the FreeCAD notes. |
   | openroad / openroad-ll | see below | RTL-to-GDS place and route. `boost spdlog protobuf3-cpp OpenSTA` must be deactivated while it builds. |
   | kicad | see below | Full EDA suite plus libraries. `boost` must be deactivated while it builds. Simulates on whichever eda-ngspice version is selected (46 by default). |
   | trilinos-charon / charon | see below | TCAD. `trilinos16` must be deactivated while they build. |

   Installing `OpenSTA` pulls in the local `cudd` port automatically.

### Ports you have to deactivate things for

MacPorts can't do these for you, and the build fails without them.

If a build has already failed because you missed one, run
`sudo port clean <port>` before trying again. The CMake cache left in the work
directory remembers the shadowed include paths, so it repeats the failure even
after you deactivate.

- openroad and openroad-ll hit four header-shadowing problems, covered in the
  openroad notes below. If you miss one, both Portfiles stop early and print
  these instructions:
  ```
  sudo port -f deactivate boost spdlog protobuf3-cpp OpenSTA
  sudo port install openroad         # and/or openroad-ll; ~40 min each
  sudo port activate boost spdlog protobuf3-cpp OpenSTA
  ```
- kicad conflicts with the umbrella `boost` port while it builds:
  ```
  sudo port -f deactivate boost
  sudo port install kicad            # long build; pulls symbols/footprints/3D/templates
  sudo port activate boost
  ```
- charon and trilinos-charon get shadowed by `trilinos16`'s headers in
  `${prefix}/include`. Trilinos 16's `Teuchos_any.hpp` is C++17-only and breaks
  charon's C++14 compile, and its stub `mpi.h` hides openmpi's. Both Portfiles
  stop early with instructions if you miss it:
  ```
  sudo port -f deactivate trilinos16
  sudo port install charon           # or trilinos-charon
  sudo port activate trilinos16       # rev-upgrade usually re-activates it anyway
  ```

The X11 GUI tools (`xschem`, `magic`, `netgen-lvs`, `xcircuit`) need a running
X server, so install XQuartz (see the xschem notes). `klayout` (Qt6) and
`skim-app` are native Cocoa and don't.

## Report failures on GitHub, not to MacPorts

Every port here includes the tree's own `eda-github` PortGroup
(`_resources/port1.0/group/eda-github-1.0.tcl`). When a standard phase fails
(fetch, checksum, extract, patch, configure, build, destroot or test), it prints
a banner asking you to report the problem at
<https://github.com/bpdegnan/macportseda/issues>, and not to file a MacPorts
trac ticket. These ports aren't in the official tree, and the MacPorts
maintainers shouldn't be bothered with them.

A few details:

- The final `Follow https://guide.macports.org/#project.tickets ...` line comes
  from the `port` client itself on any failure. A Portfile can't suppress it,
  so the GitHub banner appears just above it.
- If a Portfile overrides a phase with its own body (a custom `destroot {}`,
  say), that phase skips the wrapped default, so a failure inside it doesn't get
  the banner. The pre-build checks in the openroad and charon families print
  their own instructions anyway.
- `port lint` reports "Line 4 has unrecognized PortGroup" for every port. Lint
  only knows the default tree's PortGroups, not local ones. It's cosmetic:
  parsing, indexing and building all work.

## The distfiles archive

`distfiles/` holds a copy of every source tarball the ports here fetch.

### Where the tarballs come from

| Port | Upstream source |
|------|-----------------|
| OpenSTA | [parallaxsw/OpenSTA @ 87ce568](https://github.com/parallaxsw/OpenSTA/archive/87ce5680dfa92aa98f07b587df5deb032f6593af/OpenSTA-87ce5680dfa92aa98f07b587df5deb032f6593af.tar.gz) (no upstream tags) |
| cudd | [cuddorg/cudd 3.0.0](https://github.com/cuddorg/cudd/archive/refs/tags/3.0.0.tar.gz) |
| netgen-lvs | [RTimothyEdwards/netgen 1.5.321](https://github.com/RTimothyEdwards/netgen/archive/refs/tags/1.5.321.tar.gz) |
| klayout | [KLayout/klayout v0.30.9](https://github.com/KLayout/klayout/archive/refs/tags/v0.30.9.tar.gz) |
| gtkwave | [SourceForge gtkwave 3.3.117](https://downloads.sourceforge.net/project/gtkwave/gtkwave-3.3.117/gtkwave-3.3.117.tar.gz) |
| openvaf | [OpenVAF/OpenVAF-Reloaded @ 3369a83](https://github.com/OpenVAF/OpenVAF-Reloaded/archive/3369a83f9c626f6d298f9f881379f561ce432e27/OpenVAF-Reloaded-3369a83f9c626f6d298f9f881379f561ce432e27.tar.gz) (mob commit, past the v24.0.1mob tag) + pinned crates from [crates.io](https://static.crates.io/crates/) + the [pascalkuthe/salsa](https://github.com/pascalkuthe/salsa) fork (all listed in the Portfile) |
| yosys | [YosysHQ/yosys v0.66 `yosys-src.tar.gz`](https://github.com/YosysHQ/yosys/releases/download/v0.66/yosys-src.tar.gz) (release asset, bundles ABC) |
| sby | [YosysHQ/sby @ d3e72d2](https://github.com/YosysHQ/sby/archive/d3e72d26e8634bca4ca16f3e4d84331481f06ab6/sby-d3e72d26e8634bca4ca16f3e4d84331481f06ab6.tar.gz) |
| netlistsvg | [npm netlistsvg 1.0.2](https://registry.npmjs.org/netlistsvg/-/netlistsvg-1.0.2.tgz) + 70 pinned npm dep tarballs from registry.npmjs.org (all listed in the Portfile; no npm at build time) |
| sv2v | [zachjs/sv2v v0.0.13](https://github.com/zachjs/sv2v/archive/v0.0.13/sv2v-0.0.13.tar.gz) + 10 pinned Hackage tarballs from [hackage.haskell.org](https://hackage.haskell.org/) (listed in the Portfile; no network/index at build time) |
| eqy / mcy | [YosysHQ/eqy v0.66](https://github.com/YosysHQ/eqy/archive/v0.66/eqy-0.66.tar.gz), [YosysHQ/mcy v0.66](https://github.com/YosysHQ/mcy/archive/v0.66/mcy-0.66.tar.gz) |
| cvc-rv | [d-m-bailey/cvc v1.1.7](https://github.com/d-m-bailey/cvc/archive/v1.1.7/cvc-1.1.7.tar.gz) |
| irsim | [opencircuitdesign.com 9.7.117](http://opencircuitdesign.com/irsim/archive/irsim-9.7.117.tgz) |
| py-gdstk | [PyPI gdstk 1.0.0](https://files.pythonhosted.org/packages/source/g/gdstk/gdstk-1.0.0.tar.gz) |
| ghdl | [ghdl/ghdl v5.1.1 prebuilt](https://github.com/ghdl/ghdl/releases/tag/v5.1.1). Per-architecture release assets: `ghdl-llvm-5.1.1-macos13-x86_64.tar.gz` and `ghdl-llvm-5.1.1-macos14-aarch64.tar.gz` (archive both) |
| eda-vtk | [Kitware/vtk v9.6.2](https://github.com/Kitware/vtk/archive/v9.6.2/vtk-9.6.2.tar.gz) (same distfile as stock vtk) |
| eda-ngspice46 / eda-ngspice47 | [ngspice 46](https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/old-releases/46/ngspice-46.tar.gz) and [ngspice 47](https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/47/ngspice-47.tar.gz). SourceForge moves a release into `old-releases/` once a newer one ships, so both Portfiles list both paths. Shared `dist_subdir eda-ngspice` |
| CSXCAD (+ py313-csxcad) | [thliebig/CSXCAD @ f5e4764](https://github.com/thliebig/CSXCAD/archive/f5e47643a28d6efd42cc10b61b848903e6599581/CSXCAD-f5e47643a28d6efd42cc10b61b848903e6599581.tar.gz) (stock MacPorts pin) |
| openEMS (+ py313-openems) | [thliebig/openEMS @ 32c5c6b](https://github.com/thliebig/openEMS/archive/32c5c6b537b33a8b70f9ba4f5c9a8ecbb12777b3/openEMS-32c5c6b537b33a8b70f9ba4f5c9a8ecbb12777b3.tar.gz) (stock MacPorts pin) |
| eda-or-tools | [google/or-tools v9.14 prebuilt macOS](https://github.com/google/or-tools/releases/download/v9.14/or-tools_x86_64_macOS-15.5_cpp_v9.14.6206.tar.gz) |
| eda-lemon | [lemon.cs.elte.hu 1.3.1](https://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz) (404s; falls back to a [Spack mirror](https://mirror.spack.io/_source-cache/archive/71/71b7c725f4c0b4a8ccb92eb87b208701586cf7a96156ebd821ca3ed855bad3c8.tar.gz), keyed by sha256) |
| eda-fmt | [fmtlib/fmt 12.1.0](https://github.com/fmtlib/fmt/archive/12.1.0/fmt-12.1.0.tar.gz) |
| eda-spdlog | [gabime/spdlog v1.16.0](https://github.com/gabime/spdlog/archive/v1.16.0/spdlog-1.16.0.tar.gz) |
| openroad | [OpenROAD 26Q3](https://github.com/The-OpenROAD-Project/OpenROAD/archive/26Q3/OpenROAD-26Q3.tar.gz) + vendored pins: [its OpenSTA fork](https://github.com/The-OpenROAD-Project/OpenSTA/archive/8572175ac45c42ce8d3d772f73bbb059786b9c66.tar.gz), [abc](https://github.com/The-OpenROAD-Project/abc/archive/d527cfab4ad731b767ea0a2be2021d920d3afece.tar.gz), sv-elab (ex yosys-slang; repo renamed 2026-07, tarball checksums changed)/slang (commits in Portfile) |
| openroad-ll | [OpenROAD @ dcf3613](https://github.com/The-OpenROAD-Project/OpenROAD/archive/dcf36133a369abc8f3c5e5738cd4d82e4903c0e0.tar.gz) (LibreLane's validated rev) + matching vendored pins (see Portfile) |
| xcircuit | [opencircuitdesign.com 3.10.30](http://opencircuitdesign.com/xcircuit/archive/xcircuit-3.10.30.tgz) |
| gtksheet | [fpaquet/gtksheet V4.3.14](https://github.com/fpaquet/gtksheet/archive/V4.3.14/gtksheet-4.3.14.tar.gz) |
| xschem | [SourceForge xschem 3.4.6](https://downloads.sourceforge.net/xschem/xschem-3.4.6.tar.gz) |
| lepton-eda | [lepton-eda 1.9.18 dist tarball](https://github.com/lepton-eda/lepton-eda/releases/download/1.9.18-20220529/lepton-eda-1.9.18.tar.gz) (release asset) |
| iverilog | [steveicarus/iverilog s20250103](https://github.com/steveicarus/iverilog/archive/s20250103/iverilog-20250103.tar.gz) |
| verilator | [verilator/verilator v5.028](https://github.com/verilator/verilator/archive/refs/tags/v5.028.tar.gz) |
| magic | [opencircuitdesign.com 8.3.660](http://opencircuitdesign.com/magic/archive/magic-8.3.660.tgz) |
| trilinos16 | [Trilinos 16.1.0](https://github.com/trilinos/Trilinos/archive/trilinos-release-16-1-0/Trilinos-trilinos-release-16-1-0.tar.gz) |
| xyce | [xyce.sandia.gov Xyce 7.9](https://xyce.sandia.gov/files/xyce/Xyce-7.9.tar.gz) |
| trilinos-charon | [Trilinos 13.4.0](https://github.com/trilinos/Trilinos/archive/trilinos-release-13-4-0/Trilinos-trilinos-release-13-4-0.tar.gz) |
| charon | [sandia.gov charon v2.2](https://www.sandia.gov/app/uploads/sites/106/2022/06/charon-distrib-v2_2.tar.gz) (fragile uploads URL) + [Trilinos 13.4.0](https://github.com/trilinos/Trilinos/archive/refs/tags/trilinos-release-13-4-0.tar.gz) |
| kicad | [gitlab kicad 10.0.4](https://gitlab.com/kicad/code/kicad/-/archive/10.0.4/kicad-10.0.4.tar.bz2) + library subports from [gitlab.com/kicad/libraries](https://gitlab.com/kicad/libraries) (symbols/footprints/packages3D/templates, same 10.0.4 tag) |
| py-pcpp | [PyPI pcpp 1.30](https://files.pythonhosted.org/packages/source/p/pcpp/pcpp-1.30.tar.gz) |
| py-zstandard | [PyPI zstandard 0.25.0](https://files.pythonhosted.org/packages/source/z/zstandard/zstandard-0.25.0.tar.gz) |
| py-volare | [PyPI volare 0.20.6](https://files.pythonhosted.org/packages/source/v/volare/volare-0.20.6.tar.gz) |
| py-ciel | [PyPI ciel 2.6.1](https://files.pythonhosted.org/packages/source/c/ciel/ciel-2.6.1.tar.gz) |
| nec2c | [KJ7LNW/nec2c v1.3.3](https://github.com/KJ7LNW/nec2c/archive/v1.3.3/nec2c-1.3.3.tar.gz) |
| eda-cace | [PyPI cace 2.11.0](https://files.pythonhosted.org/packages/source/c/cace/cace-2.11.0.tar.gz) |
| eda-coin | [coin3d/coin v4.0.10 `coin-4.0.10-src.tar.gz`](https://github.com/coin3d/coin/releases/download/v4.0.10/coin-4.0.10-src.tar.gz) (release asset, not the git archive) |
| eda-pivy | [coin3d/pivy 0.6.11](https://github.com/coin3d/pivy/archive/0.6.11/pivy-0.6.11.tar.gz) |
| eda-freecad | [FreeCAD 1.1.3 `freecad_source_1.1.3.tar.gz`](https://github.com/FreeCAD/FreeCAD/releases/download/1.1.3/freecad_source_1.1.3.tar.gz) (release asset, 98 MB, flat tarball) |
| openscad | [openscad/openscad @ 81ade7d](https://github.com/openscad/openscad/archive/81ade7d33a8ed14fc6817a1cf0d44334592bb9fc/openscad-81ade7d33a8ed14fc6817a1cf0d44334592bb9fc.tar.gz) (the commit of dev-snapshot tag `openscad-2026.10-TEST3`; pinned by commit because upstream deletes its TEST tags, 26 MB) + four vendored submodule archives pinned at that commit: [manifold @ 0edd9d5](https://github.com/elalish/manifold/archive/0edd9d54876f3135e431575214dd6d8a72866fee/manifold-0edd9d54876f3135e431575214dd6d8a72866fee.tar.gz) (31 MB), [Clipper2 @ c7f820f](https://github.com/AngusJohnson/Clipper2/archive/c7f820f6a03fa91f189b866d27bf40dfe47abaa6/Clipper2-c7f820f6a03fa91f189b866d27bf40dfe47abaa6.tar.gz), [sanitizers-cmake @ bcb1fc6](https://github.com/arsenm/sanitizers-cmake/archive/bcb1fc68616e9645ca5acea2992412606373ab04/sanitizers-cmake-bcb1fc68616e9645ca5acea2992412606373ab04.tar.gz), [MCAD @ 1ea4022](https://github.com/openscad/MCAD/archive/1ea402208c3127ffb443931e9bb1681c191dacca/MCAD-1ea402208c3127ffb443931e9bb1681c191dacca.tar.gz). The GitHub source archive has no submodules, so each is fetched separately and moved into place in `post-extract` |
| py-pyside6 | [Qt `pyside-setup-everywhere-src`](https://download.qt.io/official_releases/QtForPython/pyside6/) (same distfile as the stock port; version tracks `qt6.version`) |
| py-cxxheaderparser | [PyPI cxxheaderparser 1.9.1](https://files.pythonhosted.org/packages/source/c/cxxheaderparser/cxxheaderparser-1.9.1.tar.gz) |
| skim-app | [SourceForge Skim 1.7.15](https://downloads.sourceforge.net/project/skim-app/Skim/Skim-1.7.15/Skim-1.7.15.dmg) (prebuilt .dmg) |

The URLs come from the Portfiles via `port distfiles <port>`. The checksums in
the Portfiles are the source of truth.

## macOS 15 (Sequoia) notes

The whole tree builds on macOS 15.3 / Xcode 16.2, with these caveats.

- Dependency variants. A Portfile can't force variants on its dependencies,
  and the macOS 15 defaults differ from the ones on the other machine (macOS
  13). Before building the X11 GUI ports, make sure of these:
  ```
  sudo port upgrade --enforce-variants tk +x11 -quartz     # xschem needs X11 Tk
  sudo port install gtk2 +quartz                            # gtkwave needs quartz gtk2
  ```
  Don't pass `-x11` when enforcing `gtk2 +quartz`. `--enforce-variants` applies
  the requested variants to the whole dependency tree, so it strips the x11
  backend out of `cairo` and `pango`. That silently breaks every X11 port you've
  already built (xschem dies with
  `Symbol not found: _cairo_xlib_surface_create`). `cairo` and `pango` have to
  stay `+quartz+x11`; both backends coexist in one library. If they get
  switched, reactivate the fat builds, for example
  `sudo port -f activate cairo @1.18.4_2+quartz+x11`.
- xcircuit needed a real fix, which is in-tree. Xcode 16's clang turns
  implicit-function-declaration and int-conversion into hard errors, so the
  Portfile appends `-Wno-error=` for both. On older clang they do nothing.
- gcc13 from the binary packages is broken with CLT 16.2 (SDK 15.2). Its
  fixincluded `_stdio.h` refers to `_bounds.h`, which only exists in SDK 15.4
  and later. Any plain gcc C compile fails with
  `fatal error: _bounds.h: No such file or directory`. That hits the
  `trilinos-charon` and `charon` builds, whose C compiler is gcc13 via openmpi.
  Either rebuild gcc13 against the local SDK (`sudo port -N -s upgrade --force
  gcc13`) or update the Command Line Tools to 16.3 or later. `trilinos16` and
  `xyce` aren't affected: they use Apple clang for C/C++ and gcc13 only for
  Fortran.
- gtkwave builds, but gtk2-quartz can't even print `--version` without a window
  server, so you can't smoke-test it over SSH. Check it from a local GUI
  session.

## LibreLane / OpenLane 2 notes (RTL-to-GDS flow driver)

- Use LibreLane, not the `openlane` PyPI package. OpenLane 2 stopped at 2.3.x
  when Efabless shut down. LibreLane, from the same lead developer, carries it
  on and is the one that works with current tools. `openlane` 2.3.10 hard-codes
  the old boost::python pyosys API and the pre-OpenSTA-3 `sta::corners` Tcl,
  and both are dead ends with 2026 tools.
- I run it natively. Upstream only supports Nix and Docker, but native works and
  I've checked it end to end. The `librelane` wrapper script in `~/.local/bin`
  runs a uv venv (`~/.venvs/librelane`, Python 3.12, `pip install librelane`)
  with the MacPorts tools on PATH. The `spm` example runs the full 80-stage flow
  to GDS with 0 magic DRC, 0 klayout DRC and 0 netgen LVS errors.
- What native mode needed (all of it in this tree or in the wrapper):
  - The `openroad-ll` port. This is OpenROAD pinned to the revision LibreLane
    validated (2026-02-17), in the private prefix `libexec/openroad-ll`. The
    tag-tracking `openroad` port (26Q3) has confirmed upstream regressions
    against the flow: the resizer inserts so many buffers that utilization goes
    past 100% (librelane#944 / OpenROAD#10622), and I/O pins get placed outside
    the die. It has the same build gates as `openroad` (deactivate
    `boost spdlog protobuf3-cpp OpenSTA` to build).
  - The `yosys +pyosys` variant. LibreLane runs synthesis as Python scripts via
    `yosys -y`, so yosys needs its pybind11 Python bindings. The new
    `py-cxxheaderparser` port is a build dependency. Python is pinned to 3.12 to
    match the venv, because the embedded interpreter imports `click` from it
    through PYTHONPATH.
  - magic bumped to 8.3.660, which is nix-eda's pin. 8.3.508 lacks the `units`
    command that the magic scripts use. It needs `gsed` for its GNU sed depend
    rule.
  - The wrapper's PATH order matters. The venv's bin comes first: LibreLane's
    klayout steps export the venv's sys.path as PYTHONPATH and then call plain
    `python3`, which has to resolve to the venv's 3.12, or the standard library
    versions cross and you get "SRE module mismatch". Then
    `libexec/openroad-ll/bin`, then `/opt/local/bin`.
- PDK. On first run, LibreLane's bundled ciel downloads its pinned open_pdks
  sky130A build into `PDK_ROOT` (~/.volare). Don't point it at a raw
  skywater-pdk checkout, which isn't an open_pdks build.
- netgen 1.5.321 and klayout 0.30.9 match LibreLane's pins. Standalone OpenSTA
  isn't involved, because the flow does STA through openroad.
- I skipped OpenLane 1 on purpose. It's Docker- and Makefile-first, it's
  legacy, and LibreLane covers everything I'd use it for.

## cocotb notes (Python testbenches)

- cocotb 2.0, for simulation-based digital verification alongside sby's formal
  checks. The testbenches are Python coroutines driving the MacPorts
  simulators. Like LibreLane it's a Python package, not a port: a uv venv at
  `~/.venvs/cocotb` (Python 3.12, `pip install cocotb pytest`).
- Checked against both installed simulators: a counter testbench passes on
  icarus and on verilator. Remember to put a `` `timescale `` directive in the
  HDL. icarus defaults to 1 s precision and cocotb's Clock errors out.
- I prefer the cocotb 2.x Python runner
  (`cocotb_tools.runner.get_runner("icarus"|"verilator")`), run with
  `~/.venvs/cocotb/bin/python`. A `cocotb-config` shim in `~/.local/bin` covers
  the old Makefile flow.

## Memory compilers (OpenRAM, DFFRAM: venvs, not ports)

These are flow drivers, so like LibreLane and cocotb they're uv venvs with a
wrapper in `~/.local/bin`, not MacPorts ports.

- OpenRAM (`openram myconfig.py`) is a real 6T SRAM macro compiler. The venv is
  at `~/.venvs/openram` (pip `openram`, currently 1.2.48), and the wrapper runs
  the packaged `sram_compiler.py`. It needs `PDK_ROOT` (sky130A) at run time,
  plus MacPorts magic, netgen and klayout for DRC and LVS. sky130 is the target
  it's proven in silicon on. Using it on another process means writing an
  OpenRAM technology directory (bitcell and sense-amp cells plus rules), which
  is real work and tracked separately.
- DFFRAM (`dffram 32x32`) builds flip-flop or latch RAM out of standard cells,
  as a LibreLane plugin. The repo moved to AUCOHL/DFFRAM and needs
  librelane>=2.4. The venv is at `~/.venvs/dffram` with the repo cloned inside
  it, and like the librelane wrapper it puts `libexec/openroad-ll/bin` first on
  PATH. It works on any standard-cell process, so it's the way to get small
  memories (FIFOs, register files, calibration tables) without designing a
  bitcell.
- Rule of thumb: DFFRAM for anything up to a few KB, or on a process without an
  SRAM bitcell; OpenRAM when you need real SRAM density on sky130.

## FreeCAD notes (mechanical enclosures, `eda-freecad`, working)

I want FreeCAD for the mechanical enclosures around the PCBs in this flow,
through the KiCad StepUp workbench. StepUp installs from FreeCAD's Addon
Manager, which is why `BUILD_ADDONMGR=ON` stays on. Stock MacPorts `freecad` is
0.18.5 from 2019, on a dead stack (qt4-mac, python310, PySide1 /
`py-shiboken 1.2.4`, and the old `oce` fork of OpenCASCADE), so it's no use as
a starting point.

It's four ports. Build them bottom-up, in this order:

| Port | What | Status |
|------|------|--------|
| `python/py-pyside6` | vendored stock snapshot + 3 real fixes | builds (6.11.1 on macOS 15, 6.7.3 on macOS 13) |
| `cad/eda-coin` | Coin3D 4.0.10, private prefix | builds and verified (rev 2: Apple OpenGL, not mesa) |
| `cad/eda-pivy` | pivy 0.6.11 against eda-coin, py312 | builds, reports `SIM Coin 4.0.10` |
| `cad/eda-freecad` | FreeCAD 1.1.3, Qt6 + OCCT 7.9 | builds and runs, GUI and .app verified (rev 6; macOS 13 and 15) |

### Two GUI-only bugs

I only found these by actually launching the GUI. The CLI and STEP export never
hit them. Both are fixed.

1. `No module named 'PySide'`. Draft, Measure, Tux and the shaft wizard all
   failed at startup, and StepUp would have broken too. FreeCAD generates a
   `PySide` shim (PySide6 re-exported under the old name) and installs it in a
   different place per platform:
   ```cmake
   if(APPLE AND NOT BUILD_WITH_CONDA)  -> DESTINATION MacOS
   else()                              -> DESTINATION Ext
   ```
   The Apple branch assumes the .app bundle layout, where `MacOS/` is the
   executable directory and is on `sys.path` for free. This port builds with
   `FREECAD_CREATE_MAC_APP=OFF`, and at run time FreeCAD adds
   `libexec/freecad/Ext`, not `MacOS`, so the shim was installed where nothing
   could find it. A `post-destroot` symlink `Ext/PySide → ../MacOS/PySide` fixes
   it.
2. `Mesa: error: GL User Error: glGetString called without a rendering context`.
   Both `eda-coin` and FreeCAD had linked MacPorts mesa's
   `${prefix}/lib/libGL.dylib` instead of Apple's OpenGL. Nothing declared that
   dependency; it got picked up only because the `mesa` port happens to be
   installed. The cause is that the cmake PortGroup passes
   `-DCMAKE_FIND_FRAMEWORK=LAST`. A standalone `FindOpenGL` probe shows it:
   ```
   LAST  -> /opt/local/lib/libGL.dylib            (mesa)
   FIRST -> .../MacOSX.sdk/.../OpenGL.framework   (Apple)
   ```
   `OPENGL_GLU_FOUND` stays YES either way. That matters, because FreeCAD's
   `SetupOpenGL.cmake` otherwise stops with "GLU library not found". The fix,
   in both ports, is to name the framework explicitly:
   ```
   -DOPENGL_gl_LIBRARY=/System/Library/Frameworks/OpenGL.framework
   -DOPENGL_glu_LIBRARY=/System/Library/Frameworks/OpenGL.framework
   ```
   Mesa references across FreeCAD's modules went from about 11 to 0.
   - Don't use `-DCMAKE_FIND_FRAMEWORK=FIRST` for this. It looks like the tidy
     fix, and it does pick Apple's OpenGL, but it broke FreeCAD outright. The
     Command Line Tools ship their own
     `/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9`,
     and searching frameworks first let CMake reach it. Some `FreeCADGui`
     translation units then compiled against Python 3.9 headers while the rest
     used MacPorts 3.12. Python 3.9's `cpython/object.h` has
     `typedef struct bufferinfo {...} Py_buffer;` while 3.12's struct is
     untagged, so the bundled PyCXX mangled names differently from one object
     file to the next, and `freecad` aborted at launch:
     ```
     dyld: symbol not found in flat namespace
       '__ZN2Py19PythonExtensionBase10buffer_getEP10bufferinfoi'
     ```
     (`libFreeCADGui` wanted `bufferinfo*`; `libFreeCADBase` exported
     `Py_buffer*`.) Leaving the PortGroup's `FIND_FRAMEWORK=LAST` alone keeps
     every other lookup, Python above all, untouched. The general rule for this
     tree: never flip `CMAKE_FIND_FRAMEWORK` globally on a port that calls
     `find_package(Python*)`.
   - Don't add `OPENGL_INCLUDE_DIR=<framework>/Headers` either. It makes CMake's
     `try_compile` fail with "Failed to generate test project build system".

The `3DconnexionNavlib.framework` dlopen error at startup was just FreeCAD
probing for the SpaceMouse driver, which isn't installed. It was harmless, but
it's now switched off at build time with upstream's own option
`-DFREECAD_3DCONNEXION_SUPPORT=None` (it accepts `None`, `NavLib`, `Legacy` or
`Both`, and defaults to `NavLib`).

### Launching it

There are three ways, and `port notes eda-freecad` lists them:
`/Applications/MacPorts/FreeCAD.app` (Finder or Dock), `freecad` (the GUI from a
terminal) and `freecadcmd` (headless or scripted).

`post-destroot` builds the bundle by hand, the same way the kicad port does:
`Contents/{MacOS,Resources}`, upstream's `Info.plist` and `.icns`, and a symlink
to the `${prefix}/bin` wrapper. So it sits next to `KiCad/` and `GTKWave.app`,
and `port uninstall` removes it. Upstream's plist declares
`.FCStd`/`.FCMat`/`.FCParam`/`.FCMacro`/`.FCScript` as document types, so
double-clicking a model opens it. Two choices here are deliberate:

- Not `-DFREECAD_CREATE_MAC_APP=ON`. That moves `CMAKE_INSTALL_PREFIX` to
  `<prefix>/FreeCAD.app/Contents`, which relocates the whole verified layout and
  breaks the bin wrappers and the `Ext/PySide` symlink.
- The skeleton's `qt.conf` is not copied. It says `Plugins=lib/qtplugins`, a
  bundle-relative path that doesn't exist in this layout, and it would stop Qt
  finding its Cocoa platform plugin. Only the icons are copied.

The plist is a CMake template, so `NAME_STRING_FROM_CMAKE` and
`VERSION_STRING_FROM_CMAKE` get substituted, and the empty `CFBundleIdentifier`
is set to `org.freecad.FreeCAD` (an empty one upsets LaunchServices).

### Older machines are protected

The 10.13 and 10.15 machines can't be hurt by this. `eda-freecad` stops at
pre-fetch on `os.major < 21` (macOS 11 and older), before installing or changing
anything. I measured that threshold rather than guessing it: the `qt6_info`
PortGroup offers `qt67 {6.7 {24 23 22 21}}` and
`qt64 {6.4 {24 23 22 21 20 19 18}}`, so below os.major 21 the newest Qt 6
available is 6.4. That's too old to pair with the Qt-6.7-era PySide6/Shiboken6
that FreeCAD 1.1.3 requires.

The `py-pyside6` shadow is safe there too. It's narrowed to Python 312 only, so
10.15 keeps stock for every other Python version (see the shadowing note below).
Its fixes also detect the layout instead of assuming it: if the layout is
different, they warn and leave stock behaviour alone rather than fail a build
that would otherwise have worked.

### macOS 13 (Ventura) builds and runs too

eda-freecad rev 2, checked 2026-08 on macOS 13.7.8 / Darwin 22 / x86_64:
`freecadcmd --version` reports `FreeCAD 1.1.3 Revision: 20260725`, the same
scripted 40×30×12 box exports a valid ISO-10303-21 STEP through OpenCASCADE
(volume 14400), `pivy 0.6.11` reports `SIM Coin 4.0.10` to match eda-coin, and
`rev-upgrade` is clean.

It needed two fixes that macOS 15 didn't:

1. The broken Shiboken6 CMake config (FIX 3 in py-pyside6, below).
2. C++20 `<source_location>`. FreeCAD's `src/Base/Exception.h` includes it,
   libc++ only got it in LLVM 16, and the Ventura CLT ships libc++ 15:
   ```
   src/Base/Exception.h:32:10: fatal error: 'source_location' file not found
   ```
   I fixed it the same way as the kicad port: MacPorts clang-19 plus its
   libc++ 19 headers, still linking the system libc++ runtime.
   `std::source_location` compiles down to the `__builtin_source_location`
   intrinsic, so no new runtime symbols are needed. Two libc++ runtimes in one
   process would be an ABI trap, since Qt, OCCT, VTK and PySide6 are all built
   against the system one. This is gated on `${os.major} <= 22` and not
   applied everywhere: macOS 15 works with the stock toolchain and shouldn't
   diverge from it. The threshold comes from evidence. Darwin 22 lacks the
   header, and Darwin 24 builds clean.

Why Ventura is different at all: Qt stops at 6.7.3 there, so `py-pyside6` builds
PySide6 6.7.3 instead of the 6.11.1 used on macOS 15. At 6.7.3 the stock port
emits a broken Shiboken6 CMake config, and `eda-freecad` dies at configure:
```
CMake Error in src/Gui/CMakeLists.txt:
  Imported target "Shiboken6::libshiboken" includes non-existent path
    "/opt/local/include/shiboken6"
```
That's FIX 3 below, and it's why the same tree built on macOS 15 but not on 13.

A one-time migration note: if a py-pyside6 with the broken config is already
active, the port can't rebuild itself. Its own build does
`find_package(Shiboken6)`, finds the bad installed config, and dies with the
same error. Deactivate it first, the same way as the openroad and kicad gates:
```
sudo port deactivate py312-pyside6
sudo port install py312-pyside6 -addonmodules   # reactivates automatically
```

Checked on macOS 15.3 (Sequoia, Darwin 24) / Xcode 16.2 / x86_64, 2026-08:
`freecadcmd --version` reports `FreeCAD 1.1.3 Revision: 20260725`; a scripted
40×30×12 box exports a valid ISO-10303-21 STEP file through OpenCASCADE (volume
14400, as expected); `rev-upgrade` reports no broken files. Still to confirm by
hand, because it needs a window server and can't be done over SSH: the Qt6 GUI
launching, and installing KiCad StepUp from the Addon Manager.

### Four fixes eda-freecad needed to build

None of these were predicted.

1. `port:vtk` is required. `BUILD_FEM=ON` (and `BUILD_MESH_PART`, which defaults
   to ON) forces `FREECAD_USE_SMESH=ON`, and `SetupSalomeSMESH.cmake` then
   requires VTK outright: *"if we use smesh we definitely also need vtk, no
   matter of external or internal smesh"*. The bundled SMESH still needs an
   external VTK, and `BUILD_FEM_NETGEN=OFF` doesn't get around it. MacPorts vtk
   9.6.2 satisfies FreeCAD's preferred `find_package(VTK 9)` path, and its
   config in `lib/cmake/vtk-9.6` matches CMake's default glob, so no `VTK_DIR`
   pin is needed (unlike libfmt11).
2. `port:libmed` is required, and MED is in MacPorts (`libmed` 4.1.1,
   science/devel). I'd assumed it was missing and that MED support would just be
   skipped. It can't be: with the bundled SMESH,
   `find_package(MEDFile REQUIRED)` runs unconditionally, and
   `FindMEDFile.cmake` stops with `med.h not found`.
3. The "Coin3D version mismatches Pivy Coin3D" error is an upstream regex bug,
   not a real mismatch. `SetupCoin3D.cmake` parses `Inventor/C/basic.h` with
   `([0-9?])`, which matches a single character, so Coin 4.0.10's two-digit
   micro version captures only `1` and gives "4.0.1". pivy's version uses a
   correct `([0-9]+)` and gives 4.0.10. Any Coin with a two-digit patch number
   trips this. The parse is guarded by `IF (NOT COIN3D_VERSION)`, so eda-freecad
   passes `COIN3D_VERSION` and the three `COIN3D_*_VERSION` components on the
   command line to skip the broken block. That means no patchfile to keep in
   sync. (`FindMEDFile.cmake` has the same single-digit bug, but nothing
   compares MED's version, so it's harmless.)
4. boost181, not the umbrella `boost`. FreeCAD calls `.contains()` on a
   Boost.MultiIndex `hashed_index` in `src/App/Transactions.cpp` and
   `src/App/DynamicProperty.cpp`. That member doesn't exist in boost 1.76,
   which is what the umbrella `boost` port installs, so the compile died with
   `no member named 'contains' in boost::multi_index::detail::hashed_index<…>`.
   It's there in 1.81 and later (I grepped the headers). The trap is that
   FreeCAD's declared `BOOST_MIN_VERSION` is a stale 1.74, so
   `find_package(Boost 1.74)` happily accepts 1.76 and the failure only shows up
   at compile time.

OpenCASCADE 7.9 needed no changes at all. The OCCT API drift I expected never
showed up.

The install layout: binaries land in `libexec/freecad/MacOS/`, not `bin/`. Even
with `FREECAD_CREATE_MAC_APP=OFF`, FreeCAD keeps its bundle-style layout
(`MacOS/ Ext/ Mod/ lib/ share/ include/`). The names are `FreeCAD` and
`FreeCADCmd`, as you'd expect. The `post-destroot` wrappers point at `MacOS/`
through a single `fc_bindir` variable.

### py-pyside6

`py-pyside6` is vendored here with three real fixes, and I'm keeping the shadow
on purpose. I decided that in 2026-08, after diffing against current stock at
6.11.1. Stock still has a real bug: it points both PySide6 symlinks at
`libpyside6.abi3*`, so `lib/libpyside6qml.abi3.dylib` resolves to the wrong
library. Ours points the qml one at `libpyside6qml.abi3*`. That bug doesn't
depend on the version, so it won't go away on its own. The other two fixes
(`xinstall -d`, and the llvm PATH fix) do nothing when the problem they fix isn't
present, so carrying them costs nothing and removes a latent trap. The PATH fix
in particular keeps the port working if `port select clang` is ever pointed at
another major version. The snapshot tracks stock's version (6.11.1 here), so
the fork doesn't hold anything back. Don't swap back to stock just to drop a
fork: the fixes are cheap and the bug is real.

The three fixes:

1. `post-destroot` symlinks into `PySide6/lib/` and `shiboken6/lib/`, but
   PySide6 6.7.3 never creates those directories, so destroot died with
   `symlink: .../PySide6/lib/libpyside6.abi3.dylib: no such file or directory`.
   `xinstall -d` first fixes it, and does nothing where the directories already
   exist. Stock also points both PySide6 symlinks at `libpyside6.abi3*`; the qml
   one now correctly points at `libpyside6qml.abi3*`.
2. Shiboken's ApiExtractor loads libclang from `LLVM_INSTALL_DIR`, but then runs
   a bare `clang++` from PATH. If `port select clang` points at a different
   major version, that binary crashes in dyld with
   `Symbol not found: llvm::RISCVISAInfo::printEnabledExtensions` (present in
   libLLVM 19, missing in 18), and every module then fails with
   `'type_traits' file not found` / `Error running ApiExtractor`. Putting the
   matching `llvm-N/bin` first on the build PATH fixes it, so the port no longer
   depends on `port select` at all.
3. Broken include directories on the imported targets. This is what blocks
   macOS 13. The stock reinplaces that are meant to relocate the include
   directories match `${_IMPORT_PREFIX}/<dir>/include`, but the real content is
   `${_IMPORT_PREFIX}/include/<dir>`. The components are reversed, so the
   reinplaces never fire. The imported targets keep pointing at
   `${prefix}/include/{shiboken6,PySide6}`, which the port never creates, and
   any CMake consumer fails at configure. On top of that, the shiboken headers
   install under `shiboken6_generator/include`, not `shiboken6/include`, so
   stock's `shiboken6.pc` `includedir` is wrong for the same reason. Ours looks
   for `shiboken.h` instead of hardcoding a path. And, which matters on the older
   machines, if it can't find it, it warns and leaves the stock paths alone
   rather than fail a build that would otherwise have worked.

The shadow covers Python 312 only (stock declares 310 to 314). This matters,
because stock `py-pyside6` has real users at other versions: `py313-pyside6` for
py313-pyside6-fluent-widgets and -frameless-window, and `py314-pyside6` for
cutter-rizin, ghost-downloader and those widget ports. Declaring only 312 means
our index holds just `py-pyside6` and `py312-pyside6`, so py313 and py314
requests fall through to stock (checked with `port file`). Each Python version
installs into its own site-packages, so there's no file conflict either. Keep
this in step with eda-pivy's and eda-freecad's `py_ver`, and re-check that
list of dependents before widening it.

Why not an `eda-pyside6` private-prefix port? The `eda-` pattern works for
`eda-coin`, a plain C++ library, but not for a Python binding layer.
PySide6/shiboken6 have to be importable by the exact python312 that FreeCAD
embeds and also discoverable through `${prefix}/lib/cmake`. A private prefix
needs PYTHONPATH injection and risks two copies of the PySide6 C extension in one
process (duplicate type objects, crashes). Renaming it while keeping the install
location just swaps a harmless substitution for hard file conflicts. Narrowing
the version range is cheaper and safer.

Always build PySide6 with `-addonmodules`. The addon set pulls in
`qt67-qtwebengine` (a full Chromium build) plus `llvm-22`/`clang-22`: 38 extra
ports instead of 1. FreeCAD only needs the base modules, hence `-DBUILD_WEB=OFF`
in eda-freecad.

### Other things worth knowing

- Coin3D 4 is mandatory and has to match pivy. FreeCAD has no minimum Coin
  version check, but it stops with
  `"Coin3D version X mismatches Pivy Coin3D Y"`, so `eda-pivy` must be built
  against `eda-coin`, and both must use the same Python as `eda-freecad`
  (currently 3.12; the `py_ver` variable is at the top of both Portfiles). Stock
  `coin`/`Coin-framework` is 3.1.3 from 2010, which predates the Coin 4 API that
  FreeCAD 1.x uses, so Coin 4 goes in `libexec/eda` and stock is left alone.
  `eda-pivy` turns off `find_package(SoQt)`: the only MacPorts SoQt is built
  against Coin 3.1.3 and would mix two Coin ABIs in one extension.
- fmt would otherwise be downloaded in the middle of the build.
  `SetupLibFmt.cmake` contacts github.com and FetchContents fmt 11.1.4 if
  `find_package(fmt)` misses, and MacPorts puts fmt's CMake config in a
  versioned subdirectory that isn't on the default search path. OpenSTA had the
  same problem. The fix is `-Dfmt_DIR=${prefix}/lib/libfmt11/cmake/fmt`.
- These are bundled in the source drop and used as is: OndselSolver,
  salomesmesh, zipios++, PyCXX, libE57Format, GSL, json, libkdtree. Don't flip
  the `FREECAD_USE_EXTERNAL_*` switches without adding matching ports.
- eda-freecad doesn't need a boost gate. It uses versioned boost181 with
  `Boost_NO_SYSTEM_PATHS` plus explicit `Boost_DIR`/`BOOST_ROOT` (the same
  recipe openroad uses), so the umbrella `boost` can stay active while it builds,
  and it can share a session with `openroad`/`kicad`. Those two still need the
  umbrella deactivated for their own builds.
- The target is macOS 14+ (Sonoma) / x86_64. On macOS 13, expect Qt to stop at
  6.7.3 ("Qt 6.8 is not supported on macOS 13") and the libc++ 15 C++20 wall. If
  you hit it, apply the kicad/openroad recipe (`macports-clang-19` +
  `-nostdinc++ -isystem ${prefix}/libexec/llvm-19/include/c++/v1`), conditional
  on `${os.major}`.

## openscad notes (script-based 3D CAD, dev snapshot, shadows stock)

OpenSCAD describes solids in its own language instead of having you draw them,
which makes it a natural companion to `eda-freecad` for parametric PCB
enclosures. FreeCAD's OpenSCAD workbench runs it as an external program, so
the two only meet through the binary and file formats. No shared libraries, and
no version coupling between them.

### Why this port shadows the stock one

Stock MacPorts openscad is 2021.01. That really is upstream's newest stable
release; their cadence is that slow. It needs the old cgal4, which conflicts
with the cgal6 that CSXCAD and openEMS pull in. On any machine with this tree's
EM chain installed, stock openscad can't be installed at all:

```
Error: Can't install cgal4 because conflicting ports are active: cgal6
```

Current OpenSCAD wants CGAL >= 5.0 with no upper bound, so pinning one of
upstream's own dev snapshots builds against the cgal6 that's already there.
Nothing in MacPorts depends on openscad, so taking the name is safe, and
`port install openscad` gets the one that actually installs. This tree does the
same for magic, verilator and openEMS.

### Pinned by commit, because upstream deletes its snapshot tags

The port was first pinned to `openscad-2026.01.01-TEST2`. By 2026-10 upstream
had deleted that tag (and every `2026.01.01-TEST*`), the archive URL returned
404, and a fresh `port install openscad` couldn't fetch. It now pins
`openscad-2026.10-TEST3` by the commit that tag points to (`81ade7d3`, on
`master`), and that archive URL keeps working even if the tag goes away.
`version` is `2026.10`, the snapshot date without `-TESTn` (hyphens in a
MacPorts version are best avoided). When bumping again, get the commit from
`gh api repos/openscad/openscad/git/ref/tags/<tag>` and the submodule SHAs from
`contents/submodules?ref=<tag>`.

### How it's built

- The submodules are vendored as pinned distfiles. GitHub's source archive has
  no submodules in it, so manifold, Clipper2, sanitizers-cmake and MCAD are
  fetched as their own checksummed tarballs, at the SHAs recorded for that tag,
  and moved into place in `post-extract`. `openroad` uses the same pattern.
  OpenCSG and mimalloc aren't vendored: `USE_BUILTIN_OPENCSG` defaults to OFF,
  and `submodules/CMakeLists.txt` tries `find_package(mimalloc QUIET)` first, so
  both come from MacPorts ports.
- Versioned boost, spelled out. boost181 lives in `libexec/boost/1.81`, which
  `find_package(Boost ...)` can't find on its own, so `Boost_DIR`, `BOOST_ROOT`
  and `Boost_NO_SYSTEM_PATHS` are all set. As with `eda-freecad`, this also
  keeps the port clear of the boost-deactivation gate that `openroad` and
  `kicad` need, so the umbrella `boost` can stay active.
- It needs qscintilla-qt6, not the qt5 flavour the stock port uses; CMakeLists
  does `find_package(Qt6QScintilla 2.8.0 REQUIRED)`. Installing the port isn't
  enough, though. OpenSCAD's bundled `FindQt6QScintilla.cmake` hints
  `find_library` with `${Qt6Widgets_LIBRARIES}`, which is a CMake target name
  (`Qt6::Widgets`), not a path, so it never looks under `libexec/qt6` where
  MacPorts keeps Qt. The library is there and correctly named; it just never
  gets looked for in the right place. So `QT6QSCINTILLA_LIBRARY` and
  `QT6QSCINTILLA_INCLUDE_DIR` are passed in directly.
- The mesa trap again, the same one `eda-coin` and `eda-freecad` hit. The cmake
  PortGroup passes `-DCMAKE_FIND_FRAMEWORK=LAST`, so with mesa installed,
  `find_package(OpenGL)` reports `/opt/local/lib/libGL.dylib` and leaves
  `-framework OpenGL` off the link line. That only blows up at the very end,
  after a 100% compile, because OpenSCAD's macOS offscreen context uses CGL and
  mesa has no CGL symbols:

  ```
  ld: Undefined symbols: _CGLChoosePixelFormat, _CGLCreateContext, ...
    referenced from CreateOffscreenContextCGL(...) in OffscreenContextCGL.cc.o
  ```

  The fix is to name `OpenGL.framework` explicitly through `OPENGL_gl_LIBRARY`
  and `OPENGL_glu_LIBRARY`. Set only those two; adding
  `OPENGL_INCLUDE_DIR=<framework>/Headers` makes CMake's `try_compile` fail.
- Also turned off here: `ENABLE_TESTS`, `ENABLE_GUI_TESTS` and `MANIFOLD_TEST`
  (all default to ON, and would run upstream's very large test suite as part of
  the build), and `ENABLE_GAMEPAD` (defaults to AUTO, but its Qt5Gamepad driver
  doesn't exist under Qt6, and CMake errors out on that combination).
  `SNAPSHOT=ON` matches what this tag is and picks the nightly icon set, so the
  app looks different from a stable release.
- New in the TEST3 bump: manifold's parallel backend makes TBB effectively
  required (`find_package(TBB QUIET)` falls back to a `REQUIRED` pkg-config
  check), so `port:onetbb` is declared instead of linking whatever copy happens
  to be around. `ENABLE_HIDAPI` and `ENABLE_SPNAV` (3D-mouse input drivers)
  default to `AUTO` and would link a stray libhidapi or libspnav, so both are
  pinned OFF, and so is `USE_CCACHE`. Every other configure switch carried over
  unchanged, and the macOS install layout (`.app` in `bin/`) is the same, so
  `post-destroot` still applies.

### The install layout

On macOS, upstream's install puts an `.app` inside `bin/` and installs no
`openscad` command. The Apple branch of CMakeLists does only
`install(TARGETS OpenSCADExe BUNDLE DESTINATION ${CMAKE_INSTALL_BINDIR})`. The
man page, colour schemes, examples, fonts, MCAD, locale, shaders and templates
all go inside the bundle's Resources instead of `${prefix}/share`. So
`post-destroot` moves the bundle to `/Applications/MacPorts` and puts a
lowercase wrapper on PATH, the same way `kicad` and `eda-freecad` do it. It's a
wrapper rather than a symlink because a bundle finds its Resources relative to
the executable's real path. FreeCAD's OpenSCAD workbench runs an external
binary, so point it at that wrapper under *Edit → Preferences → OpenSCAD*. The
same binary does GUI and CLI; `-o` switches it to rendering
(`openscad -o part.stl part.scad`).

### Status and things to watch

- Verified on both machines, but on the previous `2026.01.01-TEST2` snapshot.
  `2026.10-TEST3` (2026.10_0) hasn't been built yet. The test machines were
  macOS 13 with Qt 6.7.3 and macOS 15 with Qt 6.11, which is what shows the
  `${qt6.dir}` indirection above actually works across Qt versions.
  `openscad --version` reported 2026.08.19, a 40×30×12 enclosure shell rendered
  to a valid STL (16 vertices, 28 facets), the binary linked Apple's
  `OpenGL.framework` rather than mesa, and the `.app` registered with
  LaunchServices as `kMDItemKind = "Application"`.
- Watch out on a machine with a different Qt. `${qt6.dir}` resolves per machine,
  but the qscintilla library filename in `configure.args` is literal. If
  configure fails on `QT6QSCINTILLA_LIBRARY`, check
  `port contents qscintilla-qt6 | grep dylib` and adjust. MacPorts has
  qscintilla 2.14.1 as I write this, which still uses
  `libqscintilla2_qt6.dylib`.
- Stock `OpenCSG` drags in `qt5-qtbase`. The MacPorts `OpenCSG` 1.4.2 port builds
  through the `qmake5` PortGroup and depends on Qt 5. The library itself only
  needs GLEW and GL, but the tarball ships a Qt example app, and there's no
  variant to turn it off. So on a machine without Qt 5, `port install openscad`
  pulls a whole Qt 5 base onto a Qt 6 port. The alternative would be
  `USE_BUILTIN_OPENCSG=ON` plus vendoring `submodules/OpenCSG` (upstream builds
  it with plain CMake, no qmake and no Qt). I haven't done that.

## The mesa / OpenGL trap (tree-wide)

Three ports have hit this now, so here it is once: any CMake port that calls
`find_package(OpenGL)` on a machine where the `mesa` port is installed will
quietly link mesa instead of Apple's OpenGL. The cmake PortGroup passes
`-DCMAKE_FIND_FRAMEWORK=LAST`, so frameworks are searched last and
`${prefix}/lib/libGL.dylib` wins. The symptoms differ, and none of them mention
mesa:

| Port | How it showed up |
|------|------------------|
| `eda-coin` / `eda-freecad` | `Mesa: error: GL User Error: glGetString called without a rendering context` at GUI startup |
| `openscad` | link failure after a 100% compile: `ld: Undefined symbols: _CGLChoosePixelFormat …` (mesa provides no CGL) |

To check a binary, run `otool -L <binary> | grep /opt/local/lib/libGL`. The fix
every time is to name the framework explicitly, and to set only the two
`*_LIBRARY` variables:
```
-DOPENGL_gl_LIBRARY=/System/Library/Frameworks/OpenGL.framework
-DOPENGL_glu_LIBRARY=/System/Library/Frameworks/OpenGL.framework
```
Don't also set `OPENGL_INCLUDE_DIR=<framework>/Headers`, which makes CMake's
`try_compile` fail. And don't "fix" it with `-DCMAKE_FIND_FRAMEWORK=FIRST`. That
does pick Apple's OpenGL, but it also exposes the CLT's own
`Python3.framework/Versions/3.9`, which broke eda-freecad at run time by mixing
Python 3.9 and 3.12 headers in one build. The FreeCAD notes have the details.

## nec2c notes (NEC-2 antenna simulation, command line)

- nec2c is Neoklis Kyriazis' C translation of NEC2, the FORTRAN Numerical
  Electromagnetics Code. It isn't interactive: it reads a standard NEC2 input
  deck and writes a NEC2-format output file. It does method-of-moments for wire
  antennas, which complements this tree's openEMS FDTD solver. The port is
  built from the KJ7LNW continuation (v1.3.3), the same upstream that maintains
  xnec2c.
- The stock MacPorts `xnec2c` port doesn't replace it. xnec2c is the GTK3 GUI,
  and upstream's README says: *"Printing of results to an output file has been
  removed starting from version 1.0 … If printing to file is needed then it is
  better to use the original NEC2 program."* Its `-j<n>` flag is for
  multi-threading, not batch mode. The two complement each other and share no
  files: `sudo port install xnec2c` for the GUI, `nec2c` for scripted work.
  (For the record, stock `xnec2c` is current. 4.4.18 matches upstream's newest
  tag, and the repo is actively maintained.)
- It's called plain `nec2c`, not `eda-nec2c`, because MacPorts has no `nec2c`,
  so nothing collides. Same reasoning as `cvc-rv`, `sv2v` and `ghdl`.
- It's trivial to build. It's pure C with autotools, and the only library it
  wants is `libm` (part of libSystem), so it has no port dependencies at all.
  The GitHub tarball has no generated `configure`, hence `use_autoreconf yes`.
  That supplies autoconf and automake itself; declaring them again makes lint
  warn.
- Run it from a writable directory. nec2c writes a plot side-file
  `<input>.plt` next to the input deck. If you point `-i` at the installed
  examples, it fails partway with
  `nec2c: .../3E_.NEC.plt: Permission denied` and leaves a truncated output
  (geometry only, no antenna parameters or radiation pattern), which is easy to
  mistake for a bad model. Copy the deck first. I checked: 65 lines from the
  read-only path, against 863 lines with both `ANTENNA INPUT PARAMETERS` and
  `RADIATION PATTERN` from a writable one.
- The 108 example decks from the source tree are installed in
  `${prefix}/share/doc/nec2c/examples`. `port test` runs one end to end and
  checks the output for the NEC2 banner.

## CACE notes (analog characterization, `eda-cace` port)

- CACE (Circuit Automatic Characterization Engine, run as `cace design.yaml`)
  drives ngspice or xyce plus magic, netgen and klayout to characterize an
  analog block against a datasheet of parameters, and writes out an annotated
  results datasheet. It's the analog-side flow check, the counterpart to
  LibreLane on the digital side.
- It's a MacPorts port now, `cad/eda-cace` (it used to be a venv).
  `sudo port install eda-cace` puts the `cace` CLI and the `cace-web` Flask GUI
  on PATH. It's named `eda-cace` rather than `py-cace` because it's an
  application, not a reusable library. That makes it an application-style
  Python port: since the name isn't `py-*`, the python PortGroup builds a single
  version at `python.default_version`, with no `pyXY-` subports, and installs
  the console scripts without a suffix. It's pinned to Python 3.12
  (matplotlib's TkAgg backend, and the analog venvs). It needs `PDK_ROOT`
  (sky130A via ciel or installskywater) at run time.
- The `py-ciel` dependency port (`python/py-ciel`) is the only CACE dependency
  MacPorts was missing. Ciel is the FOSSi Foundation's continuation of volare,
  with the same dependencies (click, httpx, pcpp, yaml, rich, zstandard, all
  already present), and like py-volare it installs an unsuffixed `ciel` for the
  default Python. Every other CACE dependency (matplotlib, numpy, Pillow, rich,
  flask, and exactly mpld3 0.5.10) is already in MacPorts.
- Tk is a declared dependency now (`py${v}-tkinter`), because CACE imports
  matplotlib's TkAgg backend unconditionally. In the old venv you had to
  `sudo port install py312-tkinter` by hand, or `cace` died with
  `ModuleNotFoundError: No module named '_tkinter'`.
- The scripts run with `python -s`, because of user-site shadowing. The
  framework python3.12 puts `~/Library/Python/3.12` (a `pip install --user`
  site) on `sys.path` ahead of the MacPorts packages. A stale `--user` click
  7.1.2 there shadows the port's click 8.3.3 and breaks `cace-web`
  (`ImportError: cannot import name 'ParameterSource' from click.core`). The
  port's `post-destroot` adds `-s` to the `cace` and `cace-web` shebangs, so
  they ignore the user site and run against their declared dependencies only.
  If you migrated from the venv, also remove the old wrappers so the port wins
  on PATH: `rm ~/.local/bin/cace ~/.local/bin/cace-web` (they come earlier in
  PATH than `/opt/local/bin`). Think about clearing out the whole
  `~/Library/Python/3.12` `--user` stack too; it shadows every MacPorts
  python3.12 tool, not just cace.
- Installing it is the easy part. The real work is writing a CACE datasheet
  (YAML: parameters, testbenches, limits) for an actual circuit, and that's
  design work.

## OpenSTA notes

- Upstream (`parallaxsw/OpenSTA`) publishes no git tags or releases, so the
  Portfile pins a specific `master` commit. The `version` is the `project()`
  version in `CMakeLists.txt` at that commit. To update, change the commit and
  version in the Portfile, run `port -v checksum OpenSTA`, and paste the values
  it reports into the `checksums` block.
- CUDD support is on by default through the `+cudd` variant, which the sibling
  `cudd` port satisfies. `+cudd` and `+basic` can't be combined. Asking for
  `+basic` overrides the default and builds without CUDD, losing some BDD-based
  optimizations.
- OpenSTA's bundled `FindTCL.cmake` hard-codes Homebrew paths on macOS, so the
  Portfile passes `-DTCL_LIB_PATHS=${prefix}/lib`. Without it the build can't
  find MacPorts' Tcl.
- `tclreadline` (interactive line editing) is in MacPorts (`devel/tclreadline`)
  and off by default; turn it on with `+readline`. Otherwise it's forced off, so
  the build doesn't quietly link an installed tclreadline without declaring the
  dependency.
- It's pinned at `87ce5680` (2026-07-27, the merge of upstream #475) and carries
  nine local patches. Each one is explained in full in a comment just above its
  `patchfiles-append` in the Portfile. None of the bugs was fixed at upstream
  `master` as of 2026-10-06. When you bump the pin, drop any patch that no
  longer applies; that's the sign upstream has fixed it.

  | Patch | What it fixes |
  |---|---|
  | `patch-Network-string-spaceship.diff` | Build fix. `operator<=>` on `std::string` is missing from the libc++ in older macOS SDKs (Ventura CLT); uses `compare()` instead. |
  | `patch-WriteSpice-async-set-reset.diff` | `write_path_spice` left a flop's active-low async set/reset at the tie-low default, which means asserted. The flop never toggles and the deck is useless. Submitted upstream, still open. |
  | `patch-WriteSpice-seq-enable.diff` | `write_path_spice` set only one port of a flop's next-state function, so a data enable was left inactive. Same useless-deck symptom, for enabled flops. Submitted upstream, no response. |
  | `patch-InternalPower-power-lut-axes.diff` | `report_power` kills the session (`STA-0226`) when a `power_lut_template` names its slew axis `input_net_transition`. Accepts both spellings, as the delay tables (`GateTableModel`) always have. |
  | `patch-ArnoldiReduce-null-driver-term.diff` | `set_delay_calculator arnoldi`: a driver pin with no terminal in its net's parasitic network gets used as a wild array offset. That's a SIGSEGV in `report_checks` on large designs and a silently wrong delay on small ones. It now declines to reduce instead. |
  | `patch-LibertyReader-lvf-constraint-spelling.diff` | LVF sigma on setup/hold arcs was silently ignored, because the reader looked for `ocv_*_constraiint` (with a double i). |
  | `patch-POCV-slack-pessimistic-tail.diff` | Under POCV, `report_wns`, `report_tns` and `report_worst_slack` applied sigma with the wrong sign, and `get_property ... slack` ignored it, so a violating design could report clean. Only `report_checks` was right. |
  | `patch-LibertyReader-ccs-slew-axis-spelling.diff` | CCS output-current waveforms were read with slew and load cap swapped when an `output_current_template` names its slew axis `input_transition_time`, giving wrong `ccs_ceff` / `prima` delays with no warning. |
  | `patch-PrimaDelayCalc-pin-not-in-network.diff` | `set_delay_calculator prima`: a SIGSEGV when a driver pin is missing from its net's parasitics, and an unreachable load silently timed at the driver node. It now hands such a net to the table calculator. |

- POCV in OpenSTA 3.x is a run-time mode, not a build option. The statistical
  delay code is always compiled in, and you turn it on with
  `set sta_pocv_mode normal` (or `skew_normal`) plus `sta_pocv_quantile`. The
  2.x command `set_pocv_sigma_factor` is gone, and the commands live in the
  `sta::` namespace, so a global `info commands *pocv*` finds nothing even on a
  build that fully supports it.
- To see which build is active, use `port installed OpenSTA | grep active`, not
  `sta -v`. The version string says `3.1.0` whatever the port revision, so you
  can't tell from it that a rebuild is installed but not activated.

## cudd notes

- Built from the `cuddorg/cudd` `3.0.0` release tag, which is the version
  OpenSTA recommends. It installs `cudd.h` into `${prefix}/include` and
  `libcudd` into `${prefix}/lib`, which is where OpenSTA's `FindCUDD.cmake`
  looks given `-DCUDD_DIR=${prefix}`.
- MacPorts doesn't know about this port until the tree is registered and
  `portindex` has run. Until then `port lint OpenSTA` reports
  `Unknown dependency: cudd`. That's expected and goes away after indexing.

## netgen-lvs notes

- Tim Edwards' netgen (LVS), built from the `RTimothyEdwards/netgen` `1.5.321`
  tag. It's called `netgen-lvs` so it doesn't collide with MacPorts' unrelated
  `math/netgen`, a FEM mesh generator. Install it with `port install netgen-lvs`.
- It needs `tk8-x11`. That was `tk-x11` until MacPorts split Tcl/Tk 8 and 9 in
  2026-07. The old name is now a `replaced_by` stub with no checksums, and
  dependency installs ignore `replaced_by`, so depending on it breaks upgrades.
  netgen-lvs, magic and xcircuit were all moved to `tk8-x11` paths on
  2026-07-09. netgen's Tcl build won't compile without X11, so the X11 Tk gets
  pulled in even though batch LVS never opens a window.
- The build calls the `tcllibrary` and `install-tcl-real` make targets directly.
  netgen's default targets pipe their output through `make.log` and
  `install.log`, which hides it and can mask failures, because they always exit
  0.

## klayout notes

- KLayout (`KLayout/klayout` tag `v0.30.9`), a Qt6 GUI with Ruby and Python
  scripting. It's a long build: about 100 MB of source plus a full Qt link.
- It uses its own `build.sh` (qmake-based), which builds and installs everything
  into one self-contained directory. The Portfile drives the phases by hand:
  `build.sh` stages into `${workpath}` with the final RPATH
  (`${prefix}/lib/klayout`) baked in, and destroot copies the tree into
  `${prefix}/lib/klayout` and symlinks the tools (`klayout`, `strm*`) into
  `${prefix}/bin`.
- The libgit2-based package manager is turned off (`-nolibgit2`) to keep the
  external library surface small. It has nothing to do with layout or DRC.

## py-volare notes (PDK version manager)

- `py-volare` is a Python package. It pulls in two helper ports that MacPorts
  also lacked: `py-pcpp` (pure Python) and `py-zstandard` (builds a C extension
  against its own bundled zstd, so no external dependency). All three build
  311, 312 and 313 subports and default to Python 3.13.
- The `volare` executable is installed as `volare-3.13`. The default-version
  subport also symlinks an unsuffixed `volare` into `${prefix}/bin`.
- You don't really need it if your PDKs are already installed. It's handy for
  pinning PDK versions or fetching new builds.

## openvaf notes (Verilog-A compiler)

- OpenVAF-Reloaded is the maintained community continuation of OpenVAF. Pascal
  Kuthe's original has been unmaintained since the end of 2023. It compiles
  Verilog-A compact device models into OSDI shared libraries for ngspice and
  Xyce. It's written in Rust and uses LLVM.
- It works. `openvaf-r model.va` compiles a Verilog-A model into a
  `model.osdi` Mach-O shared library (checked on a resistor model and a diode
  model).
- Built with the `cargo` PortGroup. The full set of crates.io dependencies (147
  crates) is pinned inline from upstream's `Cargo.lock`. One more dependency,
  `salsa`, is an unpublished git fork (`pascalkuthe/salsa`), pulled in through
  `cargo.crates_github`. A `post-extract` exposes its `salsa-macros` member as
  its own directory-source entry and drops the stray `branch` line the
  PortGroup adds.
- It's pinned to mob commit `3369a83f` (2026-08-01), 44 commits past the
  `v24.0.1mob` tag. That tag is still upstream's newest, but the `mob` branch
  had moved well ahead with fixes worth having: the 2026-07-04 bugfix sweep
  (noise_table crash, `ac_stim` panic, `idt` initial condition, `idtmod`
  wrap/offset, `laplace_nd` feedthrough, whole-array-assignment ICE, array
  lower-bound indexing, `$simparam$str`) and the VAMS-2023 work (repaired
  `ceil`/`hypot`/`$clog2` codegen, `expm1`/`ln1p`, `$min`/`$max`/`$abs`,
  `$rtoi`/`$itor`, named events, dynamic `transition()` tolerances). I compared
  the two directly: the tag rejects `expm1` and `$max` as unknown, and this pin
  compiles them. The oldest tag, `v24.0.0mob`, has 2022-era codegen that
  segfaults while emitting OSDI metadata on LLVM 18. Never pin it.
- The bump was cheap because `Cargo.lock` was byte-identical between the tag and
  mob, so the crate list didn't need regenerating and the salsa revision was
  unchanged. Check that first on any future bump. The Portfile header lists all
  four things to re-check.
- LLVM: the fork supports LLVM 18 to 21, picked by a cargo feature. The Portfile
  uses MacPorts `llvm-18` (`--features llvm18`,
  `LLVM_SYS_181_PREFIX=${prefix}/libexec/llvm-18`) and forces static LLVM
  linking (it flips llvm-sys from `prefer-dynamic` to `force-static`), so
  `openvaf-r` is self-contained. To switch LLVM major version, change
  `--features llvmNN` and `LLVM_SYS_NN1_PREFIX` together.
- Only the CLI driver is built. The installed binary is `openvaf-r`, upstream's
  name. `external/vacask` is a test-only git submodule and isn't needed for the
  build.

## yosys notes (Verilog synthesis)

- Yosys 0.66, the open Verilog RTL synthesis suite and the synthesis front end
  of the digital flow. It's built from the official `yosys-src.tar.gz` release
  tarball, which bundles ABC and includes `.gitcommit`, so the build needs no
  network fetch and no git. It installs `yosys` and `yosys-abc`.
- It's a Makefile build (`use_configure no`):
  `make CONFIG=clang PREFIX=${prefix}`. Yosys's Makefile detects MacPorts by
  itself (it adds `${prefix}` include, lib and pkgconfig when `port` is on
  PATH), so dependencies resolve cleanly: bison, flex and pkgconfig to build;
  tcl, readline, libtommath and zlib as libraries.
- The release tarball is flat (no top-level directory), hence
  `extract.mkdir yes`.
- Checked: it synthesizes RTL to gates and runs ABC technology mapping.
- The digital place-and-route side is packaged too; see the `openroad` and
  `openroad-ll` notes. (This bullet used to say OpenROAD wasn't packaged. That
  was before the 26Q3 CMake port.)

## openroad notes (RTL-to-GDS place and route, builds and runs)

- OpenROAD 26Q3, built with CMake. 26Q3 also has Bazel, but CMake avoids it.
  It's C++20, so it uses MacPorts clang-19 with the libc++ 19 headers, the same
  recipe as kicad. The binary runs: `openroad -version`, the Tcl interpreter,
  and `+GPU +Python` (`-GUI`).
- Dependencies that need a pinned version that conflicts with MacPorts go in the
  private prefix `/opt/local/libexec/eda`. That's what the `eda-` ports are:
  - `eda-or-tools` repackages Google's prebuilt macOS OR-Tools 9.14. It bundles
    the exact abseil, protobuf 6.31 and re2 that or-tools needs; MacPorts'
    versions are ABI-incompatible. Its partial bundled Boost is stripped out.
  - `eda-lemon` is COIN-OR LEMON 1.3.1 (MacPorts `lemon` is the SQLite parser,
    something else entirely). Its headers are patched for C++20, removing
    `std::allocator::construct`.
  - `eda-fmt` (fmt 12.1) and `eda-spdlog` (spdlog 1.16 built against eda-fmt).
    OpenROAD's slang frontend needs fmt ≥12.1, but MacPorts spdlog is tied to
    fmt 10, which gives a `fmt::v10` vs `v12` link mismatch. The eda pair keeps
    one fmt ABI.
- OpenROAD's `src/sta` (its own OpenSTA fork), `third-party/abc`, and
  `third-party/slang-elab` (with the nested slang and fmt) are vendored as
  pinned distfiles. The system dependencies are tcl, eigen3, cudd, yaml-cpp,
  gtest, readline, zlib, libomp and python313, plus swig, bison, flex and
  llvm-19.
- To build it you have to deactivate four ports whose headers in
  `/opt/local/include` shadow the private and fork copies. A plain
  `-I/opt/local/include` from tcl and others beats the `-isystem` eda paths.
  Deactivate, build, reactivate:
  ```
  sudo port clean openroad
  sudo port -f deactivate spdlog protobuf3-cpp OpenSTA   # those the gate names
  sudo port install openroad        # ~40 min C++20 compile
  sudo port activate spdlog protobuf3-cpp OpenSTA
  ```
  The `pre-build` gate prints the exact command for whichever of the four are
  active on your machine, so use that. If several OpenSTA revisions are
  installed, `port` may ask you to name one; activate the newest
  (`port installed OpenSTA` lists them). The command the gate prints chains
  these steps with `&&`, so if the build fails, the reactivation never runs.
  Reactivate by hand before doing anything else, or the standalone OpenSTA
  stays inactive. (openroad no
  longer installs its own `sta`, headers or libOpenSTA.a, so it coexists with
  the standalone OpenSTA port once that's reactivated.)

  Both openroad and openroad-ll stop early through a `pre-build` check if any
  of the four is still active, and print these commands. If a build already
  failed because a gate was missed, `sudo port clean` the port before retrying
  (the CMake cache is stale). Their swig needs (`swig-tcl` and `swig-python`)
  have been declared dependencies since 2026-07-08, so those install
  automatically.
- OpenROAD's vendored OpenSTA fork needs its own copies of the OpenSTA fixes.
  OpenROAD statically links the fork in `src/sta`, so a patch to the standalone
  `OpenSTA` port never reaches `openroad`. It's the same source built twice.
  So `cad/openroad` carries six of the nine OpenSTA patches, each one either
  re-rooted to `src/sta` or regenerated against the fork's own files:
  InternalPower power-LUT axes, the LVF `constraiint` spelling, POCV slack sign,
  CCS slew-axis transpose, ArnoldiReduce null driver terminal, and
  PrimaDelayCalc pin-not-in-network. The spaceship build fix isn't needed with
  clang-19's libc++, and I didn't port the two `write_path_spice` fixes. Keep
  each pair in sync. The fork predates upstream `ef0b6909` (PrimaDelayCalc
  degenerate networks), and that fix isn't backported here.
- Why not build openroad against the patched OpenSTA port instead? OpenROAD
  offers `USE_SYSTEM_OPENSTA`, but I considered it and decided against it. The
  fork and the port's pin have diverged since 2026-06-16, in exactly the
  incremental timing code that `repair_timing` drives. `OPENSTA_HOME` has to be
  a full patched OpenSTA source tree (SWIG `.i` and Tcl files), which the port
  doesn't install. And upstream doesn't test that option in any CI. Duplicating
  the patches costs less and is safer.
- `openroad-ll` deliberately carries none of these patches. Its whole purpose
  is to be the exact revision LibreLane validated. The consequence is that
  `report_power` through the LibreLane flow still aborts on a
  `power_lut_template` whose slew axis is `input_net_transition`. The reasoning,
  including why `USE_SYSTEM_OPENSTA` doesn't apply there either, is in a comment
  at the top of its Portfile.
- The Portfile comments have the rest of the history, including the libomp link
  fix and every gate.

## sby notes (SymbiYosys formal verification)

- SymbiYosys (`sby`) is the formal verification front end for Yosys: BMC,
  k-induction, cover and equivalence. It's pure Python, pinned to a recent
  `main` commit, because no version tags track current yosys.
  `supported_archs noarch`.
- It drives `yosys` and `yosys-smtbmc` with an SMT solver. The port depends on
  z3, the default engine. `yices` and `boolector` are also in MacPorts and work
  if you select them in the `[engines]` section of a `.sby` file.
- Install quirks: the Makefile gets its version from `.gittag`, falling back to
  `git describe`, which fails in a tarball. So `post-extract` writes a clean
  `.gittag`, and `post-destroot` points the `sby` script's
  `#!/usr/bin/env python3` at `${prefix}/bin/python3.13`.
- Checked: `sby -f design.sby` passes true assertions and fails false ones, with
  a counterexample.

## netlistsvg notes (SVG schematics from yosys JSON)

- netlistsvg draws SVG schematics from `yosys ... write_json` output. The
  SkyWater sky130 PDK build uses it to render standard-cell schematics. It
  installs `netlistsvg` and `netlistsvg-dumplayout`. `supported_archs noarch`.
- It's an npm package, but the port never runs npm. The registry tarball and
  all 70 runtime dependency tarballs are pinned as checksummed distfiles, the
  same idea as openvaf's crate pins. npm's resolved tree is flat, so
  `post-extract` just untars each dependency into `node_modules/<name>`
  (`--strip-components=1`, because the `@types/*` tarballs don't use the usual
  `package/` root). Everything lands in `${prefix}/lib/node_modules/netlistsvg`
  with `bin` symlinks, and the shebangs are pointed at `${prefix}/bin/node`.
- The runtime dependency is `path:bin/node:nodejs22`; any MacPorts nodejs will
  do.
- On a version bump, regenerate the dependency list as described in the
  comment block in the Portfile: `npm install --package-lock-only`, re-hash the
  resolved tarballs, and check the tree is still flat.
- Checked: `port test netlistsvg` renders an SVG from a small `$and` netlist,
  and the installed binary does the same.

## sv2v notes (SystemVerilog to Verilog-2005, built from source)

- zachjs/sv2v v0.0.13 converts synthesizable SystemVerilog (always_ff,
  always_comb, logic, interfaces, packages and so on) to Verilog-2005, for tools
  with weak SV front ends (iverilog, and yosys without the slang plugin). It
  isn't in stock MacPorts.
- It's a Haskell program, built from source, offline, and native on both
  architectures. Rev 0 repackaged upstream's x86_64-only binary and needed
  Rosetta on Apple Silicon; rev 1 replaced that. The toolchain is MacPorts
  `ghc-prebuilt` and `cabal-prebuilt`, which repackage the official binary
  distributions, so there's no GHC bootstrap build.
- Hackage is vendored offline, adapting this tree's npm and crates pattern. The
  10 non-boot packages the cabal solver picked are pinned as checksummed
  distfiles. That includes the alex and happy build tools, so those MacPorts
  ports aren't needed. They're extracted and listed in a generated
  cabal.project as local packages with `active-repositories: none`, so
  `cabal build --offline` never touches a repository or index. It took three
  tricks, all commented in the Portfile:
  1. Raw Hackage tarballs carry stale `base < 4.x` bounds that Hackage only
     fixed through metadata revisions, which an offline build never sees. So
     pre-build relaxes the boot-library upper bounds in the vendored .cabal
     files.
  2. cabal solves every component of a local package, ignoring
     `tests: False` and `--disable-tests`. So test-suite and benchmark stanzas,
     and test and bench sub-libraries, are stripped (vector's
     `library benchmarks-O2` wants tasty). Sub-libraries that actually matter
     (happy-lib's) are kept.
  3. cabal finds ghc and ghc-pkg by name, so they're symlinked into a private
     CABAL_DIR, the same trick as the stock haskell_cabal PortGroup's bootstrap
     mode.
- sv2v's githash version stamp has a fallback for when there's no git
  (`tGitInfoCwdTry`), so tarball builds report the plain cabal version. No git
  needed.
- `port test` checks that an always_ff/logic module converts to
  `always @(posedge ...)` / `reg`. The version-bump procedure is in the Portfile
  header (a networked `cabal build --dry-run`, then update the pin list).

## Verification ports (eqy, mcy, cvc-rv, irsim) and checktools.sh

- eqy and mcy v0.66 are version-locked to yosys 0.66. YosysHQ releases them
  together, so bump all three at once. eqy's yosys plugins compile against the
  yosys port's headers. Both scripts get the same `.gittag` and python3.13
  shebang treatment as sby. mcy's Qt GUI isn't built, on purpose.
- cvc-rv 1.1.7 does ERC on extracted CDL netlists. It has to be built with gcc13
  and libstdc++, because its mmap_allocator reaches into libstdc++ internals
  (`_M_impl`) that libc++ doesn't have. It also patches obstack's
  `stdint-gcc.h` include. The binary is `cvc_rv`. One quirk: every cvc_rv
  invocation, even `--version`, writes a `default.cvcrc` template into the
  current directory, so run it from a work directory, not somewhere you care
  about.
- irsim 9.7.117 is a vendored stock snapshot plus real fixes. Stock builds
  "successfully" on Xcode 15+ but silently leaves out `tclirsim.dylib`, because
  the opencircuitdesign Makefiles swallow failures in subdirectories (the same
  trap as netgen). The fixes:
  `-Wno-error=implicit-function-declaration/int-conversion` added to the
  top-level `defs.mak` (configure ignores CFLAGS from the environment, and
  `scripts/defs.mak` is a decoy copy); `-noprebind` removed (Xcode 15's ld
  dropped it); `-fno-common` changed to `-fcommon`; and a patch guarding the
  base `logprint` with `#ifndef TCL_IRSIM` (it's a duplicate symbol against
  tclirsim.c).
- py313-gdstk 1.0.0 does GDS/OASIS scripting. Upstream's CMake hardcodes a
  universal build, which is overridden to the port's build_arch through
  `CMAKE_ARGS`.
- `./checktools.sh` smoke-tests the whole installed toolchain: 28 tools, a few
  seconds, no sudo, no GUIs. Run it after upgrades or on a new machine. The exit
  code is the number of failures.

## ghdl notes (VHDL simulator)

- GHDL 5.1.1 with the LLVM backend, from upstream's official per-architecture
  prebuilt bundles. GHDL is written in Ada and MacPorts has no usable GNAT, so
  this follows the same repackaging precedent as eda-or-tools. I chose v5.1.1
  for portability. It's the newest release with both macOS assets
  (`macos13-x86_64` for the Intel machines, `macos14-aarch64` for arm64), so
  every machine runs the same GHDL version. v6.0.0 dropped the x86_64 asset, so
  check the assets before any version bump.
- It installs the self-contained bundle into `libexec/ghdl`. The bundle carries
  its own `libgcc_s`, which must never land in `${prefix}/lib`, where it could
  shadow the MacPorts libgcc runtime. `${prefix}/bin/ghdl` is a wrapper script,
  not a symlink. ghdl finds `ghdl1-llvm` and its precompiled std and ieee
  libraries relative to the path it was invoked by, without resolving symlinks,
  so a symlink breaks it. I found that out the hard way.
- `ghdl -e` links simulation binaries with the system C toolchain at run time.
  That's the Xcode CLT, which every MacPorts machine has, so no dependency is
  declared.
- GHW waveforms (`ghdl -r ... --wave=x.ghw`) open in the tree's gtkwave, and
  `ghwdump` is installed too. cocotb supports GHDL for Python testbenches.
- Checked: a VHDL-2008 counter testbench analyzes, elaborates and simulates with
  the right result, through `port test` and through the installed wrapper.
- Not included, and a possible follow-up: ghdl-yosys-plugin, for VHDL
  synthesis through yosys and then OpenROAD. It needs a libghdl matched to this
  tree's yosys 0.66 plus a plugin build. If I want it, I'll scope it the way I
  did openEMS.

## eda-ngspice notes (versioned ngspice plus `port select`)

- Several ngspice releases coexist, each in its own private prefix, and
  `port select` picks the active one:

  | Port | Prefix | Always callable as |
  |------|--------|--------------------|
  | `eda-ngspice46` | `libexec/eda/ngspice46` | `eda-ngspice46` |
  | `eda-ngspice47` | `libexec/eda/ngspice47` | `eda-ngspice47` |
  | `eda-ngspice_select` | — | (the select group) |
  | `eda-ngspice` | — | metaport → the default (46) |

  ```
  sudo port select --set eda-ngspice eda-ngspice47
  port select --list eda-ngspice
  ```
  Each version keeps its versioned command whatever is selected, the same idea
  as `python3.12` next to `python3`. That way a netlist or script can name a
  simulator explicitly, which matters for reproducible analog results.
- The selection covers the library too, not just the binary. The linked set is
  `bin/eda-ngspice` plus `libexec/eda/lib/libngspice.dylib`,
  `libngspice.0.dylib` and `lib/pkgconfig/ngspice.pc`. `kicad` dlopens
  `libexec/eda/lib/libngspice.dylib` by path when it simulates, so switching the
  selection changes KiCad's simulator without rebuilding KiCad. That's
  intended, but re-check a simulation in KiCad after you switch.
- Nothing is selected automatically. Until you run `port select --set`, there's
  no `bin/eda-ngspice` and no `libexec/eda/lib/libngspice.dylib`, so KiCad finds
  no simulator. That's normal MacPorts behaviour (python and clang work the same
  way), and it's in `port notes eda-ngspice`.
- The group is `eda-ngspice`, not `ngspice`. `${prefix}/bin/ngspice` is a file
  owned in the registry by the stock MacPorts ngspice port, while `port select`
  symlinks aren't owned by anything, so using that name would collide.
- The binary and the library are one port per version, built twice out of tree.
  `--with-ngshared` builds the library instead of the binary, so the two can't
  share a configure run. They used to be a port plus a `-lib` subport, but two
  subports can't both install the same `etc/select` entry, and KiCad needs the
  library link to follow the selection.
- Things I tripped over while building this: `port select` creates symlinks but
  not the directories they live in, and it isn't atomic. A missing parent
  directory aborts the selection partway, after some links already exist. So I
  dropped `sharedspice.h` from the select set: the select port can't own its
  parent directory, because MacPorts prunes empty directories from a destroot.
  The version-specific headers live in
  `libexec/eda/ngspice<version>/include/ngspice/`.
- Migrating from the old layout (needed once per machine):
  ```
  sudo port -f uninstall eda-ngspice-lib          # orphaned: gone from the index,
                                                  # but still owns the select path
  sudo port upgrade eda-ngspice                   # 46_0 -> stub 46_1
  sudo port install eda-ngspice46 eda-ngspice47
  sudo port select --set eda-ngspice eda-ngspice46
  ```
  The stub's `version` follows the default it points at on purpose. This port
  used to be the ngspice build itself, at version 46, so a stub numbered 1.0
  would sort below it, and MacPorts would refuse the upgrade as a downgrade.
- Checked on macOS 13: both versions build, run, and give an exact 1.000 V from
  a divider; the openvaf → OSDI → ngspice chain works on both 46 and 47; the
  selection switches both the command and the library cleanly in both
  directions; and the library loads through KiCad's path (`ngSpice_Init` is
  present) under either selection.

## openEMS notes (EC-FDTD EM solver, octave-free)

- openEMS, the EM field solver for antennas, RF and on-chip passives, without
  the stock port's octave dependency. It's four ports: eda-vtk (a minimal VTK),
  CSXCAD, openEMS, and the Python front end py313-csxcad / py313-openems.
  `sudo port install py313-openems` pulls in the whole chain.
- eda-vtk is what keeps this small. openEMS and CSXCAD only need four VTK IO
  modules (IOXML, IOGeometry, IOLegacy and IOPLY; see their CMakeLists), so
  eda-vtk builds just those, plus whatever they need internally, into
  `libexec/eda`. No rendering, no Qt, no Python wrapping. VTK vendors its
  third-party libraries, so it has no port dependencies at all (the dylibs only
  link libSystem and libc++). It builds in about 20 minutes, against hours for
  full vtk, and uses the same distfile and checksum as the stock vtk port.
- CSXCAD and openEMS shadow the stock ports by name (with the same pinned
  commits and patches as stock), so `port install openEMS` can never drag in
  octave or vtk. Octave was only needed at run time in stock. The MATLAB `.m`
  scripts still install under `share/openEMS/matlab` in case octave is ever
  wanted.
- The Python bindings live in the same two repos (the `python/` subdirectory,
  same distfiles). They build through the old `setup.py` (`python.pep517 no`),
  because upstream's pyproject.toml wires up a custom pip backend that vendors
  CSXCAD from a sibling checkout. Their setup.py needs
  `CSXCAD_INSTALL_PATH`/`OPENEMS_INSTALL_PATH` set to `${prefix}`. py313-openems
  needs py313-csxcad at build time, because cython cimports its .pxd files.
- Left out on purpose: QCSXCAD/AppCSXCAD, the GUI viewer, which would pull Qt5
  and VTK rendering back in (use ParaView to look at field dumps if you need
  to), and MPI.
- Checked end to end: a WR-90 TE10 waveguide FDTD simulation through Python
  (AddRectWaveGuidePort) gives S11 = -19.5 dB and S21 = -0.02 dB at 25 GHz, on
  the compressed-SSE multithreaded engine, at about 116 MCells/s on the Ventura
  i7. Tutorials: https://docs.openems.de/python/openEMS/Tutorials/

## skim-app notes (Skim PDF/EPS reader)

- Skim, the macOS PDF/PostScript reader and annotator, for looking at EPS plots
  from the EDA tools. It's named `skim-app` to avoid MacPorts' unrelated `skim`,
  a Rust fuzzy finder. Install it with `port install skim-app`.
- It installs the official prebuilt universal app; there's no source build. The
  port fetches `Skim-<ver>.dmg`, and `destroot` mounts it with `hdiutil` (through
  `system`) and `ditto`s `Skim.app` into `/Applications/MacPorts/`.
- EPS: Skim registers `com.adobe.encapsulated-postscript` and opens EPS and PS
  through macOS's built-in PostScript importer, which Ventura has. If an EPS
  won't render on a newer macOS, convert it first with ghostscript
  (`epstopdf`); the port's `notes` explain how.

## kicad notes (KiCad 10.0.4)

- Adapted from the stock MacPorts `kicad` port, which is stuck at 7.0.11, to
  10.0.4, Unix-style: real binaries in `/opt/local/bin` plus `.app` launchers in
  `/Applications/MacPorts/KiCad/`. It builds, runs, and rev-upgrade is clean.
- What it took to get it building on Ventura (all in the Portfile and `files/`):
  - Re-porting the `KICAD_MACOSX_APP_BUNDLE=OFF` patch across three major
    versions (the pcbnew CMake restructure, the `paths.cpp` guard split, and the
    `kicad-cli` install).
  - New v10 dependencies: `zstd`, `libgit2`, `fontconfig`, `protobuf3-cpp`,
    `nng` and `gnutar`. It has `conflicts_build boost`, so deactivate `boost`
    for the build (`sudo port -f deactivate boost`, and reactivate after).
  - The C++23 standard library. KiCad 10 uses `std::ranges::views::values` and
    similar, which the Ventura SDK's libc++ (15) lacks, so it builds with
    `macports-clang-19` and its libc++ 19 headers (with the system libc++
    runtime).
  - A wxWidgets 3.3 to 3.2 API fallback, an mbedtls link fix for the static
    `libnng.a`, GNU tar for the bitmap archive, and a klayout-style install-name
    rewrite (`files/fix-install-names.sh`) so the `.kiface` and 3D plugins find
    the kicad libraries.
- The simulator backend: kicad depends on `eda-ngspice` and
  `eda-ngspice_select`, and its ngspice loader opens
  `${prefix}/libexec/eda/lib/libngspice.dylib`. That's the `port select` link to
  whichever versioned ngspice is active (46 or 47), so KiCad simulates on the
  tree's pinned ngspice, not stock's libngspice, and switching the selection
  switches KiCad's simulator without a rebuild. Nothing is selected until you run
  `port select --set`; see the eda-ngspice notes.
- The data libraries (`kicad-symbols`, `-footprints`, `-packages3D` and
  `-templates`) are subports installed from the GitLab 10.0.4 archives. I
  dropped the `kicad-docs` subport: CERN's prebuilt docs tarballs stop at
  8.0.0-rc3, so there's no `kicad-doc-10.0.4`, and KiCad's Help menu uses the
  online docs instead.
- The Portfile and `files/` comments have the full history.

## Vendored stock ports (gtkwave, xcircuit, iverilog, magic, verilator)

- These five are snapshots of the stock MacPorts ports (the Portfile and any
  `files/` patches), copied in so this tree is a self-contained EDA catalogue.
  They shadow the stock ports because the local `file://` source is above the
  rsync line in `sources.conf`. gtkwave, iverilog and verilator are verbatim.
  Two have local changes:
  - xcircuit: `-Wno-error` flags for Xcode 16's clang (see the macOS 15 notes;
    stock is still broken there).
  - magic: bumped to 8.3.660, because LibreLane's magic scripts need its
    `units` command and stock MacPorts was at 8.3.508. It also has a `gsed` fix
    for the GNU sed `-i` usage in 8.3.660's depend rule.
- verilator (5.028) was vendored for the LibreLane flow's lint step. Its version
  matches LibreLane's own nix pin.
- This is a deliberate snapshot, a pin, not a fork to maintain. Since I'm the
  only user, I'd rather freeze a revision I know works than chase upstream.
  These won't pick up MacPorts version bumps until I copy them in again.
- To refresh one to the current upstream revision, copy it in again, for
  example:
  ```
  cp -R /opt/local/var/macports/sources/rsync.macports.org/macports/release/tarballs/ports/science/magic/. \
        science/magic/ && portindex
  ```
- `gtkwave` has always been finicky to build here, which is exactly why pinning a
  working revision in the tree is worth it.
- `ngspice` and `openEMS` used to be left on stock MacPorts. Since 2026-07 both
  are in the tree: `openEMS` and `CSXCAD` shadow stock (octave-free, using
  eda-vtk; see the openEMS notes), and `eda-ngspice` pins ngspice 46 for the
  flow, while stock ngspice 44.2 keeps the plain name (see the eda-ngspice
  notes).

## lepton-eda / gtksheet notes (gEDA schematic capture and netlisting)

- Lepton EDA is the actively maintained fork of gEDA/gaf. Stock MacPorts only
  has the abandoned `geda-gaf` 1.10.2. It's pinned to 1.9.18, upstream's last
  tagged release (2022; master is active but has no tags). The port fetches the
  official dist tarball from the release assets, not GitHub's automatic
  archive.
- It's built `--with-gtk3` (upstream's GTK2 path is legacy) against
  `gtk3 +x11`, and with MacPorts `guile-3.0`. The plain `guile` port is an
  obsolete stub, and lepton's configure finds the suffixed `guile-3.0` and
  `guild-3.0` binaries by itself.
- `gtksheet` (a new `x11/` port, fpaquet/gtksheet 4.3.14) provides the GtkSheet
  4 that lepton-attrib needs under GTK3. Its git archive ships a stale,
  checked-in `configure` with no `build-aux/`, so the port runs
  `autoreconf -fvi`. The gtk-doc and introspection m4 files are bundled, so it
  doesn't need gtk-doc.
- Dependency variants, on both machines: `gtk3 +x11` needs its singleton
  backends built for X11 as well, or lepton dies when it dlopens them at run
  time:
  ```
  sudo port upgrade --enforce-variants libepoxy +x11 -quartz   # else: missing _epoxy_glXGetClientString
  sudo port upgrade --enforce-variants glib2 +x11 -quartz      # else: missing _g_desktop_app_info_get_filename
  ```
  Both are safe on a machine that mixes quartz and x11. Nothing installed uses
  libepoxy's CGL-only symbols or glib2's quartz-only `g_osx_app_info_*` symbols
  (I checked with an `nm` sweep; gtkwave on gtk2-quartz and gtk4-quartz are
  unaffected). It's the same lesson as the cairo/pango rule in the macOS 15
  notes.
- The first run of any lepton tool compiles the Guile Scheme libraries into
  `~/.cache/guile/ccache`. That's a minute or so of `;;; compiling...` output,
  and it's harmless. If you ran the tools before applying the variant fixes
  above, delete that cache: stale `.go` files give
  `Wrong type to apply: #<syntax-transformer check-string>`.
- Checked: `lepton-netlist -g spice-sdb` produces a correct netlist from the
  bundled TwoStageAmp example; `lepton-schematic` and `lepton-attrib` run under
  XQuartz; and `lepton-cli --version` reports 1.9.18.

## xschem notes

- Schematic capture (3.4.6). It builds against the X11 Tk (`tk +x11`).
- It needs an X server. macOS doesn't come with one, and MacPorts'
  `xorg-server` is deprecated and broken on Ventura and later. With it
  installed, xschem fails with "can't open display". To fix it, run
  `sudo port -f uninstall xorg-server xorg-server-devel`, install the official
  XQuartz from <https://www.xquartz.org>, then log out and back in so
  `$DISPLAY` gets set. The port's `notes` (shown on install, or with
  `port notes xschem`) say the same.
- The same X server requirement applies to the other X11 GUIs here (`magic`,
  `netgen-lvs`, and the `klayout` GUI).

## trilinos16 / xyce notes

- I moved these over from a separate local tree. `trilinos16` is the serial
  Trilinos subset Xyce needs (Epetra, Teuchos, AztecOO and so on), and `xyce`
  (7.9) links against it.
- Both build C and C++ with Apple clang and Fortran with gcc13, and install into
  `${prefix}` normally. Xyce upstream only tests thoroughly against Trilinos
  14.4, so these versions are pinned on purpose. Bumping Trilinos is risky.

## trilinos-charon notes

- A second, independent Trilinos build, configured with MPI and the full Panzer
  stack (Tpetra, Panzer, Phalanx, Intrepid2, STK, SEACAS, MueLu and others),
  which Charon needs. It's built with `openmpi-gcc13` and gcc's own
  `libstdc++`.
- It installs into a private prefix, `${prefix}/libexec/trilinos-charon`, so it
  coexists with the serial `trilinos16` without clashing over
  `lib/cmake/Trilinos` or library names.
- The build needs the full set of fixes for gcc13 and the 2024 toolchain (see
  the Portfile): `libstdc++`, `-Wl,-no_warn_duplicate_libraries`,
  `-include cstdint`, `-DNETCDF_ENABLE_LEGACY_MACROS`,
  `-DBOOST_STACKTRACE_GNU_SOURCE_NOT_REQUIRED`, `-fpermissive`, a serial-HDF5
  bypass, and trimmed STK subpackages.

## charon notes (Sandia TCAD)

- Charon v2.2 is a TriBITS project that builds Trilinos from source alongside
  itself, as an extra repository. It doesn't link an installed Trilinos. The
  Portfile fetches two distfiles (Charon, and vanilla Trilinos 13.4) and puts the
  Trilinos source at `tcad-charon/Trilinos`, where Charon expects it. It installs
  into the private prefix `${prefix}/libexec/charon`.
- Charon-specific build notes: BoostLib needs symlinks without `-mt`, because
  MacPorts boost names are `-mt`-suffixed. `CMAKE_BUILD_TYPE=Release`, because
  TriBITS rejects the PortGroup's `MacPorts` build type. HDF5 is turned back on
  after `General.opts`, because MacPorts netCDF is netCDF-4, so Exodus needs
  `libhdf5`. Percept is turned off; its vanilla `CMakeLists` is broken.
- The solver binary is `charon_mp.exe`. A `post-activate` hook symlinks it to
  `${prefix}/bin/charon`, and a `pre-deactivate` hook removes the link.
- A build-time caveat: `trilinos16` has to be deactivated while `charon` or
  `trilinos-charon` builds. This is required, not just being careful. There are
  two separate shadows through the TPL `-I${prefix}/include`. The serial stub
  `mpi.h` hides openmpi's real header; `files/openmpi-first.cmake` works around
  that through `CMAKE_PROJECT_TOP_LEVEL_INCLUDES`. And Trilinos 16's
  `Teuchos_any.hpp` (C++17 `std::is_constructible_v`) breaks charon's C++14
  compile of the bundled Trilinos 13.4, which the shim can't help with (seen
  2026-07, in stk_util). Both Portfiles have a `pre-build` check that stops in
  seconds with the one-line fix if `trilinos16` is active. Watch out:
  MacPorts' rev-upgrade can reactivate `trilinos16` by itself in the middle of
  a batch. It did once, right after `trilinos-charon` finished installing. So
  upgrade these ports one at a time, and deactivate again in between.
