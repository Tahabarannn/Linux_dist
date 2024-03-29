echo
echo "Glibc"
echo
sleep 1

cd $LFS/sources
tar -xf glibc-2.38.tar.xz
cd glibc-2.38

case $(uname -m) in
i?86)
    ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
x86_64)
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../glibc-2.38-fhs-1.patch

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" >configparms

../configure \
    --prefix=/usr \
    --host=$LFS_TGT \
    --build=$(../scripts/config.guess) \
    --enable-kernel=4.14 \
    --with-headers=$LFS/usr/include \
    libc_cv_slibdir=/usr/lib

make

make DESTDIR=$LFS install

echo
echo "Testing Glibc"
echo
echo 'int main(){}' | $LFS_TGT-gcc -xc -

readelf -l a.out | grep ld-linux

cd $LFS/sources
rm -rf glibc-2.38
