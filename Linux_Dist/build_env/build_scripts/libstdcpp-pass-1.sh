. $DIST_ROOT/build_env/build_scripts/inc-start.sh $1 $(basename $0)

mkdir -v build
cd build

../libstdc++-v3/configure \
    --host=$LFS_TGT \
    --build=$(../config.guess) \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0

make && make DESTDIR=$LFS install

. $DIST_ROOT/build_env/build_scripts/inc-end.sh $1 $(basename $0)
