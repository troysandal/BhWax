# Gideros Player with Wax
Creates a Gideros Player with Wax installed.  Handy for projects where you want to quickly prototype in Gideros Studio.

## Build
1. Build and install [Gideros Wax Plugin](../Plugin/README.md#build-plugin)
1. Run player build script
``` sh
./build.sh
```
1. Open `XCode/WaxPlayer.xcodeproject`
1. Right click WaxPlayer/Plugins folder
1. Select "Add Files to Project"
1. Select the Plugins/wax folder, press OK
1. Choose "Reference files in place", press Finish
1. Select `WaxPlayer` (root of Project Navigator) 
1. Select WaxPlayer target
1. Select Build Phases tab
1. Expand Compile Sources
1. Select all the Wax files add and add the `-fno-objc-arc` flag to turn ARC off.  Optionally, turn ARC off for the entire project (in Build Settings) then add `-fobjc-arc` to the 4 non wax project files.

