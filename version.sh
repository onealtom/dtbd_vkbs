#!/bin/bash
rm -f ./dt_ver.dtsi

# dtc builder info
DTC_VER=`./dtc -v`

# git commit info
git rev-list HEAD | sort > config.git-hash
LOCALVER=`wc -l config.git-hash | awk '{print $1}'`
if [ $LOCALVER \> 1 ] ; then
    VER=`git rev-list origin/master | sort | join config.git-hash - | wc -l | awk '{print $1}'`
    if [ $VER != $LOCALVER ] ; then
        VER="$VER+$(($LOCALVER-$VER))"
    fi
    if git status | grep -q "modified:" ; then
        VER="${VER}M"
    fi
    VER="$VER $(git rev-list HEAD -n 1 | cut -c 1-7)"
    GIT_VERSION=r$VER
else
    GIT_VERSION=
    VER="x"
fi

# dtc build time info
BASH_TIME=`date '+%Y-%m-%d %H:%M:%S'`

rm -f config.git-hash
 
#cat version.h.template | sed "s/\$FULL_VERSION/$GIT_VERSION/g" > ./version.h
#cat dtc_ver.dtsi.template | sed "s/\$HASH_VERSION/$GIT_VERSION/g;s/\$SH_TIME/$BASH_TIME/g" > dtc_ver.dtsi
cat dt_ver.dtsi.template | sed "s/\$HASH_VERSION/$GIT_VERSION/g;s/\$SH_TIME/$BASH_TIME/g;s/\$BUILDER/$DTC_VER/g" > dt_ver.dtsi

echo "Generated dtc_ver.dtsi"