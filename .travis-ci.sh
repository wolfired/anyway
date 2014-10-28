#!/bin/bash
export ACCOUNT_ROOT=/home/travis/build/wolfired
export PROJECT_NAME=anyway

export APACHE_FLEX_SDK_URL="http://mirrors.cnnic.cn/apache/flex/4.12.1/binaries/apache-flex-sdk-4.12.1-bin.tar.gz"
export APACHE_FLEX=apache-flex-sdk-4.12.1-bin
export APACHE_FLEX_TAR=$APACHE_FLEX.tar.gz
export APACHE_FLEX_HOME=$ACCOUNT_ROOT/$APACHE_FLEX

if [ -d "$APACHE_FLEX_HOME" ]
then
	echo "downloaded"
else 
	echo "downloading"
	curl $APACHE_FLEX_SDK_URL > $ACCOUNT_ROOT/$APACHE_FLEX_TAR
	tar -zxf $ACCOUNT_ROOT/$APACHE_FLEX_TAR -C $ACCOUNT_ROOT
fi

export args4ant="-DFLEX_HOME=$APACHE_FLEX_HOME -Dconfig.parallel=false"
ant build -DFLEX_HOME=$APACHE_FLEX_HOME
