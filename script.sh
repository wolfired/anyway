#!/bin/bash
ACCOUNT_ROOT=/home/travis/build/wolfired
PROJECT_NAME=anyway

APACHE_FLEX_SDK_URL="http://mirrors.cnnic.cn/apache/flex/4.12.1/binaries/apache-flex-sdk-4.12.1-bin.tar.gz"
APACHE_FLEX=apache-flex-sdk-4.12.1-bin
APACHE_FLEX_TAR=$APACHE_FLEX.tar.gz
APACHE_FLEX_HOME=$ACCOUNT_ROOT/$APACHE_FLEX

if [ -d "$APACHE_FLEX_HOME" ]
then
	echo "downloaded"
else 
	echo "downloading"
	curl $APACHE_FLEX_SDK_URL > $ACCOUNT_ROOT/$APACHE_FLEX_TAR
	tar -zxf $ACCOUNT_ROOT/$APACHE_FLEX_TAR -C $ACCOUNT_ROOT
fi

PLAYERGLOBAL_HOME=$APACHE_FLEX_HOME/frameworks/libs/player
PLAYER_VERSION_MAJOR=13
PLAYER_VERSION_MINOR=0
SWF_VERSION=24
if [ -d "$PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR" ]
then
	echo "downloaded"
else
	echo "downloading"
	mkdir -p $PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR
	curl "http://download.macromedia.com/get/flashplayer/updaters/$PLAYER_VERSION_MAJOR/playerglobal$PLAYER_VERSION_MAJOR_$PLAYER_VERSION_MINOR.swc" > $PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/playerglobal.swc
fi

ant compile_core -DFLEX_HOME=$APACHE_FLEX_HOME -Dconfig.player.version=$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR -Dconfig.swf.version=$SWF_VERSION

