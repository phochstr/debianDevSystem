#!/bin/bash

version=2.4.3
if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]$ ]]; then
  version=$1
fi

dlUrl=https://mirrors.dotsrc.org/eclipse//rcptt/release/$version/ide/rcptt.ide-$version-linux.gtk.x86_64.zip
if [[ "$1" == http* ]]; then
    # simplify nightly installation via unique URI from https://www.eclipse.org/rcptt/download/
    dlUrl=$1
    # version from URI:
    artifact=`basename $dlUrl`
    noarch=${artifact%%\-linux\.gtk\.x86_64\.zip}
    version=${noarch##rcptt\.ide\-}
fi

echo "Downloading RCPTT IDE $version"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd /tmp
wget $dlUrl
sudo unzip rcptt.ide*.zip -d /opt/rcptt$version.ide
rm rcptt.ide*.zip

$DIR/eclipseRCPTTPlugins.sh $version
