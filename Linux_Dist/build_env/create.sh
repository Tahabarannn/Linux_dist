echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS Root: ${LFS:?}" 

if ! test $(whoami) == "lfs" 
then
    echo "ERROR: This script must be run as user 'lfs'"
    exit -1
fi

echo "Creating build environment..."