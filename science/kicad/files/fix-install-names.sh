#!/bin/sh
# Rewrite KiCad's bare dylib install names to absolute MacPorts-prefix paths.
#
# KiCad's Unix install (KICAD_MACOSX_APP_BUNDLE=OFF) leaves its shared libraries
# (libkicommon/libkiapi/libkigal .10.0.4.dylib) with BARE install names and has
# the .kiface plugins + app binaries reference them by bare name with no rpath
# to ${prefix}/lib -- so the dynamic loader (and MacPorts rev-upgrade) cannot
# find them. We set each kicad lib's id to its absolute ${prefix}/lib path and
# rewrite every bare reference in the kicad libs/binaries/kifaces to match.
#
# Run via MacPorts `system` (NOT a Tcl exec): the trace-mode sandbox blocks raw
# Tcl exec of /usr/bin tools like install_name_tool/otool.
#
# Usage: fix-install-names.sh <prefix> <destrootprefix>
set -e
prefix="$1"          # e.g. /opt/local
droot="$2"           # e.g. <destroot>/opt/local
libdir="${droot}/lib"
bindir="${droot}/bin"
INT=/usr/bin/install_name_tool
OTOOL=/usr/bin/otool

# Collect the kicad versioned dylib basenames (real files, not the unversioned
# symlinks), and set each one's install id to an absolute path.
kilibs=""
for f in "${libdir}"/libki*.dylib; do
    [ -f "$f" ] || continue
    [ -L "$f" ] && continue
    base=$(basename "$f")
    kilibs="${kilibs} ${base}"
    ${INT} -id "${prefix}/lib/${base}" "$f"
done

# Rewrite bare references to those libs in every kicad Mach-O (libs cross-ref
# each other; binaries and .kiface plugins reference them).
fix_refs() {
    f="$1"
    [ -f "$f" ] || return 0
    [ -L "$f" ] && return 0
    /usr/bin/file "$f" | grep -q 'Mach-O' || return 0
    for base in ${kilibs}; do
        if ${OTOOL} -L "$f" | grep -q "	${base} "; then
            ${INT} -change "${base}" "${prefix}/lib/${base}" "$f"
        fi
    done
}

# Binaries + .kiface plugins in bin (incl. extensionless executables), plus
# every dylib/plugin anywhere under lib (e.g. lib/kicad/plugins/3d/*.so).
for f in "${bindir}"/*; do
    fix_refs "$f"
done
find "${libdir}" -type f \( -name '*.dylib' -o -name '*.so' \) 2>/dev/null | while IFS= read -r f; do
    fix_refs "$f"
done
