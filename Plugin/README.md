# Gideros Plugin for Wax
**WARNING** - Work in Progress - [See Tasklist](#task-list) and [project Issues](https://github.com/troysandal/BhWax/issues).

This repo generates a Gideros plugin for wax and installs it in the Gideros user folder.  Once installed you can add wax to any Gideros project.

## Build Plugin
``` sh
./build.sh
./install.sh
```
## Using in Gideros
1. Open a project Gideros Studio (New or Existing)
1. Right click Plugins and add wax (it should be at the top)
1. Export project for Apple, Full Export
1. Open the project in XCode
1. Right click Plugins folder -> Add Files to Project
1. Select the Plugins/wax folder, press OK
1. Reference files in place, Finish
1. Project -> Build Phases -> Compile Sources
1. Select all the Wax files add and add the `-fno-objc-arc` flag to turn ARC off.  Optionally, turn ARC off for the entire project then add `-fobjc-arc` to the non wax project files.


## Task List
- [ ] Recursively create Groups for all files in `Plugins/wax` (needs [this fix](https://github.com/gideros/gideros/commit/61d8c193df3fbd03497d357ea968d7abca3d4c7e#diff-072afe2dfc60286557294ed7b0229e6671a9ded5c11780a43ef34802bb6857b7R103))
- [ ] Auto-Configure ARC


# Bugs
## Bug #2 - iOSProject.addSources doesn't quote files with + signs in them.
[Fix Landed - thx hgy29 ](https://github.com/gideros/gideros/commit/61d8c193df3fbd03497d357ea968d7abca3d4c7e#diff-072afe2dfc60286557294ed7b0229e6671a9ded5c11780a43ef34802bb6857b7R103)

When I call `iOSProject.addSources it doesn't quote files with + signs in them which results in the .xcodeproject file being corrupt.

```
iOSProject.addSources({
      "NSObject+TBIvarAccess.h","NSObject+TBIvarAccess.m"
      },
      "wax_ivar","ios")
```

## (FIXED) Bug #1
The file tree for Lua (`luaplugin`) and the wax Obj-C sources (`source/iOS`) should be copied recursively into the XCode project.  I've gotten the Lua files copying and working but the ObjC sources are not cooperating.  I *think * I understand how to recursively build the Group structure using the Lua API of `Tools/export_ios` but what I can't figure out is how to copy over the source files using the `<template />`.  I tried doing what the Gaming plugin does but it's not working.  

As of this writing, the pluging recursively copies all the sources into the `Plugins` folder, not `Plugins/wax` as I want.  If I change the template's `dest` to be `dest="[[[project.name]]]/Plugins/wax"` then nothing is copied.

