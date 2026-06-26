#!/bin/bash
# Rewrite KLayout's bare inter-library install names to @rpath form so the
# LC_RPATH that build.sh already embeds resolves them on macOS.
#   $1 = directory tree to process (the staged install)
set -u
tree="$1"
find "$tree" -type f ! -type l | while IFS= read -r f; do
    file -b "$f" 2>/dev/null | grep -q 'Mach-O' || continue
    # Rewrite a bare LC_ID on the library itself.
    id=$(otool -D "$f" 2>/dev/null | sed -n '2p' | tr -d '[:space:]')
    case "$id" in
        lib*.dylib) install_name_tool -id "@rpath/$id" "$f" 2>/dev/null || true ;;
    esac
    # Rewrite every bare lib*.dylib dependency reference (klayout core libs at
    # the top level and the streamer plugins under db_plugins/lay_plugins).
    otool -L "$f" 2>/dev/null | tail -n +2 | awk '{print $1}' | while IFS= read -r d; do
        case "$d" in
            lib*.dylib) install_name_tool -change "$d" "@rpath/$d" "$f" 2>/dev/null || true ;;
        esac
    done
done
