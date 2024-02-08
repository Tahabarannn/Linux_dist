set -e

echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS Root: ${LFS:?}"

if ! test $(whoami) == "lfs"; then
    echo "ERROR: This script must be run as user 'lfs'"
    exit -1
fi

echo "Creating build environment..."
cd $DIST_ROOT/build_env

#bash -e build_scripts/binutils-pass1.sh
#bash -e build_scripts/gcc-pass1.sh
#bash -e build_scripts/linux-headers.sh
#bash -e build_scripts/glibc.sh
bash -e build_scripts/libstdcpp-pass-1.sh gcc-13.2.0.tar.xz

echo "DONE!"
