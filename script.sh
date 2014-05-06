#!/bin/bash
APACHE_FLEX=apache-flex-sdk-4.12.1-bin
if [ ! -d "$APACHE_FLEX" ]; then
	echo "download"
	curl "http://mirrors.cnnic.cn/apache/flex/4.12.1/binaries/$APACHE_FLEX.tar.gz" > $APACHE_FLEX.tar.gz
	tar -zxf $APACHE_FLEX.tar.gz
fi

PLAYERGLOBAL_HOME=$APACHE_FLEX/frameworks/libs/player
PLAYER_VERSION_MAJOR=13
PLAYER_VERSION_MINOR=0
if [ ! -d "$PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/" ]; then
	echo "download"
	mkdir $PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/
	curl "http://download.macromedia.com/get/flashplayer/updaters/$PLAYER_VERSION_MAJOR/playerglobal$PLAYER_VERSION_MAJOR_$PLAYER_VERSION_MINOR.swc" > $PLAYERGLOBAL_HOME/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/playerglobal.swc
fi

ant compile_core -Dconfig.player.version=$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR -Dconfig.swf.version=24 -DFLEX_HOME=./$APACHE_FLEX

