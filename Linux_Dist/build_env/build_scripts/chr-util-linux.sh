. $DIST_ROOT/build_env/build_scripts/inc-start.sh $1 $(basename $0)

mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
    --libdir=/usr/lib \
    --runstatedir=/run \
    --docdir=/usr/share/doc/util-linux-2.39.1 \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount \
    --disable-static \
    --without-python

make && make install

. $DIST_ROOT/build_env/build_scripts/inc-end.sh $1 $(basename $0)
