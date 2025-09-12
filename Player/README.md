# Gideros Player with Wax
Creates a Gideros Player with Wax installed.  Handy for projects where you want to quickly prototype in Gideros Studio.

## Build
1. Build and install [Gideros Wax Plugin](../Plugin/README.md#build-plugin)
1. Run player build script
``` sh
./build.sh
```
1. Open `WaxPlayer/WaxPlayer.xcodeproject`
1. Right click `WaxPlayer/Plugins` folder in Project Navigator
1. Select "Add Files to WaxPlayer"
1. Select the Plugins/wax folder, press OK
1. Choose "Reference files in place", "Create Groups", press Finish
1. Select `WaxPlayer` (root of Project Navigator) 
1. Select `WaxPlayer iOS` target
1. Select Build Phases tab
1. Expand Compile Sources
1. Select all the Wax files add and add the `-fno-objc-arc` flag to turn ARC off.  Do not add this flag to EAGLView.m, main.m, AppDelegate.m or ViewController.m. 

## Run in Desktop Simulator
1. Choose `WaxPlayer iOS` target in dropdown at top of screen
1. Product -> Destinations -> Show All Run Destinations
1. Choose any iPad or iPhone Destination with (Rosetta)
1. Compile and Run

