echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS Root: ${LFS:?}"  

mkdir -p $LFS/sources

for f in $(cat $DIST_ROOT/build_env/build_env_list)
do
    bn=$(basename $f)
    
    if ! test -f $LFS/sources/$bn
    then
        wget $f -O $LFS/sources/$bn
    fi
    
done;

mkdir -pv $LFS/{etc,var,tools} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

if ! test $(id -u lfs)
then
    groupadd lfs
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs
    passwd lfs
    chown -v lfs $LFS/{usr,lib,var,etc,tools,sources}

    dbhome=$(eval echo "~lfs")

    cat > $dbhome/.bash_profile << "E0F"
    exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
    EOF

    cat > $dbhome/.bashrc << EOF
    set +h
    umask 022
    LFS=$lfs
    DIST_ROOT=$DIST_ROOT
    EOF

    cat >> $dbhome/.bashrc << "EOF"
    LC_ALL=POSIX
    LFS_TGT=$(uname -m)-lfs-linux-gnu
    PATH=/usr/bin
    if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
    PATH=$LFS/tools/bin:$PATH
    CONFIG_SITE=$LFS/usr/share/config.site
    export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
    export MAKEFLAGS='-j$(nproc)'
    EOF
    
fi