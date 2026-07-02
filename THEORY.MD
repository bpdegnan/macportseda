# Theory: macportseda — a self-contained MacPorts EDA catalog

## Problem

Open-source EDA tooling is either missing from MacPorts, abandoned there
(geda-gaf 1.10.2), or breaks when upstream and MacPorts drift apart
(OpenROAD vs its deps, KiCad stuck at 7). The user's workflow (sky130
analog + digital flows, TCAD) needs pinned, known-good versions that
build on both macOS 13 and 15. Upstream URLs also rot, so sources are
archived (distfiles/ + GitHub release assets).

## Operating Theory

A local port tree that shadows stock MacPorts (file:// source above the
rsync line) is the right lever: it can pin exact revisions, carry local
patches, and vendor stock ports as snapshots without maintaining forks.
Version conflicts with stock MacPorts are solved by private prefixes
(`libexec/eda`, `libexec/trilinos-charon`, `libexec/openroad-ll`) rather
than fighting the global namespace; where headers still shadow
(`/opt/local/include` beats `-isystem`), builds gate on temporarily
deactivating the offending ports (boost, spdlog, protobuf3-cpp, OpenSTA,
trilinos16). Python-ecosystem flow drivers (LibreLane, cocotb) stay out
of MacPorts entirely — uv venvs + thin wrappers work better.

## Current Work: lepton-eda port

Adding lepton-eda (the maintained gEDA/gaf fork — schematic capture,
netlisting, Guile-scriptable) as `science/lepton-eda`. Stock MacPorts
only has the dead geda-gaf 1.10.2.

Decisions:
- **Pin the 1.9.18 release asset** (2022-05-29), the last upstream
  release. It is a real autotools dist tarball (configure pre-built);
  the GitHub auto-archive would need autogen. Master is active (2026)
  but untagged; can pin a snapshot later if 1.9.18 shows its age.
- **GTK3 GUI** (`--with-gtk3`) against the installed gtk3 +x11 —
  consistent with the tree's XQuartz-based GUI stack, and upstream's
  forward direction (GTK2 is their legacy path).
- **Guile 3.0** (`port:guile`): configure prefers guile-3.0, falls back
  to 2.2. Guile is not yet installed here — first build pulls it.
- BSD awk suffices (configure only needs gsub/toupper); groff via
  `bin:` dep; libstroke is opt-in upstream and skipped.

Both ports **build and install** (lepton-eda @1.9.18, gtksheet @4.3.14).
Portfile lessons: MacPorts' plain `guile` is an obsolete stub — depend on
`guile-3.0`; lepton's GUILE_PROGS finds the suffixed binaries unaided.
lepton-attrib with gtk3 requires external GtkSheet 4 (new `x11/gtksheet`
port; fpaquet/gtksheet V4.3.14). gtksheet's git archive ships a *stale*
checked-in configure with no build-aux/ → `use_autoreconf` (its gtk-doc/
introspection m4s are shipped, so no gtk-doc dep). The 2022-era C
compiled clean on Apple clang 15 — no Linux-ism patches needed.

**Key discovery — the quartz/x11 mismatch is layered.** Runtime dlopen
of gtk3 from lepton's Guile FFI exposed that gtk3 +x11's dependency
stack was part-quartz on this machine: (1) libepoxy was +quartz → no
glX symbols → `_epoxy_glXGetClientString` missing (the libepoxy
Portfile itself documents this failure); fixed with
`--enforce-variants libepoxy +x11 -quartz` (the +x11 build is a strict
superset for gtk4 +quartz: CGL stays, glX is added; mesa already
present). (2) glib2 was +quartz → appinfo backend `native` (GOsxAppInfo)
instead of `generic` → libgdk-3's `_g_desktop_app_info_get_filename`
unresolved. An nm sweep of /opt/local/lib showed *nothing* references
the quartz-only `g_osx_app_info_*` symbols, so glib2 +x11 is safe for
the gtk2-quartz (gtkwave) and gtk4-quartz consumers. This extends the
README's cairo/pango rule: on a mixed quartz/x11 machine, the
*singleton* backend choices (libepoxy, glib2 appinfo) must side with
x11, because the quartz consumers don't use the backend-specific
symbols but the x11 ones do.

**Verified end-to-end** after the libepoxy/glib2 +x11 fixes:
`lepton-netlist -g spice-sdb` emits a correct netlist from the shipped
TwoStageAmp example; `lepton-schematic` and `lepton-attrib` both run
under XQuartz; gtkwave (gtk2-quartz) confirmed unbroken by the glib2
switch. One trap found: guile `.go` files auto-compiled while gtk3 was
still un-dlopen-able are *silently stale* and later fail with
`Wrong type to apply: #<syntax-transformer ...>` — the fix is deleting
`~/.cache/guile/ccache`. Distfiles mirrored into `distfiles/`; README
updated (layout, install table, notes section).

## Open Questions

- gtk3 +x11 was almost certainly broken machine-wide before this
  (nothing else here dlopens it) — worth remembering if some old gtk3
  app "never worked".
- Should lepton-eda join the eda-icall metaport? (User's call; it
  overlaps xschem's schematic-capture role.)
- The macOS 15 machine will need the same libepoxy/glib2 variant
  enforcement before lepton-eda installs there.
- GitHub release distfiles archive (`distfiles-2026-07`) does not yet
  contain the lepton-eda/gtksheet tars — refresh on next release cut.
