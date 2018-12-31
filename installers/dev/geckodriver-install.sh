#!/bin/bash
# download and install latest geckodriver for linux or mac.
# required for selenium to drive a firefox browser.
### https://gist.githubusercontent.com/cgoldberg/4097efbfeb40adf698a7d05e75e0ff51/raw/9332fe152f108293834f95d43949f9ff677eecd8/geckodriver-install.sh

install_dir="/usr/local/bin"
json=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest)
if [[ $(uname) == "Darwin" ]]; then
    url=$(echo "$json" | jq -r '.assets[].browser_download_url | select(contains("macos"))')
elif [[ $(uname) == "Linux" ]]; then
    url=$(echo "$json" | jq -r '.assets[].browser_download_url | select(contains("linux64"))')
else
    echo "can't determine OS"
    exit 1
fi
curl -s -L "$url" | tar -xz
chmod +x geckodriver
sudo mv geckodriver "$install_dir"
echo "installed geckodriver binary in $install_dir"