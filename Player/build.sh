echo "Exporting Gideros Wax Player to XCode..."

if [ -d "WaxPlayer" ]; then
  echo "Removing old build..."
  rm -rf "WaxPlayer"
fi

DEST=`realpath .`
gdrexport -platform ios Gideros/WaxPlayer.gproj "$DEST"

if [ ! -d "$DEST/WaxPlayer/WaxPlayer.xcodeproj" ]; then
  echo "Error: Player export failed."
  exit 1
fi

# nuke assets to enable Player mode
rm WaxPlayer/WaxPlayer/assets/luafiles.txt
rm WaxPlayer/WaxPlayer/assets/properties.bin

echo "Launching XCode..."
open $DEST/WaxPlayer/WaxPlayer.xcodeproj
