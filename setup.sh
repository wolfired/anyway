
set APACHE_FLEX=apache-flex-sdk-4.12.1-bin
if [[ ! -d "$APACHE_FLEX" ]]; then
	curl 'http://mirrors.cnnic.cn/apache/flex/4.12.1/binaries/$APACHE_FLEX.tar.gz'
	tar -zxf $APACHE_FLEX.tar.gz
fi

set PLAYER_VERSION_MAJOR=13
set PLAYER_VERSION_MINOR=0
if [[ ! -d "$APACHE_FLEX/frameworks/libs/player/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/" ]]; then
	mkdir -p player/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR
	curl 'http://download.macromedia.com/get/flashplayer/updaters/$PLAYER_VERSION_MAJOR/playerglobal$PLAYER_VERSION_MAJOR_$PLAYER_VERSION_MINOR.swc' >> $APACHE_FLEX/frameworks/libs/player/$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR/playerglobal.swc
fi


