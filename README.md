# macportseda

A local [MacPorts](https://www.macports.org/) port tree for EDA tools.  Tested on MacOS 13 and MacOS 15 (see the macOS 15 notes below). (I tried the new MacOS and they used more power and did less)
This work is motivated by the fact that my needs that generally don't overlap with most communities.  
I always felt bad contributing to macports because I'm not a very good at software engineering, and the lack of experience made me a bad collaborator.  I'm still poor at GIT.

Tested on my macOS 13 and macOS 15 machines.

Regarding Skywater's 130 PDK, I've never tried py-voltare; however, I use the [https://github.com/bpdegnan/spicesupport](https://github.com/bpdegnan/spicesupport) repo and the [installskywater.sh](https://raw.githubusercontent.com/bpdegnan/spicesupport/refs/heads/main/installskywater.sh) script in that repo.

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
    ├── netlistsvg/     # SVG schematics from yosys JSON (sky130 PDK dep)
    │   └── Portfile
    ├── eda-vtk/        # minimal VTK IO subset (private prefix) for openEMS
    │   └── Portfile
    ├── eda-ngspice/    # pinned ngspice 46 (private prefix) for the analog flow
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
    └── (see science/ and x11/ for the rest)
x11/
├── gtksheet/          # GtkSheet widget lib (lepton-attrib dependency)
│   └── Portfile
└── xcircuit/          # vendored stock snapshot
    └── Portfile
science/
├── xschem/
│   └── Portfile
├── lepton-eda/        # gEDA/gaf fork: lepton-schematic, -netlist, -attrib
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
├── py-cxxheaderparser/ # build dep of yosys +pyosys
│   └── Portfile
├── py-csxcad/          # python bindings for CSXCAD (openEMS frontend)
│   └── Portfile
├── py-openems/         # python bindings for openEMS
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
   | lepton-eda | `sudo port install lepton-eda` | gEDA/gaf fork. GTK3/X11 GUIs → XQuartz; **needs `libepoxy +x11` and `glib2 +x11`** (see notes). Pulls `gtksheet`. |
   | xyce | `sudo port install xyce` | Parallel SPICE; pulls `trilinos16`. |
   | py-volare | `sudo port install py-volare` | PDK manager; py313, installs `volare`. |
   | skim-app | `sudo port install skim-app` | Skim PDF/EPS reader → `/Applications/MacPorts`. |
   | netlistsvg | `sudo port install netlistsvg` | SVG schematics from yosys JSON (sky130 PDK build dep). |
   | eda-ngspice | `sudo port install eda-ngspice` | Pinned ngspice 46 → `eda-ngspice` on PATH (stock ngspice keeps the plain name). |
   | openEMS (python) | `sudo port install py313-openems` | Octave-free EM solver chain: pulls eda-vtk, CSXCAD, openEMS, py313-csxcad. |
   | kicad | see below ⚠️ | Full EDA suite + libraries. **Needs `boost` deactivated to build.** Simulates on eda-ngspice-lib (ngspice 46). |
   | trilinos-charon / charon | see below ⚠️ | TCAD; **need `trilinos16` deactivated to build.** |

   Installing `OpenSTA` pulls in the local `cudd` port automatically.

   **Build-time deactivation gotchas** (MacPorts can't do these automatically —
   the build *fails* without them):

   If a build already failed because a gate was missed, run
   `sudo port clean <port>` before retrying with the gate applied — the
   leftover CMake cache in the work directory remembers the shadowed include
   paths and reproduces the failure even after deactivation.

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

## distfiles archive (offline insurance)

`distfiles/` holds a copy of every source tarball the tree's ports fetch,
because upstream URLs rot. It is gitignored (2.4+ GB; GitHub rejects files
over 100 MB) — keep it with your backups. The Portfile checksums authenticate
every file, so the archive needs no special trust.

- **Restore** onto any machine, then install normally (MacPorts uses the
  already-present, checksum-verified files without touching the network):
  ```
  sudo rsync -a distfiles/ /opt/local/var/macports/distfiles/
  ```
- **Refresh** after adding or bumping a port:
  ```
  sudo port mirror <port>
  rsync -a /opt/local/var/macports/distfiles/<port> distfiles/
  ```
- **Off-machine copy**: also published as per-port tars + `SHA256SUMS` on the
  GitHub release `distfiles-2026-07` (release assets allow 2 GB/file). To
  refresh: re-tar the changed port dirs and
  `gh release upload distfiles-2026-07 <tars> SHA256SUMS --clobber`.
  (`gh release create` would also create a git tag on the remote.)

### Where the tarballs come from

| Port | Upstream source |
|------|-----------------|
| OpenSTA | [parallaxsw/OpenSTA @ bfdd2be](https://github.com/parallaxsw/OpenSTA/archive/bfdd2be0ee6214115b20cacdc0a071ca3c737fbb/OpenSTA-bfdd2be0ee6214115b20cacdc0a071ca3c737fbb.tar.gz) (no upstream tags) |
| cudd | [cuddorg/cudd 3.0.0](https://github.com/cuddorg/cudd/archive/refs/tags/3.0.0.tar.gz) |
| netgen-lvs | [RTimothyEdwards/netgen 1.5.321](https://github.com/RTimothyEdwards/netgen/archive/refs/tags/1.5.321.tar.gz) |
| klayout | [KLayout/klayout v0.30.9](https://github.com/KLayout/klayout/archive/refs/tags/v0.30.9.tar.gz) |
| gtkwave | [SourceForge gtkwave 3.3.117](https://downloads.sourceforge.net/project/gtkwave/gtkwave-3.3.117/gtkwave-3.3.117.tar.gz) |
| openvaf | [OpenVAF/OpenVAF-Reloaded v24.0.1mob](https://github.com/OpenVAF/OpenVAF-Reloaded/archive/v24.0.1mob/OpenVAF-Reloaded-24.0.1mob.tar.gz) + pinned crates from [crates.io](https://static.crates.io/crates/) + the [pascalkuthe/salsa](https://github.com/pascalkuthe/salsa) fork (all listed in the Portfile) |
| yosys | [YosysHQ/yosys v0.66 `yosys-src.tar.gz`](https://github.com/YosysHQ/yosys/releases/download/v0.66/yosys-src.tar.gz) (release asset, bundles ABC) |
| sby | [YosysHQ/sby @ d3e72d2](https://github.com/YosysHQ/sby/archive/d3e72d26e8634bca4ca16f3e4d84331481f06ab6/sby-d3e72d26e8634bca4ca16f3e4d84331481f06ab6.tar.gz) |
| netlistsvg | [npm netlistsvg 1.0.2](https://registry.npmjs.org/netlistsvg/-/netlistsvg-1.0.2.tgz) + 70 pinned npm dep tarballs from registry.npmjs.org (all listed in the Portfile; no npm at build time) |
| eda-vtk | [Kitware/vtk v9.6.2](https://github.com/Kitware/vtk/archive/v9.6.2/vtk-9.6.2.tar.gz) (same distfile as stock vtk) |
| eda-ngspice (+ eda-ngspice-lib) | [ngspice 46 (SourceForge)](https://sourceforge.net/projects/ngspice/files/ng-spice-rework/46/ngspice-46.tar.gz) |
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
- **Pinned to the `v24.0.1mob` tag.** The older `v24.0.0mob` tag has 2022-era
  codegen that **segfaults** emitting OSDI metadata on LLVM 18 (which
  originally forced pinning a mob-branch commit); upstream has since tagged
  the fix.
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

## eda-ngspice notes (pinned ngspice for the analog flow)

- ngspice **46** in the private prefix `libexec/eda`, COEXISTING with the
  stock MacPorts ngspice (44.2), which stays at the release cadence. On PATH
  as **`eda-ngspice`**; plain `ngspice` remains stock's. Put
  `libexec/eda/bin` early in PATH to make 46 the default.
- **eda-ngspice-lib** subport: libngspice 46 (+ sharedspice.h + ngspice.pc)
  in `libexec/eda`, verified through the shared API (ctypes init/load/run).
  The tree's **kicad** port now depends on it and its ngspice loader is
  patched to `libexec/eda/lib` — KiCad 10 simulates on ngspice 46, not
  stock's 44.2. Codemodels (`lib/ngspice/*.cm`) come from the eda-ngspice
  binary port (runtime dep of the lib subport, `--enable-relpath`).
- Same recipe as the stock port (the user maintains that one): cider, xspice,
  pss, readline, X11 plotting; both 44.2 patches still apply to 46 (targets
  verified). **OSDI is default-on since ngspice 45** — no flag needed.
- Verified: RC-divider transient (`port test`), and the full
  **openvaf -> OSDI -> ngspice 46** chain: a Verilog-A resistor compiled with
  `openvaf-r`, loaded via `pre_osdi`, gives an exact 1.000 V divider op-point.
- OSDI usage notes learned: `pre_osdi file.osdi` must be in the FIRST
  .control block (or .spiceinit) so devices exist before parsing; ngspice
  lowercases netlists, so keep Verilog-A parameter names lowercase; plain VA
  parameters are MODEL parameters (`.model m res_va r=1k`), not instance
  parameters, unless the VA declares `(*type="instance"*)`.

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
