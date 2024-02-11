name: glibc
version: 2.38
repo: core
source: https://ftp.gnu.org/gnu/glibc/glibc-2.38.tar.xz
deps: []
mkdeps: []
extras:
  [
    "https://www.linuxfromscratch.org/patches/lfs/12.0/glibc-2.38-fhs-1.patch",
    "https://www.iana.org/time-zones/repository/releases/tzdata2023c.tar.gz",
  ]
