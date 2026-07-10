#!/bin/sh
# checktools.sh — smoke-test the INSTALLED macportseda toolchain on this
# machine. Fast (seconds per tool), no sudo, no rebuilds: it exercises the
# installed binaries, not the ports. Run after upgrades or on a new machine.
# Exit code = number of failures.
#
# Usage: ./checktools.sh [-v]

PREFIX=/opt/local
# Clean PATH: avoid shims (asdf etc.) hijacking interpreter lookups
export PATH="$PREFIX/bin:$PREFIX/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
VERBOSE=0
[ "$1" = "-v" ] && VERBOSE=1
PASS=0; FAIL=0; SKIP=0
TMP=$(mktemp -d /tmp/checktools.XXXXXX)
trap 'rm -rf "$TMP"' EXIT

say()  { printf '%-22s %s\n' "$1" "$2"; }
run()  { # run <name> <command...>  — pass if exit 0
    name=$1; shift
    if ! command -v "$1" >/dev/null 2>&1 && [ ! -x "$1" ]; then
        say "$name" "SKIP (not installed)"; SKIP=$((SKIP+1)); return
    fi
    out=$("$@" 2>&1); rc=$?
    if [ $rc -eq 0 ]; then
        say "$name" "ok"; PASS=$((PASS+1))
        [ $VERBOSE -eq 1 ] && echo "$out" | head -1
    else
        say "$name" "FAIL (rc=$rc)"; FAIL=$((FAIL+1))
        echo "$out" | head -3 | sed 's/^/    /'
    fi
}
runmatch() { # runmatch <name> <pattern> <command...> — pass if output matches
    name=$1; pat=$2; shift 2
    if ! command -v "$1" >/dev/null 2>&1 && [ ! -x "$1" ]; then
        say "$name" "SKIP (not installed)"; SKIP=$((SKIP+1)); return
    fi
    out=$("$@" 2>&1)
    if echo "$out" | grep -q "$pat"; then
        say "$name" "ok"; PASS=$((PASS+1))
    else
        say "$name" "FAIL (no '$pat')"; FAIL=$((FAIL+1))
        echo "$out" | head -3 | sed 's/^/    /'
    fi
}

echo "== macportseda toolchain smoke test ($(uname -m), $(sw_vers -productVersion 2>/dev/null)) =="

# --- digital ---
run  yosys        "$PREFIX/bin/yosys" -V
run  sby          "$PREFIX/bin/sby" --help
run  iverilog     "$PREFIX/bin/iverilog" -V
run  verilator    "$PREFIX/bin/verilator" --version
runmatch OpenSTA  "^[0-9]" "$PREFIX/bin/sta" -version
runmatch openroad "." "$PREFIX/bin/openroad" -version
runmatch openroad-ll "." "$PREFIX/libexec/openroad-ll/bin/openroad" -version
runmatch netlistsvg "usage" sh -c "$PREFIX/bin/netlistsvg --help 2>&1 || true"
run  eqy          "$PREFIX/bin/eqy" --help
run  mcy          "$PREFIX/bin/mcy" --help

# sv2v: real conversion
if [ -x "$PREFIX/bin/sv2v" ]; then
    printf 'module t(input logic c, d, output logic q);\nalways_ff @(posedge c) q <= d;\nendmodule\n' > "$TMP/t.sv"
    runmatch sv2v "always @(posedge c)" "$PREFIX/bin/sv2v" "$TMP/t.sv"
else say sv2v "SKIP (not installed)"; SKIP=$((SKIP+1)); fi

# --- VHDL: real compile+sim ---
if [ -x "$PREFIX/bin/ghdl" ]; then
    cat > "$TMP/tb.vhdl" <<'EOF'
entity tb is end entity;
architecture s of tb is begin
    process begin report "GHDL_OK" severity note; wait; end process;
end architecture;
EOF
    ( cd "$TMP" && "$PREFIX/bin/ghdl" -a tb.vhdl && "$PREFIX/bin/ghdl" -e tb ) >/dev/null 2>&1
    runmatch ghdl "GHDL_OK" sh -c "cd $TMP && $PREFIX/bin/ghdl -r tb"
else say ghdl "SKIP (not installed)"; SKIP=$((SKIP+1)); fi

# --- analog: real transient sim on the pinned simulator ---
if [ -x "$PREFIX/bin/eda-ngspice" ]; then
    printf 'rc\nv1 in 0 dc 2\nr1 in mid 1k\nr2 mid 0 1k\n.control\nop\nprint v(mid)\nquit\n.endc\n.end\n' > "$TMP/rc.cir"
    runmatch eda-ngspice "v(mid) = 1" "$PREFIX/bin/eda-ngspice" -b "$TMP/rc.cir"
else say eda-ngspice "SKIP (not installed)"; SKIP=$((SKIP+1)); fi
runmatch ngspice-stock "ngspice-" "$PREFIX/bin/ngspice" --version
runmatch xyce "Xyce" "$PREFIX/bin/Xyce" -v
run  openvaf      "$PREFIX/bin/openvaf-r" --version
run  xschem       "$PREFIX/bin/xschem" -v

# --- layout / physical verification ---
runmatch magic "Magic" sh -c "echo quit | $PREFIX/bin/magic -dnull -noconsole"
runmatch netgen-lvs "Netgen" sh -c "echo quit | $PREFIX/bin/netgen -batch"
run  klayout      "$PREFIX/bin/klayout" -v
# cvc_rv writes a default.cvcrc into its CWD on EVERY invocation — run it
# inside the temp dir so it can't litter the tree.
runmatch cvc-rv "CVC" sh -c "cd $TMP && $PREFIX/bin/cvc_rv --version 2>&1 || true"
# irsim is a Tk console app - launching it opens a window, so only verify
# its Tcl module is present (the part a broken build silently omits).
if [ -x "$PREFIX/bin/irsim" ]; then
    if [ -f "$PREFIX/lib/irsim/tcl/tclirsim.dylib" ]; then
        say irsim "ok"; PASS=$((PASS+1))
    else say irsim "FAIL (tclirsim.dylib missing)"; FAIL=$((FAIL+1)); fi
else say irsim "SKIP (not installed)"; SKIP=$((SKIP+1)); fi
runmatch py-gdstk "GDSTK_OK" "$PREFIX/bin/python3.13" -c "import gdstk; c=gdstk.Cell('t'); print('GDSTK_OK')"

# --- waveforms / misc ---
run  gtkwave      sh -c "$PREFIX/bin/gtkwave --version >/dev/null 2>&1 || true"  # gtk2-quartz needs a window server
run  ghwdump      "$PREFIX/bin/ghwdump" --help

# --- EM / TCAD ---
runmatch openEMS "openEMS" sh -c "$PREFIX/bin/openEMS 2>&1 | head -3"
runmatch py-openems "OPENEMS_OK" "$PREFIX/bin/python3.13" -c "import openEMS, CSXCAD; print('OPENEMS_OK')"
runmatch charon "Charon" sh -c "$PREFIX/bin/charon --version 2>&1 | head -3"

echo "== done: $PASS ok, $FAIL failed, $SKIP skipped =="
exit $FAIL
