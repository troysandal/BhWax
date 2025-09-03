#!/usr/bin/env zsh

PLUGIN_DIR=./wax

if [ ! -d $PLUGIN_DIR ]; then
  echo "Please run build.sh first"
  exit 1
fi

DEST=~/Library/Application\ Support/Gideros/UserPlugins/wax
DEST="$(eval echo $DEST)"

echo "Installing plugin to $DEST"
rm -rf $DEST
mv $PLUGIN_DIR $DEST