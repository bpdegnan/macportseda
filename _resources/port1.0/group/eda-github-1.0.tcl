# -*- coding: utf-8; mode: tcl; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- vim:fenc=utf-8:ft=tcl:et:sw=4:ts=4:sts=4
#
# PortGroup: eda-github 1.0
#
# macportseda tree: when a standard phase (fetch/checksum/extract/patch/
# configure/build/destroot/test) fails, print a banner directing the user to
# this tree's GitHub issue tracker instead of MacPorts trac -- these ports are
# NOT in the official MacPorts tree and the MacPorts folks should not have to
# deal with reports about them.
#
# Notes:
#  - The final "Follow https://guide.macports.org/#project.tickets ..." line
#    is printed unconditionally by the `port` client binary on any failure;
#    it cannot be suppressed from a Portfile or PortGroup. This banner appears
#    directly above it.
#  - Phases a Portfile overrides with its own body (e.g. `destroot {...}`)
#    bypass the wrapped default procs, so failures inside such custom blocks
#    do not get the banner. The overwhelmingly common failure points
#    (fetch/checksum/configure/build of cmake+autotools ports) are covered.

namespace eval eda_github {
    variable issues_url "https://github.com/bpdegnan/macportseda/issues"
}

proc eda_github::fail_banner {} {
    variable issues_url
    ui_error "======================================================================"
    ui_error " ${::subport} comes from the macportseda tree, NOT official MacPorts."
    ui_error " Please DO NOT file a MacPorts (trac) ticket for this failure."
    ui_error " Report it instead (attach the main.log named below) at:"
    ui_error "     ${issues_url}"
    ui_error "======================================================================"
}

# Wrap each standard phase's default proc: run it, and on error print the
# banner before re-throwing. Guarded so double-sourcing (portindex reuses
# interpreters) does not wrap twice.
foreach _eda_gh_phase {
    portfetch::fetch_main
    portchecksum::checksum_main
    portextract::extract_main
    portpatch::patch_main
    portconfigure::configure_main
    portbuild::build_main
    portdestroot::destroot_main
    porttest::test_main
} {
    if {[info procs ::${_eda_gh_phase}] eq "" ||
        [info procs ::${_eda_gh_phase}.eda_orig] ne ""} {
        continue
    }
    rename ::${_eda_gh_phase} ::${_eda_gh_phase}.eda_orig
    proc ::${_eda_gh_phase} {args} [string map [list @ORIG@ ::${_eda_gh_phase}.eda_orig] {
        if {[catch {@ORIG@ {*}$args} result]} {
            eda_github::fail_banner
            return -code error $result
        }
        return $result
    }]
}
unset -nocomplain _eda_gh_phase
