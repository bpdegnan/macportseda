# -*- coding: utf-8; mode: tcl; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- vim:fenc=utf-8:ft=tcl:et:sw=4:ts=4:sts=4
#
# PortGroup: eda-hdf5 1.0
#
# Workaround for the CMake package config shipped by MacPorts hdf5 2.1.1_1.
# Use it in any cmake port of this tree that does find_package(HDF5) (directly
# or through VTK) and therefore loads ${prefix}/lib/cmake/hdf5/hdf5-config.cmake.
# Ports that bypass that config (charon and trilinos-charon set
# HDF5_ALLOW_PREFIND=FALSE) don't need it.
#
# The installed config is broken twice:
#   1. find_dependency(libaec) cannot find libaec. MacPorts installs it under
#      ${prefix}/lib/libaec/{lib,include}, off every default search path, and
#      the config passes no hint:
#        Could NOT find libaec (missing: libaec_LIBRARY libaec_INCLUDE_DIR)
#      Fix: -Dlibaec_ROOT (a documented input of hdf5's Findlibaec.cmake)
#      finds the libraries. The headers also need libaec_INCLUDE_DIR /
#      libsz_INCLUDE_DIR set explicitly: Findlibaec's find_path has no
#      `include` suffix, so it relies on CMP0074 to search ${libaec_ROOT}/include,
#      and ports whose cmake_minimum_required caps policy below 3.12 (CSXCAD:
#      3.1...3.10) have CMP0074 OLD and fail with
#        Could NOT find libaec (missing: libaec_INCLUDE_DIR)
#   2. It includes its own files from ${PACKAGE_PREFIX_DIR}/${PACKAGE_PREFIX_DIR}/
#      lib/cmake/hdf5/..., i.e. /opt/local//opt/local/... The hdf5 port's
#      2026-10-14 "Fix #74514" set HDF5_INSTALL_CMAKE_DIR to an absolute path,
#      and the config template prefixes it a second time.
#      Fix: pre-configure writes a corrected copy of the config into
#      ${workpath}/hdf5-cmake (PACKAGE_PREFIX_DIR pinned to ${prefix}, prefix
#      un-doubled) and HDF5_DIR points CMake at it. The copy still includes the
#      real targets files from ${prefix}/lib/cmake/hdf5, and the installed hdf5
#      is never touched.
#
# Both fixes are harmless once hdf5 is fixed: the copy is then just an
# equivalent, correct config. When it is fixed, delete this file and the
# `PortGroup eda-hdf5 1.0` lines.

pre-configure {
    set eda_hdf5_src ${prefix}/lib/cmake/hdf5
    if {[file isdirectory ${eda_hdf5_src}]} {
        set eda_hdf5_dst ${workpath}/hdf5-cmake
        delete ${eda_hdf5_dst}
        copy ${eda_hdf5_src} ${eda_hdf5_dst}
        foreach f [glob -nocomplain ${eda_hdf5_dst}/*.cmake] {
            set fd [open ${f} r]; set c [read ${fd}]; close ${fd}
            set n [string map [list \
                {get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)} \
                "set(PACKAGE_PREFIX_DIR \"${prefix}\")" \
                {${PACKAGE_PREFIX_DIR}/${PACKAGE_PREFIX_DIR}/} \
                {${PACKAGE_PREFIX_DIR}/}] ${c}]
            if {${n} ne ${c}} {
                set fd [open ${f} w]; puts -nonewline ${fd} ${n}; close ${fd}
            }
        }
        configure.args-append -DHDF5_DIR=${eda_hdf5_dst}
    }
    configure.args-append \
        -Dlibaec_ROOT=${prefix}/lib/libaec \
        -Dlibaec_INCLUDE_DIR=${prefix}/lib/libaec/include \
        -Dlibsz_INCLUDE_DIR=${prefix}/lib/libaec/include
}
