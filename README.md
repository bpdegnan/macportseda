# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.  Tested on MacOS 13, 15 and 26 on arm64. (I tried the new MacOS and they used more power and did less)
This work is motivated by the fact that my needs that generally don't overlap with most communities.  
I always felt bad contributing to macports because I'm not a very good at software engineering, and the lack of experience made me a bad collaborator.  I'm still poor at GIT.

Regarding Skywater's 130 PDK, I've never tried py-voltare; however, I use the [https://github.com/bpdegnan/spicesupport](https://github.com/bpdegnan/spicesupport) repo and the [installskywater.sh](https://raw.githubusercontent.com/bpdegnan/spicesupport/refs/heads/main/installskywater.sh) script in that repo.

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
    ├── sby/            # SymbiYosys — formal verification front-end
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
    ├── openroad/       # OpenROAD RTL-to-GDS P&R (builds & runs — see notes)
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

3. Install. For the full EDA toolchain in one shot:

   ```
   sudo port install eda-icall
   ```

   (a metaport pulling yosys, sby, eqy, mcy, iverilog, verilator, OpenSTA,
   openroad, openroad-ll, netlistsvg, sv2v, xschem, eda-ngspice, xyce,
   openvaf, eda-cace (+py-ciel), irsim, magic, netgen-lvs, cvc-rv, klayout,
   xcircuit, py-gdstk, gtkwave, py-volare, skim-app — kicad, eda-freecad,
   ghdl, lepton-eda, openEMS and charon/TCAD stay separate). Mind the variant prerequisites in the macOS 15 notes and the
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
   | lepton-eda | `sudo port install lepton-eda` | gEDA/gaf fork. GTK3/X11 GUIs → XQuartz; **needs `libepoxy +x11` and `glib2 +x11`** (see notes). Pulls `gtksheet`. |
   | xyce | `sudo port install xyce` | Parallel SPICE; pulls `trilinos16`. |
   | py-volare | `sudo port install py-volare` | PDK manager; py313, installs `volare`. |
   | skim-app | `sudo port install skim-app` | Skim PDF/EPS reader → `/Applications/MacPorts`. |
   | netlistsvg | `sudo port install netlistsvg` | SVG schematics from yosys JSON (sky130 PDK build dep). |
   | sv2v | `sudo port install sv2v` | SystemVerilog→Verilog-2005. Built from source (Haskell, offline-vendored); native on x86_64 and arm64. |
   | eqy / mcy | `sudo port install eqy mcy` | Formal equivalence (RTL vs netlist) + mutation coverage; version-locked to yosys 0.66. |
   | cvc-rv | `sudo port install cvc-rv` | ERC/reliability checks on extracted CDL netlists (binary: `cvc_rv`). |
   | irsim | `sudo port install irsim` | Switch-level simulator (vendored + fixed; stock is silently broken on Xcode 15+). |
   | py-gdstk | `sudo port install py313-gdstk` | GDS/OASIS layout scripting for python 3.13. |
   | ghdl | `sudo port install ghdl` | VHDL simulator (87→2008, partial 2019). Per-arch official prebuilt, native on x86_64 (macOS≥13) and arm64 (macOS≥14); GHW waves open in gtkwave. |
   | eda-ngspice | `sudo port install eda-ngspice46 eda-ngspice47` | Versioned, coexisting. Pick one with `sudo port select --set eda-ngspice eda-ngspice47`; each is also always callable as `eda-ngspice46`/`eda-ngspice47`. See the eda-ngspice notes. |
   | openEMS (python) | `sudo port install py313-openems` | Octave-free EM solver chain: pulls eda-vtk, CSXCAD, openEMS, py313-csxcad. |
   | eda-cace | `sudo port install eda-cace` | Analog characterization (`cace`, `cace-web`). App port on py312; pulls `py-ciel`. Set `PDK_ROOT` at run time. See CACE notes. |
   | nec2c | `sudo port install nec2c` | NEC-2 method-of-moments antenna simulation, CLI (`nec2c -i in.nec -o out.txt`). Not replaced by the stock `xnec2c` GUI — see the nec2c notes. |
   | py-ciel | `sudo port install py-ciel` | PDK version manager (volare successor); installs `ciel`. Also an eda-cace dep. |
   | eda-freecad | `sudo port install eda-freecad` | FreeCAD 1.1.3 for enclosures (KiCad StepUp). Pulls `eda-coin`, `eda-pivy`, `py312-pyside6`, plus `vtk`/`libmed`/`boost181`. **Build PySide6 with `-addonmodules`.** No boost gate needed (uses boost181). Builds & runs; see FreeCAD notes. |
   | openroad / openroad-ll | see below ⚠️ | RTL-to-GDS P&R. **Need `boost spdlog protobuf3-cpp OpenSTA` deactivated to build.** |
   | kicad | see below ⚠️ | Full EDA suite + libraries. **Needs `boost` deactivated to build.** Simulates on eda-ngspice-lib (ngspice 46). |
   | trilinos-charon / charon | see below ⚠️ | TCAD; **need `trilinos16` deactivated to build.** |

   Installing `OpenSTA` pulls in the local `cudd` port automatically.

   **Build-time deactivation gotchas** (MacPorts can't do these automatically —
   the build *fails* without them):

   If a build already failed because a gate was missed, run
   `sudo port clean <port>` before retrying with the gate applied — the
   leftover CMake cache in the work directory remembers the shadowed include
   paths and reproduces the failure even after deactivation.

   - **openroad** and **openroad-ll** hit four header-shadowing gates (details
     in the openroad notes below). Both Portfiles fail fast with these exact
     instructions if a gate is missed:
     ```
     sudo port -f deactivate boost spdlog protobuf3-cpp OpenSTA
     sudo port install openroad         # and/or openroad-ll; ~40 min each
     sudo port activate boost spdlog protobuf3-cpp OpenSTA
     ```
   - **kicad** conflicts with the umbrella `boost` port during the build:
     ```
     sudo port -f deactivate boost
     sudo port install kicad            # long build; pulls symbols/footprints/3D/templates
     sudo port activate boost
     ```
   - **charon** and **trilinos-charon** are shadowed by `trilinos16`'s headers
     in `${prefix}/include` during the build (its Trilinos-16 `Teuchos_any.hpp`
     is C++17-only and breaks charon's C++14 compile; its stub `mpi.h` hides
     openmpi's). Both Portfiles fail fast with instructions if the gate is
     missed:
     ```
     sudo port -f deactivate trilinos16
     sudo port install charon           # or trilinos-charon
     sudo port activate trilinos16       # rev-upgrade usually re-activates it anyway
     ```

   GUI tools that use X11 (`xschem`, `magic`, `netgen-lvs`, `xcircuit`) need a
   running X server — install **XQuartz** (see the xschem notes). `klayout`
   (Qt6) and `skim-app` are native Cocoa and don't.

## failure reports go to GitHub, not MacPorts

Every port in this tree includes the tree's own `eda-github` PortGroup
(`_resources/port1.0/group/eda-github-1.0.tcl`). When a standard phase
(fetch/checksum/extract/patch/configure/build/destroot/test) fails, it prints
a banner directing the user to report at
<https://github.com/bpdegnan/macportseda/issues> and explicitly NOT to file
MacPorts trac tickets — these ports are not in the official tree and the
MacPorts maintainers should not be bothered with them.

Notes:
- The final `Follow https://guide.macports.org/#project.tickets ...` line is
  printed by the `port` client itself on any failure and cannot be suppressed
  from a Portfile; the GitHub banner appears directly above it.
- Phases a Portfile overrides with its own body (e.g. a custom `destroot {}`)
  bypass the wrapped defaults, so failures inside those blocks don't get the
  banner. The pre-build gate checks (openroad/charon families) print their
  own GitHub-free instructions already.
- `port lint` reports "Line 4 has unrecognized PortGroup" for every port:
  lint only knows the default tree's PortGroups, not local-tree ones. It is
  cosmetic — parsing, indexing and building are unaffected.

## distfiles archive 

`distfiles/` holds a copy of every source tarball the tree's ports fetch.

### Where the tarballs come from

| Port | Upstream source |
|------|-----------------|
| OpenSTA | [parallaxsw/OpenSTA @ bfdd2be](https://github.com/parallaxsw/OpenSTA/archive/bfdd2be0ee6214115b20cacdc0a071ca3c737fbb/OpenSTA-bfdd2be0ee6214115b20cacdc0a071ca3c737fbb.tar.gz) (no upstream tags) |
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
| ghdl | [ghdl/ghdl v5.1.1 prebuilt](https://github.com/ghdl/ghdl/releases/tag/v5.1.1) — per-arch release assets: `ghdl-llvm-5.1.1-macos13-x86_64.tar.gz` + `ghdl-llvm-5.1.1-macos14-aarch64.tar.gz` (archive BOTH) |
| eda-vtk | [Kitware/vtk v9.6.2](https://github.com/Kitware/vtk/archive/v9.6.2/vtk-9.6.2.tar.gz) (same distfile as stock vtk) |
| eda-ngspice46 / eda-ngspice47 | [ngspice 46](https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/old-releases/46/ngspice-46.tar.gz) and [ngspice 47](https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/47/ngspice-47.tar.gz) — SourceForge moves a release into `old-releases/` once a newer one ships, so both Portfiles list both paths; shared `dist_subdir eda-ngspice` |
| CSXCAD (+ py313-csxcad) | [thliebig/CSXCAD @ f5e4764](https://github.com/thliebig/CSXCAD/archive/f5e47643a28d6efd42cc10b61b848903e6599581/CSXCAD-f5e47643a28d6efd42cc10b61b848903e6599581.tar.gz) (stock MacPorts pin) |
| openEMS (+ py313-openems) | [thliebig/openEMS @ 32c5c6b](https://github.com/thliebig/openEMS/archive/32c5c6b537b33a8b70f9ba4f5c9a8ecbb12777b3/openEMS-32c5c6b537b33a8b70f9ba4f5c9a8ecbb12777b3.tar.gz) (stock MacPorts pin) |
| eda-or-tools | [google/or-tools v9.14 prebuilt macOS](https://github.com/google/or-tools/releases/download/v9.14/or-tools_x86_64_macOS-15.5_cpp_v9.14.6206.tar.gz) |
| eda-lemon | [lemon.cs.elte.hu 1.3.1](https://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz) (**404s** — [Spack mirror fallback](https://mirror.spack.io/_source-cache/archive/71/71b7c725f4c0b4a8ccb92eb87b208701586cf7a96156ebd821ca3ed855bad3c8.tar.gz), keyed by sha256) |
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
| openscad | [openscad/openscad @ openscad-2026.01.01-TEST2](https://github.com/openscad/openscad/archive/openscad-2026.01.01-TEST2/openscad-2026.01.01-TEST2.tar.gz) (upstream dev-snapshot tag, 24 MB) + four vendored submodule archives pinned at that tag: [manifold @ b2c6ddd](https://github.com/elalish/manifold/archive/b2c6ddd2e33510498a62c89049c83fa70342ddb3/manifold-b2c6ddd2e33510498a62c89049c83fa70342ddb3.tar.gz) (30 MB), [Clipper2 @ 6901921](https://github.com/AngusJohnson/Clipper2/archive/6901921c4be75126d1de60bfd24bd86a61319fd0/Clipper2-6901921c4be75126d1de60bfd24bd86a61319fd0.tar.gz), [sanitizers-cmake @ c3dc841](https://github.com/arsenm/sanitizers-cmake/archive/c3dc841af4dbf44669e65b82cb68a575864326bd/sanitizers-cmake-c3dc841af4dbf44669e65b82cb68a575864326bd.tar.gz), [MCAD @ 1ea4022](https://github.com/openscad/MCAD/archive/1ea402208c3127ffb443931e9bb1681c191dacca/MCAD-1ea402208c3127ffb443931e9bb1681c191dacca.tar.gz) — the GitHub source archive carries no submodules, so each is fetched separately and moved into place in `post-extract` |
| py-pyside6 | [Qt `pyside-setup-everywhere-src`](https://download.qt.io/official_releases/QtForPython/pyside6/) (same distfile as the stock port; version tracks `qt6.version`) |
| py-cxxheaderparser | [PyPI cxxheaderparser 1.9.1](https://files.pythonhosted.org/packages/source/c/cxxheaderparser/cxxheaderparser-1.9.1.tar.gz) |
| skim-app | [SourceForge Skim 1.7.15](https://downloads.sourceforge.net/project/skim-app/Skim/Skim-1.7.15/Skim-1.7.15.dmg) (prebuilt .dmg) |

(URLs generated from the Portfiles via `port distfiles <port>`; the Portfile
checksums remain the source of truth.)

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

## memory compilers (OpenRAM, DFFRAM — venvs, not ports)

Flow drivers, so they follow the LibreLane/cocotb pattern (uv venv +
wrapper in `~/.local/bin`), NOT MacPorts ports:

- **OpenRAM** (`openram myconfig.py`): real 6T SRAM macro compiler; venv at
  `~/.venvs/openram` (pip `openram`, currently 1.2.48). The wrapper runs the
  packaged `sram_compiler.py`. Needs `PDK_ROOT` (sky130A) at run time plus
  MacPorts magic/netgen/klayout for DRC/LVS. sky130 is its silicon-proven
  target; porting to the s7 proxy means writing an OpenRAM technology dir
  (bitcell/sense-amp cells + rules) — real work, tracked separately.
- **DFFRAM** (`dffram 32x32`): flip-flop/latch RAM built from STANDARD CELLS
  via a **LibreLane plugin** (repo moved to AUCOHL/DFFRAM; needs
  librelane>=2.4). Venv at `~/.venvs/dffram` with the repo cloned inside it;
  wrapper puts `libexec/openroad-ll/bin` first on PATH like the librelane
  wrapper. Works on ANY std-cell process — this is the zero-bitcell-work
  path for small memories (FIFOs, register files, calibration tables) on
  the s7 proxy.
- Rule of thumb: DFFRAM up to a few KB or on s7; OpenRAM when sky130 needs
  real SRAM density.

## FreeCAD notes (mechanical enclosures — `eda-freecad`, WORKING)

- **Why**: the mechanical enclosure around the PCBs in this flow, via the KiCad
  **StepUp** workbench (installed from FreeCAD's Addon Manager, which is why
  `BUILD_ADDONMGR=ON` is kept). Stock MacPorts `freecad` is **0.18.5 (2019)** on
  a dead stack — qt4-mac, python310, PySide1/`py-shiboken 1.2.4`, and the old
  `oce` fork of OpenCASCADE — so it is not a usable starting point.
- **Four ports, bottom-up.** Build in this order:

  | Port | What | Status |
  |------|------|--------|
  | `python/py-pyside6` | vendored stock snapshot + 3 real fixes | **builds** (6.11.1 on macOS 15, 6.7.3 on macOS 13) |
  | `cad/eda-coin` | Coin3D 4.0.10, private prefix | **builds & verified** (rev 2: Apple OpenGL, not mesa) |
  | `cad/eda-pivy` | pivy 0.6.11 vs eda-coin, py312 | **builds**, reports `SIM Coin 4.0.10` |
  | `cad/eda-freecad` | FreeCAD 1.1.3, Qt6 + OCCT 7.9 | **builds & runs, GUI + .app verified** (rev 6; macOS 13 *and* 15) |

- **Two GUI-only defects found by actually launching it** (both fixed; the CLI and
  STEP export never exercised them):
  1. **`No module named 'PySide'`** → Draft, Measure, Tux and the shaft wizard all
     failed at startup, and this would have broken **StepUp** too. FreeCAD generates
     a `PySide` shim (re-exporting PySide6 under the legacy name) and installs it
     with a platform split:
     ```cmake
     if(APPLE AND NOT BUILD_WITH_CONDA)  -> DESTINATION MacOS
     else()                              -> DESTINATION Ext
     ```
     The Apple branch assumes the **.app bundle** layout where `MacOS/` is the
     executable dir and lands on `sys.path` for free. We build with
     `FREECAD_CREATE_MAC_APP=OFF`, and at runtime FreeCAD adds
     `libexec/freecad/`**`Ext`** — not `MacOS` — so the shim was installed but
     unreachable. Fixed by a `post-destroot` symlink `Ext/PySide → ../MacOS/PySide`.
  2. **`Mesa: error: GL User Error: glGetString called without a rendering context`**
     → both `eda-coin` and FreeCAD had linked MacPorts **mesa**'s
     `${prefix}/lib/libGL.dylib` instead of Apple's OpenGL — an *undeclared*
     dependency picked up only because the `mesa` port happens to be installed.
     Cause: the cmake PortGroup passes `-DCMAKE_FIND_FRAMEWORK=LAST`. Measured with
     a standalone `FindOpenGL` probe:
     ```
     LAST  -> /opt/local/lib/libGL.dylib            (mesa)
     FIRST -> .../MacOSX.sdk/.../OpenGL.framework   (Apple)
     ```
     `OPENGL_GLU_FOUND` stays YES either way — which matters because FreeCAD's
     `SetupOpenGL.cmake` hard-errors with "GLU library not found" otherwise. Fixed
     in **both** ports by naming the framework explicitly:
     ```
     -DOPENGL_gl_LIBRARY=/System/Library/Frameworks/OpenGL.framework
     -DOPENGL_glu_LIBRARY=/System/Library/Frameworks/OpenGL.framework
     ```
     Mesa references across FreeCAD's modules went from ~11 to **0**.
     - ⚠️ **Do NOT use `-DCMAKE_FIND_FRAMEWORK=FIRST` for this.** It looks like the
       tidy fix and it *does* select Apple's OpenGL, but it broke FreeCAD outright:
       the Command Line Tools ship their own
       `/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9`,
       and frameworks-first let CMake reach it, so some `FreeCADGui` translation
       units compiled against **Python 3.9** headers while the rest used MacPorts
       **3.12**. Python 3.9's `cpython/object.h` has
       `typedef struct bufferinfo {...} Py_buffer;` while 3.12's struct is untagged,
       so the bundled PyCXX mangled differently per object file and `freecad`
       aborted at launch:
       ```
       dyld: symbol not found in flat namespace
         '__ZN2Py19PythonExtensionBase10buffer_getEP10bufferinfoi'
       ```
       (`libFreeCADGui` wanted `bufferinfo*`, `libFreeCADBase` exported `Py_buffer*`.)
       Keeping the PortGroup's `FIND_FRAMEWORK=LAST` leaves every other lookup —
       python above all — untouched. **General rule for this tree: never flip
       `CMAKE_FIND_FRAMEWORK` globally on a port that calls `find_package(Python*)`.**
     - Also do not add `OPENGL_INCLUDE_DIR=<framework>/Headers`: it makes CMake's
       `try_compile` fail with "Failed to generate test project build system".
  - The `3DconnexionNavlib.framework` dlopen error at startup was just the absent
    SpaceMouse driver being probed — harmless, but now switched off properly at
    build time with upstream's own option `-DFREECAD_3DCONNEXION_SUPPORT=None`
    (accepts `None`/`NavLib`/`Legacy`/`Both`, defaults to `NavLib`).
- **Three ways to launch it** (`port notes eda-freecad` lists these):
  `/Applications/MacPorts/FreeCAD.app` (Finder/Dock), `freecad` (GUI from a
  terminal), `freecadcmd` (headless/scripted). The bundle is hand-built in
  `post-destroot` the same way the **kicad** port does it —
  `Contents/{MacOS,Resources}`, upstream's `Info.plist` + `.icns`, and a symlink to
  the `${prefix}/bin` wrapper — so it sits alongside `KiCad/` and `GTKWave.app`
  and `port uninstall` removes it. Because upstream's plist declares
  `.FCStd`/`.FCMat`/`.FCParam`/`.FCMacro`/`.FCScript` document types,
  double-clicking a model opens it. Two deliberate choices:
  - **Not `-DFREECAD_CREATE_MAC_APP=ON`** — that relocates `CMAKE_INSTALL_PREFIX`
    to `<prefix>/FreeCAD.app/Contents`, moving the whole verified layout and
    invalidating the bin wrappers and the `Ext/PySide` symlink.
  - **The skeleton's `qt.conf` is deliberately NOT copied** — it says
    `Plugins=lib/qtplugins`, a bundle-relative path that does not exist in this
    layout, and it would stop Qt finding its Cocoa platform plugin. Icons only.
  The plist is a CMake template, so `NAME_STRING_FROM_CMAKE` /
  `VERSION_STRING_FROM_CMAKE` are substituted and the empty `CFBundleIdentifier`
  is set to `org.freecad.FreeCAD` (an empty one upsets LaunchServices).
- **PLATFORM SAFETY — the 10.13 / 10.15 machines are protected.** `eda-freecad`
  fails **fast at pre-fetch** on `os.major < 21` (macOS 11 and older), installing
  and changing nothing. That threshold is measured, not guessed: the `qt6_info`
  PortGroup offers `qt67 {6.7 {24 23 22 21}}` and
  `qt64 {6.4 {24 23 22 21 20 19 18}}`, so below os.major 21 the newest Qt 6
  available is **6.4** — too old to pair with the Qt-6.7-era PySide6/Shiboken6
  FreeCAD 1.1.3 requires. The `py-pyside6` shadow is written to be safe there too:
  narrowed to python **312 only** (10.15 keeps stock for every other python
  version — see the shadowing note below), and its fixes *detect* rather than
  assume, warning and leaving stock behaviour intact if the layout differs instead
  of failing a build that would otherwise have worked.

- **macOS 13 (Ventura) also BUILDS & RUNS** (eda-freecad rev 2, verified 2026-08 on
  macOS 13.7.8 / Darwin 22 / x86_64): `freecadcmd --version` →
  `FreeCAD 1.1.3 Revision: 20260725`, the same scripted 40×30×12 box exports a
  valid ISO-10303-21 STEP through OpenCASCADE (volume 14400), `pivy 0.6.11`
  reports `SIM Coin 4.0.10` matching eda-coin, and `rev-upgrade` is clean.
  It needed **two Ventura-only fixes** that macOS 15 did not:
  1. the broken Shiboken6 CMake config (FIX 3 in py-pyside6, below), and
  2. **C++20 `<source_location>`** — FreeCAD's `src/Base/Exception.h` includes it,
     libc++ only gained it in LLVM 16, and the Ventura CLT ships libc++ 15:
     ```
     src/Base/Exception.h:32:10: fatal error: 'source_location' file not found
     ```
     Remedied the same way as the kicad port — MacPorts clang-19 plus its libc++ 19
     **headers**, still linking the **system** libc++ runtime (`std::source_location`
     lowers to the `__builtin_source_location` intrinsic, so no new runtime symbols
     are needed, and two libc++ runtimes in one process would be an ABI trap given
     Qt/OCCT/VTK/PySide6 are all built against the system one). **Gated on
     `${os.major} <= 22`**, deliberately not unconditional: macOS 15 is verified
     working with the stock toolchain and should not be diverged from. Threshold is
     evidence-based — Darwin 22 lacks the header, Darwin 24 builds clean.
- **Why Ventura differs at all.** On Ventura
  Qt caps at 6.7.3, so `py-pyside6` builds **PySide6 6.7.3** rather than the
  6.11.1 used on macOS 15 — and at 6.7.3 the stock port emits a **broken
  Shiboken6 CMake config**, so `eda-freecad` dies at *configure* with:
  ```
  CMake Error in src/Gui/CMakeLists.txt:
    Imported target "Shiboken6::libshiboken" includes non-existent path
      "/opt/local/include/shiboken6"
  ```
  That is FIX 3 below. It is why the same tree builds on macOS 15 but not on 13.
  **One-time migration note:** if a py-pyside6 with the broken config is already
  active, the port cannot rebuild itself — its own build does
  `find_package(Shiboken6)`, finds the bad installed config and dies with the
  very same error. Deactivate first (same shape as the openroad/kicad gates):
  ```
  sudo port deactivate py312-pyside6
  sudo port install py312-pyside6 -addonmodules   # reactivates automatically
  ```

  Verified on **macOS 15.3 (Sequoia, Darwin 24) / Xcode 16.2 / x86_64**, 2026-08:
  `freecadcmd --version` → `FreeCAD 1.1.3 Revision: 20260725`; a scripted
  40×30×12 box exports a valid ISO-10303-21 STEP file through OpenCASCADE
  (volume 14400 as expected); `rev-upgrade` reports no broken files.
  **Still to confirm by hand** (needs a window server, so it cannot be done over
  SSH): the Qt6 GUI launching, and installing **KiCad StepUp** from the Addon
  Manager.

- **Four fixes were needed to make eda-freecad build**, none of them predicted:
  1. **`port:vtk` is required.** `BUILD_FEM=ON` (and `BUILD_MESH_PART`, which
     defaults ON) forces `FREECAD_USE_SMESH=ON`, and `SetupSalomeSMESH.cmake`
     then hard-requires VTK — *"if we use smesh we definitely also need vtk, no
     matter of external or internal smesh"*. The **bundled** SMESH still needs an
     **external** VTK; `BUILD_FEM_NETGEN=OFF` does not avoid it. MacPorts vtk
     9.6.2 satisfies FreeCAD's preferred `find_package(VTK 9)` path, and its
     config in `lib/cmake/vtk-9.6` matches CMake's default glob (no `VTK_DIR`
     pin needed, unlike libfmt11).
  2. **`port:libmed` is required — and MED *is* in MacPorts** (`libmed` 4.1.1,
     science/devel), contrary to the earlier assumption that it was absent and
     MED support would simply be skipped. There is no skipping: with the bundled
     SMESH, `find_package(MEDFile REQUIRED)` runs unconditionally and
     `FindMEDFile.cmake` FATAL_ERRORs with `med.h not found`.
  3. **The "Coin3D version mismatches Pivy Coin3D" error is an UPSTREAM REGEX
     BUG, not a real mismatch.** `SetupCoin3D.cmake` parses `Inventor/C/basic.h`
     with `([0-9?])` — a *single*-character class — so Coin 4.0.**10**'s
     two-digit micro version captures only `1`, giving "4.0.1", while pivy's
     version uses a correct `([0-9]+)` and gives 4.0.10. Any Coin with a
     two-digit patch number trips this. The parse is guarded by
     `IF (NOT COIN3D_VERSION)`, so eda-freecad passes `COIN3D_VERSION` and the
     three `COIN3D_*_VERSION` components on the command line to skip the broken
     block — no patchfile to keep in sync. (`FindMEDFile.cmake` has the identical
     single-digit bug, but nothing compares MED's version, so it is harmless.)
  4. **boost181, NOT the umbrella `boost`.** FreeCAD calls `.contains()` on a
     Boost.MultiIndex `hashed_index` in `src/App/Transactions.cpp` and
     `src/App/DynamicProperty.cpp`. That member does not exist in boost 1.76 —
     which is what the umbrella `boost` port installs — so the compile died with
     `no member named 'contains' in boost::multi_index::detail::hashed_index<…>`.
     It is present in 1.81+ (verified by grepping the headers). The trap:
     FreeCAD's declared `BOOST_MIN_VERSION` is a stale **1.74**, so
     `find_package(Boost 1.74)` happily accepts 1.76 and the failure only
     surfaces at compile time.
- **OpenCASCADE 7.9 needed no changes at all** — the anticipated OCCT API drift
  did not materialise.
- **Install layout**: binaries land in `libexec/freecad/`**`MacOS/`**, *not*
  `bin/` — even with `FREECAD_CREATE_MAC_APP=OFF`, FreeCAD keeps its
  bundle-style layout (`MacOS/ Ext/ Mod/ lib/ share/ include/`). The names are
  `FreeCAD`/`FreeCADCmd` as expected. The `post-destroot` wrappers point at
  `MacOS/` via a single `fc_bindir` variable.

- **`py-pyside6` is vendored here with three genuine fixes — and we are KEEPING the
  shadow deliberately** (decided 2026-08, after diffing against current stock at
  6.11.1). Rationale: **stock still has a real bug** — it points *both* PySide6
  symlinks at `libpyside6.abi3*`, so `lib/libpyside6qml.abi3.dylib` resolves to
  the wrong library, while ours correctly targets `libpyside6qml.abi3*`. That is
  version-independent, so it will not age out. The other two pieces
  (`xinstall -d`, and the llvm PATH fix) are harmless no-ops when the underlying
  problem is absent, so carrying them costs nothing and removes a latent trap:
  the PATH fix in particular means the port keeps working if `port select clang`
  is ever pointed at another major. Since our snapshot tracks stock's version
  (6.11.1 here), the fork does not hold us back. Don't swap to stock to save a
  fork — the fixes are cheap and the bug is real. Details:
  1. `post-destroot` symlinks into `PySide6/lib/` and `shiboken6/lib/`, but
     PySide6 6.7.3 never creates those dirs → destroot died with
     `symlink: .../PySide6/lib/libpyside6.abi3.dylib: no such file or directory`.
     Fixed by `xinstall -d` first (a harmless no-op where the dirs do exist).
     Stock also points *both* PySide6 symlinks at `libpyside6.abi3*`; the qml one
     now correctly targets `libpyside6qml.abi3*`.
  2. Shiboken's ApiExtractor loads libclang from `LLVM_INSTALL_DIR` but then
     execs bare **`clang++` from PATH**. With `port select clang` on a different
     major that binary dyld-crashes —
     `Symbol not found: llvm::RISCVISAInfo::printEnabledExtensions` (in libLLVM
     19, absent in 18) — and every module then fails with
     `'type_traits' file not found` / `Error running ApiExtractor`. Fixed by
     prepending the matching `llvm-N/bin` to the build PATH, so the port no
     longer depends on `port select` at all.
  3. **Broken imported-target include dirs** (this is what blocks macOS 13). The
     stock reinplaces meant to relocate the include dirs match
     `${_IMPORT_PREFIX}/<dir>/include`, but the real content is
     `${_IMPORT_PREFIX}/include/<dir>` — the components are **reversed**, so they
     never fire. The imported targets keep pointing at
     `${prefix}/include/{shiboken6,PySide6}`, which the port never creates, so any
     CMake consumer fails at configure. Compounding it, the shiboken headers
     install under **`shiboken6_generator/include`**, not `shiboken6/include`, so
     stock's `shiboken6.pc` `includedir` is wrong for the same reason. Ours
     *locates* `shiboken.h` instead of hardcoding, and — importantly for the older
     machines — **warns and leaves stock paths alone** if it cannot find it, rather
     than failing a build that would otherwise have worked.
- **The shadow is narrowed to python 312 only** (stock declares 310–314). This
  matters: stock `py-pyside6` has real consumers at other versions —
  `py313-pyside6` for py313-pyside6-fluent-widgets/-frameless-window, and
  `py314-pyside6` for **cutter-rizin**, ghost-downloader and those widget ports.
  Declaring only 312 means our index holds just `py-pyside6` + `py312-pyside6`, so
  requests for py313/py314 **fall through to stock** (verified with `port file`).
  Each python version installs into its own site-packages, so there is no file
  conflict either. Keep this in step with eda-pivy/eda-freecad's `py_ver`, and
  re-check that reverse-dependency list before widening.
- **Why not an `eda-pyside6` private-prefix port?** The `eda-` pattern works for
  `eda-coin` (a plain C++ library) but not for a Python binding layer:
  PySide6/shiboken6 must be importable by the exact python312 FreeCAD embeds *and*
  discoverable via `${prefix}/lib/cmake`. A private prefix needs PYTHONPATH
  injection and risks **two PySide6 C-extension copies in one process** (duplicate
  type objects, crashes); renaming while keeping the install location just trades a
  harmless substitution for hard file conflicts. Narrowing the version range is
  the cheaper, safer control.
- **Always build PySide6 with `-addonmodules`.** The addon set pulls
  `qt67-qtwebengine` (a full Chromium build) plus `llvm-22`/`clang-22`: **38
  extra ports vs 1**. FreeCAD needs only the base modules, hence
  `-DBUILD_WEB=OFF` in eda-freecad.
- **Coin3D 4 is mandatory and must match pivy.** FreeCAD has *no* minimum Coin
  version gate, but it hard-errors on
  `"Coin3D version X mismatches Pivy Coin3D Y"` — so `eda-pivy` must be built
  against `eda-coin`, and both must use the same python as `eda-freecad`
  (currently 3.12; the `py_ver` variable is at the top of both Portfiles).
  Stock `coin`/`Coin-framework` is 3.1.3 (2010), which predates the Coin 4 API
  FreeCAD 1.x uses, so Coin 4 goes in `libexec/eda` and leaves stock alone.
  `eda-pivy` force-disables `find_package(SoQt)` — the only MacPorts SoQt is
  built against Coin 3.1.3 and would mix two Coin ABIs in one extension.
- **fmt would be downloaded mid-build** — `SetupLibFmt.cmake` pings github.com
  and FetchContents fmt 11.1.4 if `find_package(fmt)` misses, and MacPorts puts
  fmt's CMake config in a versioned subdir off the default search path. Same
  defect OpenSTA hit; fixed with `-Dfmt_DIR=${prefix}/lib/libfmt11/cmake/fmt`.
- Bundled and used as-is (all in the source drop): OndselSolver, salomesmesh,
  zipios++, PyCXX, libE57Format, GSL, json, libkdtree. Don't flip the
  `FREECAD_USE_EXTERNAL_*` switches without adding matching ports.
- **Boost interaction — no gate needed for eda-freecad.** It now uses versioned
  boost181 with `Boost_NO_SYSTEM_PATHS` plus explicit `Boost_DIR`/`BOOST_ROOT`
  (the same recipe openroad uses), so the umbrella `boost` may stay **active**
  while it builds, and it can share a session with `openroad`/`kicad`. Those two
  still need the umbrella deactivated for *their* builds.
- **Target is macOS 14+ (Sonoma) / x86_64.** On macOS 13 expect Qt capped at
  6.7.3 ("Qt 6.8 is not supported on macOS 13") and the libc++ 15 C++20 wall; if
  hit, apply the kicad/openroad recipe (`macports-clang-19` + `-nostdinc++
  -isystem ${prefix}/libexec/llvm-19/include/c++/v1`) `${os.major}`-conditionally.

## openscad notes (script-based 3D CAD — dev snapshot, shadows stock)

- **OpenSCAD** describes solids in its own language instead of drawing them
  interactively, which makes it the natural companion to `eda-freecad` for
  parametric PCB enclosures. FreeCAD's OpenSCAD workbench drives it as an
  **external executable**, so the two interoperate through the binary and file
  formats — no shared libraries, no version coupling between them.
- **Why this port shadows the stock one: cgal4 vs cgal6.** Stock MacPorts
  openscad is 2021.01 — genuinely upstream's newest *stable* release, their
  cadence really is that slow — and it needs the old **cgal4**, which
  *conflicts* with the **cgal6** that CSXCAD and openEMS pull in. On any
  machine with this tree's EM chain installed, stock openscad simply cannot be
  installed:

  ```
  Error: Can't install cgal4 because conflicting ports are active: cgal6
  ```

  Current OpenSCAD asks for CGAL >= 5.0 with no upper bound, so pinning
  upstream's own dev-snapshot tag (`openscad-2026.01.01-TEST2`) builds against
  the cgal6 that is already there. Nothing in MacPorts depends on openscad, so
  taking the name is risk-free and `port install openscad` gets the one that
  actually installs — same approach this tree takes for magic, verilator and
  openEMS. `version` drops the `-TEST2` suffix (hyphens in a MacPorts version
  are best avoided); the exact tag is pinned in the Portfile.
- **Submodules are vendored as pinned distfiles.** The GitHub source archive
  contains no submodules, so manifold, Clipper2, sanitizers-cmake and MCAD are
  fetched as their own checksummed tarballs at the SHAs recorded at that tag
  and moved into place in `post-extract` — the same pattern `openroad` uses.
  OpenCSG and mimalloc are *not* vendored: `USE_BUILTIN_OPENCSG` defaults OFF
  and `submodules/CMakeLists.txt` does `find_package(mimalloc QUIET)` first, so
  both come from MacPorts ports.
- **Versioned boost, spelled out.** boost181 lives in `libexec/boost/1.81`,
  which `find_package(Boost ...)` cannot find on its own, so `Boost_DIR`,
  `BOOST_ROOT` and `Boost_NO_SYSTEM_PATHS` are all set. As with `eda-freecad`
  this also keeps the port clear of the boost-deactivation gate that
  `openroad`/`kicad` need — the umbrella `boost` may stay active.
- **qscintilla-qt6, not the qt5 flavour** the stock port uses; CMakeLists does
  `find_package(Qt6QScintilla 2.8.0 REQUIRED)`. Installing the port is not
  enough: OpenSCAD's bundled `FindQt6QScintilla.cmake` hints `find_library`
  with `${Qt6Widgets_LIBRARIES}`, which is a CMake *target name* (`Qt6::Widgets`)
  and not a path, so it never looks under `libexec/qt6` where MacPorts keeps
  Qt. The library is there and correctly named — it is just never searched for
  in the right place — so `QT6QSCINTILLA_LIBRARY` and `QT6QSCINTILLA_INCLUDE_DIR`
  are handed over directly.
- **The mesa trap again** (same one `eda-coin` and `eda-freecad` hit). The cmake
  PortGroup passes `-DCMAKE_FIND_FRAMEWORK=LAST`, so with mesa installed
  `find_package(OpenGL)` reports `/opt/local/lib/libGL.dylib` and leaves
  `-framework OpenGL` off the link line. That only blows up at the very end,
  after a 100% compile, because OpenSCAD's macOS offscreen context is CGL-based
  and mesa has no CGL symbols:

  ```
  ld: Undefined symbols: _CGLChoosePixelFormat, _CGLCreateContext, ...
    referenced from CreateOffscreenContextCGL(...) in OffscreenContextCGL.cc.o
  ```

  Fix is to name `OpenGL.framework` explicitly via `OPENGL_gl_LIBRARY` /
  `OPENGL_glu_LIBRARY`. Set *only* those two — adding
  `OPENGL_INCLUDE_DIR=<framework>/Headers` makes CMake's `try_compile` fail.
- Also off by default here: `ENABLE_TESTS`/`ENABLE_GUI_TESTS`/`MANIFOLD_TEST`
  (all default ON, and would run the very large upstream testsuite as part of
  the build) and `ENABLE_GAMEPAD` (defaults AUTO, and its Qt5Gamepad driver
  does not exist under Qt6 — CMake hard-errors on that combination).
  `SNAPSHOT=ON` matches what this tag is and selects the nightly icon set, so
  the app is visibly distinct from a stable release.
- **The macOS install puts an `.app` inside `bin/`, and no `openscad` command.**
  On the Apple branch upstream's CMakeLists does only
  `install(TARGETS OpenSCADExe BUNDLE DESTINATION ${CMAKE_INSTALL_BINDIR})` —
  man page, color-schemes, examples, fonts, MCAD, locale, shaders and templates
  all go inside the bundle's Resources rather than `${prefix}/share`. So
  `post-destroot` moves the bundle to `/Applications/MacPorts` and drops a
  lowercase wrapper on PATH, the same shape `kicad` and `eda-freecad` use. It's
  a wrapper and not a symlink because a bundle finds its Resources relative to
  the executable's real path. FreeCAD's OpenSCAD workbench shells out to an
  external binary, so it needs that wrapper — point it there under
  *Edit → Preferences → OpenSCAD*. The same binary serves GUI and CLI; `-o`
  switches it to rendering (`openscad -o part.stl part.scad`).
- **Verified** (macOS 15 / Qt 6.7.3 build): `openscad --version` reports
  2026.08.19, a 40×30×12 enclosure shell renders to a valid STL (16 vertices,
  28 facets), the binary links Apple's `OpenGL.framework` rather than mesa, and
  the `.app` registers with LaunchServices as `kMDItemKind = "Application"`.
- **Watch out on a machine with a different Qt.** `${qt6.dir}` resolves
  per-machine, but the qscintilla library filename in `configure.args` is
  literal. If configure fails on `QT6QSCINTILLA_LIBRARY`, check
  `port contents qscintilla-qt6 | grep dylib` and adjust. MacPorts is on
  qscintilla 2.14.1 as of this writing, which still uses
  `libqscintilla2_qt6.dylib`.
- **Stock `OpenCSG` drags in `qt5-qtbase`.** The MacPorts `OpenCSG` 1.4.2 port
  builds through the `qmake5` PortGroup and lib-depends on Qt 5 — the library
  itself needs only GLEW/GL, but the tarball ships a Qt example app and there
  is no variant to opt out. So on a machine without Qt 5, `port install
  openscad` pulls a whole Qt 5 base onto a Qt 6 port. The alternative is
  `USE_BUILTIN_OPENCSG=ON` plus vendoring `submodules/OpenCSG` (upstream builds
  it with plain CMake, no qmake, no Qt) — not currently done.

## nec2c notes (NEC-2 antenna simulation, command-line)

- **nec2c** is Neoklis Kyriazis' C translation of NEC2, the FORTRAN Numerical
  Electromagnetics Code — a **non-interactive** program that reads a standard
  NEC2 input deck and writes a NEC2-format output file. Method-of-moments for
  wire antennas, complementing the FDTD solver in this tree's openEMS. Packaged
  from the **KJ7LNW** continuation (v1.3.3), the same upstream that maintains
  xnec2c.
- **The stock MacPorts `xnec2c` port does NOT replace it.** xnec2c is the GTK3
  GUI, and per upstream's README: *"Printing of results to an output file has
  been removed starting from version 1.0 … If printing to file is needed then it
  is better to use the original NEC2 program."* Its `-j<n>` flag is
  multi-threading, not batch mode. The two are complementary and share no files —
  `sudo port install xnec2c` for the GUI, `nec2c` for scripted work.
  (For the record, stock `xnec2c` is current: 4.4.18 matches the newest upstream
  tag and the repo is actively maintained.)
- Plain port name, not `eda-nec2c`: MacPorts has no `nec2c`, so nothing collides —
  same reasoning as `cvc-rv` / `sv2v` / `ghdl`.
- Trivial to build: pure C, autotools, and the **only** library it wants is
  `libm` (in libSystem), so it has no port dependencies at all. The GitHub tarball
  has no generated `configure`, hence `use_autoreconf yes` (which supplies
  autoconf/automake itself — declaring them again makes lint warn).
- **GOTCHA — run it from a writable directory.** nec2c writes a plot side-file
  `<input>.plt` **next to the input deck**. Pointing `-i` at the installed
  examples fails partway with `nec2c: .../3E_.NEC.plt: Permission denied` and
  leaves a **truncated** output (geometry only, no antenna parameters or
  radiation pattern) — easy to misread as a bad model. Copy the deck first.
  Verified: 65 lines from the read-only path vs **863 lines** with both
  `ANTENNA INPUT PARAMETERS` and `RADIATION PATTERN` from a writable one.
- 108 example decks from the source tree are installed to
  `${prefix}/share/doc/nec2c/examples`. `port test` runs one end to end and
  checks for the NEC2 banner in the output.

## CACE notes (analog characterization — `eda-cace` port)

- **CACE** (Circuit Automatic Characterization Engine, `cace design.yaml`):
  drives ngspice/xyce + magic/netgen/klayout to characterize an analog block
  against a datasheet of parameters and emit an annotated results datasheet.
  This is the analog-side flow validation (the counterpart to LibreLane on
  the digital side).
- **Now a MacPorts port**, `cad/eda-cace` (was a venv). `sudo port install
  eda-cace` installs the `cace` CLI and the `cace-web` Flask GUI on PATH.
  Named `eda-cace` (not `py-cace`) because it is an application, not a
  reusable library; it is an *app-style* python port (name is not `py-*`, so
  the python portgroup builds a single version at `python.default_version`
  with no `pyXY-` subports and installs the console scripts unsuffixed).
  Pinned to **python 3.12** (matplotlib's TkAgg backend + the analog venvs).
  Needs `PDK_ROOT` (sky130A via ciel/installskywater) at run time.
- **`py-ciel` dependency port** (`python/py-ciel`): CACE's only dep missing
  from MacPorts. Ciel is the FOSSi Foundation's continuation of volare (same
  deps: click/httpx/pcpp/yaml/rich/zstandard — all already present) and
  ships an unsuffixed `ciel` for the default python like py-volare. Every
  other CACE dep (matplotlib, numpy, Pillow, rich, flask, **mpld3 0.5.10**
  exactly) is already in MacPorts.
- **Tk is a declared dep now** (`py${v}-tkinter`): CACE hard-imports
  matplotlib's TkAgg backend, so the port pulls it in. (In the old venv you
  had to `sudo port install py312-tkinter` by hand or `cace` died with
  `ModuleNotFoundError: No module named '_tkinter'`.)
- **user-site shadowing gotcha** (why the scripts run `python -s`): the
  framework python3.12 puts `~/Library/Python/3.12` (a `pip install --user`
  site) on `sys.path` *ahead* of the MacPorts packages. A stale `--user`
  click 7.1.2 there shadows the port's click 8.3.3 and breaks `cace-web`
  (`ImportError: cannot import name 'ParameterSource' from click.core`). The
  port's `post-destroot` appends `-s` to the `cace`/`cace-web` shebangs so
  they ignore the user site and run against their declared deps only. If you
  migrated from the venv, also remove the stale drivers so the port wins on
  PATH: `rm ~/.local/bin/cace ~/.local/bin/cace-web` (the old venv wrappers,
  earlier in PATH than `/opt/local/bin`), and consider clearing the whole
  `~/Library/Python/3.12` `--user` stack — it shadows *every* MacPorts
  python3.12 tool, not just cace.
- The install is the easy part; the actual work is writing a CACE datasheet
  (YAML: parameters, testbenches, limits) for a real circuit — that's design.

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
- Needs `tk8-x11` (was `tk-x11` until MacPorts' 2026-07 Tcl/Tk 8/9 port split;
  the old name is a `replaced_by` stub with **no checksums**, and dependency
  installs ignore `replaced_by`, so depending on it breaks upgrades —
  netgen-lvs/magic/xcircuit were all retargeted to `tk8-x11` paths on
  2026-07-09): netgen's Tcl build refuses to compile without X11, so the X11
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
- **Pinned to mob commit `3369a83f` (2026-08-01)**, 44 commits past the
  `v24.0.1mob` tag. The tag is still upstream's newest, but the `mob` branch had
  moved well ahead with fixes worth having: the 2026-07-04 bugfix sweep
  (noise_table crash, `ac_stim` panic, `idt` initial condition, `idtmod`
  wrap/offset, `laplace_nd` feedthrough, whole-array-assignment ICE, array
  lower-bound indexing, `$simparam$str`) and the VAMS-2023 wave (repaired
  `ceil`/`hypot`/`$clog2` codegen, `expm1`/`ln1p`, `$min`/`$max`/`$abs`,
  `$rtoi`/`$itor`, named events, dynamic `transition()` tolerances). Verified by
  A/B: the tag rejects `expm1`/`$max` as unknown, this pin compiles them.
  The oldest tag `v24.0.0mob` has 2022-era codegen that **segfaults** emitting
  OSDI metadata on LLVM 18 — never pin it.
- The bump was cheap because `Cargo.lock` was byte-identical tag→mob: the
  crate pin list needed no regeneration and the salsa rev was unchanged. Check
  that first on any future bump (the Portfile header lists all four things to
  re-verify).
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
- The digital P&R side is packaged too — see the `openroad`/`openroad-ll`
  notes (this bullet used to say OpenROAD wasn't packaged; that predates the
  26Q3 CMake port).

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
  Both openroad and openroad-ll **fail fast** via a `pre-build` check if any
  of the four is still active, printing these commands; if a build already
  failed with a gate missed, `sudo port clean` the port before retrying
  (stale CMake cache). Their swig needs (`swig-tcl`/`swig-python`) are
  declared deps since 2026-07-08, so those install automatically.
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

## netlistsvg notes (SVG schematics from yosys JSON)

- netlistsvg draws SVG schematics from `yosys ... write_json` output; the
  SkyWater sky130 PDK build uses it to render standard-cell schematics.
  Installs `netlistsvg` and `netlistsvg-dumplayout`. `supported_archs noarch`.
- It is an npm package, but the port never runs npm: the npm registry tarball
  plus all **70 runtime dependency tarballs** are pinned as checksummed
  distfiles (same philosophy as openvaf's crate pins). npm's resolved tree is
  flat, so `post-extract` just untars each dep into `node_modules/<name>`
  (`--strip-components=1`, since the `@types/*` tarballs don't use the usual
  `package/` root). Everything lands in `${prefix}/lib/node_modules/netlistsvg`
  with `bin` symlinks; shebangs are repointed at `${prefix}/bin/node`.
- Runtime dep is `path:bin/node:nodejs22` — any MacPorts nodejs satisfies it.
- On a version bump, regenerate the dep list per the comment block in the
  Portfile (`npm install --package-lock-only`, re-hash the resolved tarballs,
  and re-check the tree is still flat).
- Verified: `port test netlistsvg` renders an SVG from a small `$and` netlist,
  and the installed binary does the same.

## sv2v notes (SystemVerilog → Verilog-2005, built from source)

- zachjs/sv2v v0.0.13: converts synthesizable SystemVerilog (always_ff/
  always_comb, logic, interfaces, packages...) to Verilog-2005 for tools with
  weak SV frontends (iverilog; yosys without the slang plugin). Not in stock
  MacPorts.
- It's a **Haskell** program, **built from source, offline, native on both
  architectures** (rev 0 repackaged upstream's x86_64-only binary and needed
  Rosetta on Apple Silicon; rev 1 replaced it). Toolchain: MacPorts
  `ghc-prebuilt` + `cabal-prebuilt` (official-bindist repackages, binary
  archives — no GHC bootstrap build).
- Offline Hackage vendoring (this tree's npm/crates pattern, adapted): the 10
  non-boot packages the cabal solver picked — including the **alex/happy**
  build tools, so those MacPorts ports aren't needed — are pinned as
  checksummed distfiles, extracted, and listed in a generated cabal.project
  as **local packages** with `active-repositories: none`; `cabal build
  --offline` never touches a repository or index. Three tricks were needed
  (all in the Portfile, commented):
  1. Raw Hackage tarballs carry stale `base < 4.x` bounds that Hackage only
     fixed via metadata *revisions* an offline build never sees →
     pre-build relaxes boot-lib upper bounds in the vendored .cabal files.
  2. cabal solves ALL components of local packages (ignoring `tests: False`
     and `--disable-tests`) → test-suite/benchmark stanzas AND test/bench
     sub-libraries (vector's `library benchmarks-O2` wants tasty) are
     stripped; load-bearing sub-libraries (happy-lib's) are kept.
  3. cabal finds ghc/ghc-pkg by name → symlinks into a private CABAL_DIR
     (same trick as the stock haskell_cabal PortGroup's bootstrap mode).
- sv2v's githash version stamp has a no-git fallback (`tGitInfoCwdTry`), so
  tarball builds report the plain cabal version — no git needed.
- `port test` verifies an always_ff/logic module converts to
  `always @(posedge ...)` / `reg`. Version-bump procedure is in the Portfile
  header (networked `cabal build --dry-run` → update the pin list).

## verification additions (eqy, mcy, cvc-rv, irsim) & checktools.sh

- **eqy/mcy v0.66** — version-locked to yosys 0.66 (YosysHQ releases them in
  lockstep; bump all three together). eqy's yosys plugins compile against the
  yosys port's headers; both scripts get the sby-style `.gittag` +
  python3.13-shebang treatment. mcy's Qt GUI is deliberately not built.
- **cvc-rv 1.1.7** — ERC on extracted CDL netlists. Must build with
  **gcc13/libstdc++**: its mmap_allocator pokes libstdc++ internals
  (`_M_impl`) that libc++ lacks; also patches obstack's `stdint-gcc.h`
  include. Binary is `cvc_rv`. Quirk: EVERY cvc_rv invocation (even
  `--version`) writes a `default.cvcrc` template into the current directory
  — run it from a work dir, not somewhere you care about.
- **irsim 9.7.117** — vendored stock snapshot **plus real fixes**: stock
  builds "successfully" on Xcode 15+ but silently omits `tclirsim.dylib`
  (the opencircuitdesign Makefiles swallow subdir failures — same trap as
  netgen). Fixes: `-Wno-error=implicit-function-declaration/int-conversion`
  appended to the TOP-LEVEL `defs.mak` (configure ignores env CFLAGS; and
  `scripts/defs.mak` is a decoy copy), `-noprebind` stripped (removed in
  Xcode 15 ld), `-fno-common`→`-fcommon`, and a patch guarding base
  `logprint` with `#ifndef TCL_IRSIM` (duplicate symbol vs tclirsim.c).
- **py313-gdstk 1.0.0** — GDS/OASIS scripting; upstream CMake hardcodes a
  universal build, overridden to the port's build_arch via `CMAKE_ARGS`.
- **`./checktools.sh`** smoke-tests the whole INSTALLED toolchain (28 tools,
  seconds, no sudo, no GUIs) — run it after upgrades or on a new machine.
  Exit code = number of failures.

## ghdl notes (VHDL simulator)

- GHDL **5.1.1**, LLVM backend, from upstream's **official per-architecture
  prebuilt bundles** (GHDL is Ada; MacPorts has no usable GNAT — same
  repackage precedent as eda-or-tools). **v5.1.1 chosen deliberately for
  portability**: it is the newest release with BOTH macOS assets
  (`macos13-x86_64` for the Intel boxes, `macos14-aarch64` for arm64) — the
  same GHDL version on every machine. v6.0.0 dropped the x86_64 asset, so
  check assets before any version bump.
- Installs the self-contained bundle into `libexec/ghdl` (it carries its own
  `libgcc_s`, which must never land in `${prefix}/lib` where it could shadow
  the MacPorts libgcc runtime). `${prefix}/bin/ghdl` is a **wrapper script,
  not a symlink** — ghdl locates `ghdl1-llvm` and its precompiled std/ieee
  libraries relative to its invocation path *without resolving symlinks*, so
  a symlink breaks it (found the hard way).
- `ghdl -e` links simulation binaries with the system C toolchain at
  runtime (Xcode CLT — present on every MacPorts machine, no dep declared).
- GHW waveforms (`ghdl -r ... --wave=x.ghw`) open in the tree's gtkwave;
  `ghwdump` is also installed. cocotb supports GHDL for Python testbenches.
- Verified: VHDL-2008 counter testbench analyzes/elaborates/simulates with
  the correct result via `port test` AND the installed wrapper.
- Not included (possible follow-up): **ghdl-yosys-plugin** for VHDL
  *synthesis* through yosys → OpenROAD; needs a libghdl matched to our
  yosys 0.66 and a plugin build — scope it like openEMS if wanted.

## eda-ngspice notes (versioned ngspice + `port select`)

- **Several ngspice releases coexist**, each in its OWN private prefix, and
  `port select` chooses the active one:

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
  Each version keeps a versioned command regardless of what is selected — the
  same idea as `python3.12` beside `python3` — so a netlist or script can pin a
  simulator explicitly, which matters for reproducible analog results.
- **The selection covers the LIBRARY too, not just the binary.** The linked set
  is `bin/eda-ngspice` plus `libexec/eda/lib/libngspice.dylib`, `libngspice.0.dylib`
  and `lib/pkgconfig/ngspice.pc`. `kicad` dlopens
  `libexec/eda/lib/libngspice.dylib` **by path** at simulation time, so switching
  the selection changes KiCad's simulator **without rebuilding KiCad** — deliberate,
  but re-check a simulation there after switching.
- **Nothing is auto-selected.** Until `port select --set` is run there is no
  `bin/eda-ngspice` and no `libexec/eda/lib/libngspice.dylib`, so KiCad finds no
  simulator. That is normal MacPorts behaviour (same as python/clang) and is in
  `port notes eda-ngspice`.
- **The group is `eda-ngspice`, NOT `ngspice`** — `${prefix}/bin/ngspice` is a
  registry-owned file of the stock MacPorts ngspice port, and `port select`
  symlinks are not registry-owned, so targeting it would collide.
- **Binary and library are ONE port per version** (two out-of-tree builds:
  `--with-ngshared` builds the library *instead of* the binary, so they cannot
  share a configure run). They were a port plus a `-lib` subport before; two
  subports cannot both install the same `etc/select` entry, and KiCad needs the
  library link to follow the selection.
- **Gotchas found while building this:** `port select` creates symlinks but NOT
  the directories holding them, and is NOT atomic — a missing parent aborts the
  selection partway, after some links exist. `sharedspice.h` was therefore dropped
  from the select set: its parent directory cannot be owned by the select port
  because **MacPorts prunes empty directories from a destroot**. Version-specific
  headers live in `libexec/eda/ngspice<version>/include/ngspice/`.
- **MIGRATION from the pre-split layout** (needed once per machine):
  ```
  sudo port -f uninstall eda-ngspice-lib          # orphaned: gone from the index,
                                                  # but still owns the select path
  sudo port upgrade eda-ngspice                   # 46_0 -> stub 46_1
  sudo port install eda-ngspice46 eda-ngspice47
  sudo port select --set eda-ngspice eda-ngspice46
  ```
  The stub's `version` deliberately tracks the default it points at: this port
  used to BE the ngspice build at version 46, so a stub numbered 1.0 would sort
  *below* it and MacPorts would refuse the upgrade as a downgrade.
- Verified on macOS 13: both versions build, run and give an exact 1.000 V
  divider; the **openvaf → OSDI → ngspice chain works on 46 AND 47**; selection
  flips both the command and the library cleanly in both directions; and the
  library loads via the KiCad path (`ngSpice_Init` present) under either selection.

## openEMS notes (EC-FDTD EM solver, octave-free)

- openEMS (EM field solver for antennas/RF/on-chip passives) without the
  stock port's octave dependency. Four ports: **eda-vtk** (minimal VTK),
  **CSXCAD**, **openEMS**, and the python frontend **py313-csxcad /
  py313-openems**. `sudo port install py313-openems` pulls the whole chain.
- **eda-vtk** is the minimalist lever: openEMS/CSXCAD need only four VTK IO
  modules (IOXML, IOGeometry, IOLegacy, IOPLY — see their CMakeLists), so
  eda-vtk builds just those (+internal closure) into `libexec/eda`. No
  rendering, no Qt, no python wrapping; VTK's vendored third-party libs mean
  ZERO port dependencies (dylibs link only libSystem/libc++). ~20 min build
  vs hours for full vtk. Same distfile/checksum as the stock vtk port.
- **CSXCAD/openEMS shadow the stock ports by name** (same pinned commits and
  patches as stock) so `port install openEMS` can never drag in octave/vtk.
  Octave was runtime-only in stock; the matlab `.m` scripts still install
  under `share/openEMS/matlab` in case octave is ever wanted.
- The python bindings live in the same two repos (`python/` subdir, same
  distfiles). They build via legacy `setup.py` (`python.pep517 no`) because
  upstream's pyproject.toml wires a custom pip backend that vendors CSXCAD
  from a sibling checkout. Env `CSXCAD_INSTALL_PATH`/`OPENEMS_INSTALL_PATH`
  = `${prefix}` is required by their setup.py. py313-openems needs
  py313-csxcad at BUILD time (cython cimports its .pxd files).
- Deliberately skipped: QCSXCAD/AppCSXCAD (GUI viewer — would pull Qt5 + VTK
  rendering back in; view field dumps with ParaView if needed) and MPI.
- Verified end-to-end: a WR-90 TE10 waveguide FDTD sim via python
  (AddRectWaveGuidePort) gives S11 = -19.5 dB, S21 = -0.02 dB @ 25 GHz;
  compressed-SSE multithreaded engine, ~116 MCells/s on the Ventura i7.
  Tutorials: https://docs.openems.de/python/openEMS/Tutorials/

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
- **Simulator backend:** since rev 4 kicad depends on `eda-ngspice-lib` and
  its ngspice loader searches `${prefix}/libexec/eda/lib` — the simulator runs
  on the tree's pinned **ngspice 46**, not stock's libngspice (see the
  eda-ngspice notes).
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
- `ngspice` and `openEMS` used to be left on stock MacPorts; as of 2026-07
  both are in-tree: `openEMS`/`CSXCAD` shadow stock (octave-free, eda-vtk —
  see the openEMS notes) and `eda-ngspice` pins ngspice 46 for the flow while
  stock ngspice 44.2 keeps the plain name (see the eda-ngspice notes).

## lepton-eda / gtksheet notes (gEDA schematic capture & netlisting)

- **Lepton EDA** — the actively maintained fork of gEDA/gaf (stock MacPorts
  only has the abandoned `geda-gaf` 1.10.2). Pinned to **1.9.18**, upstream's
  last tagged release (2022; master is active but untagged). The port fetches
  the official *dist* tarball release asset, not the GitHub auto-archive.
- Built `--with-gtk3` (upstream's GTK2 path is legacy) against `gtk3 +x11`,
  and with MacPorts **`guile-3.0`** (the plain `guile` port is an obsolete
  stub; lepton's configure finds the suffixed `guile-3.0`/`guild-3.0`
  binaries by itself).
- **`gtksheet`** (new `x11/` port, fpaquet/gtksheet 4.3.14) satisfies
  lepton-attrib's GtkSheet-4 requirement under GTK3. Its git archive ships a
  stale checked-in `configure` with no `build-aux/`, so the port runs
  `autoreconf -fvi` (the gtk-doc/introspection m4s are bundled — no gtk-doc
  dep).
- **Dependency variants (both machines):** `gtk3 +x11` needs its *singleton*
  backends built for X11 too, or lepton dies at runtime dlopen:
  ```
  sudo port upgrade --enforce-variants libepoxy +x11 -quartz   # else: missing _epoxy_glXGetClientString
  sudo port upgrade --enforce-variants glib2 +x11 -quartz      # else: missing _g_desktop_app_info_get_filename
  ```
  Both are safe on a mixed quartz/x11 machine: nothing installed references
  libepoxy's CGL-only or glib2's `g_osx_app_info_*` quartz-only symbols
  (verified by an `nm` sweep; gtkwave/gtk2-quartz and gtk4-quartz unaffected).
  This is the same lesson as the cairo/pango rule in the macOS 15 notes.
- First run of any lepton tool auto-compiles the Guile Scheme libs into
  `~/.cache/guile/ccache` (a minute or so of `;;; compiling...` noise —
  harmless). If tools were run *before* the variant fixes above, delete that
  cache: stale `.go` files produce
  `Wrong type to apply: #<syntax-transformer check-string>`.
- Verified: `lepton-netlist -g spice-sdb` produces a correct netlist from the
  shipped TwoStageAmp example; `lepton-schematic` and `lepton-attrib` run
  under XQuartz; `lepton-cli --version` reports 1.9.18.

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
- **Build-time caveat:** `trilinos16` must be **deactivated** while `charon`
  or `trilinos-charon` builds — this is required, not belt-and-braces. Two
  distinct shadows through the TPL `-I${prefix}/include`: the serial stub
  `mpi.h` hides openmpi's real header (mitigated by `files/openmpi-first.cmake`
  via `CMAKE_PROJECT_TOP_LEVEL_INCLUDES`), and Trilinos-16's `Teuchos_any.hpp`
  (C++17 `std::is_constructible_v`) breaks charon's C++14 compile of the
  bundled Trilinos 13.4 — the shim cannot help there (seen 2026-07, stk_util).
  Both Portfiles carry a `pre-build` check that aborts in seconds with the
  recovery one-liner if `trilinos16` is active. Note MacPorts' rev-upgrade can
  re-activate `trilinos16` on its own mid-batch (it did so right after
  `trilinos-charon` finished installing once), so upgrade these ports one at a
  time, re-deactivating in between.
