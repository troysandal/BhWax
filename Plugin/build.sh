#!/usr/bin/env zsh

PLUGIN_DIR=./wax
WAX_DIR=`realpath "../../../wax"`

commentOut() {
    # Usage: comment_require <file> <module>
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: comment_require <file> <module>" >&2
        exit 1
    fi
    sed -i '' "\|^require \"$2\"|s|^|--|" "$1"
}

if [ ! -d "$WAX_DIR" ]; then
  # echo "Wax submodule not found.  Run 'git submodule update --init --recursive'"
  echo "aborting - wax source not found."
  exit 1
fi

echo "Creating Gideros Wax Plugin"
if [ -d $PLUGIN_DIR ]; then
  echo "Removing old plugin directory..."
  rm -rf $PLUGIN_DIR
fi
mkdir -p $PLUGIN_DIR

echo "Copying local sources..."
cp ./src/wax.gplugin $PLUGIN_DIR/

echo "Copying wax Lua stdlib files..."
mkdir -p $PLUGIN_DIR/luaplugin/wax
cp -R $WAX_DIR/lib/stdlib/* $PLUGIN_DIR/luaplugin/wax/

echo "Patching wax stdlib..."
commentOut "$PLUGIN_DIR/luaplugin/wax/init.lua" "wax.ext"
commentOut "$PLUGIN_DIR/luaplugin/wax/init.lua" "wax.helpers"

echo "Copying wax source files..."
SOURCE_DIR="$PLUGIN_DIR/source/iOS"
mkdir -p $SOURCE_DIR
cp ./src/BhWax.mm $SOURCE_DIR
cp ./src/ProtocolLoader.h $SOURCE_DIR
cp ./src/UIImage+Save.m $SOURCE_DIR
cp -R $WAX_DIR/lib/* $SOURCE_DIR

# These are not needed in Gideros
rm -rf $SOURCE_DIR/build-scripts
rm -rf $SOURCE_DIR/lua
rm -rf $SOURCE_DIR/stdlib
rm -rf $SOURCE_DIR/project.rake
