# Injected via CMAKE_PROJECT_TOP_LEVEL_INCLUDES (cmake >= 3.24), so it runs at
# project() time, before TriBITS adds any TPL include directory.
#
# The serial trilinos16 port installs a stub mpi.h at ${prefix}/include. The
# Boost/Netcdf/HDF5 TPLs put ${prefix}/include on the include path, which makes
# that stub shadow openmpi-gcc13's real mpi.h in some packages (STK, SEACAS) —
# MPI symbols then go missing. Prepend openmpi's include dir to the GLOBAL
# search (inherited by every target) so the real mpi.h always wins. Plain
# include_directories(BEFORE ...) (NOT SYSTEM, which would sort after -I).
include_directories(BEFORE /opt/local/include/openmpi-gcc13)
