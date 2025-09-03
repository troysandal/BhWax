-- BUG - iOSProject.addSources doesn't quote files with + signs in them.
--[[
--- BAD
		000000531111000000000000 /* NSObject+TBIvarAccess.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = NSObject+TBIvarAccess.h; sourceTree = "<group>"; };
		000000541111000000000000 /* NSObject+TBIvarAccess.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; path = NSObject+TBIvarAccess.m; sourceTree = "<group>"; };
		000000551111000000000000 /* NSObject+TBIvarAccess.m */ = {isa = PBXBuildFile; fileRef = 000000541111000000000000 /* NSObject+TBIvarAccess.m */; };


--- GOOOD

		0542E2912E6768A500AED658 /* NSObject+TBIvarAccess.m in Sources */ = {isa = PBXBuildFile; fileRef = 0542E2902E6768A500AED658 /* NSObject+TBIvarAccess.m */; };
		0542E28F2E6768A500AED658 /* NSObject+TBIvarAccess.h */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "NSObject+TBIvarAccess.h"; sourceTree = "<group>"; };
		0542E2902E6768A500AED658 /* NSObject+TBIvarAccess.m */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.objc; path = "NSObject+TBIvarAccess.m"; sourceTree = "<group>"; };

		000000061111000000000000 /* ivar */ = {
			isa = PBXGroup;
			children = (
				0542E28F2E6768A500AED658 /* NSObject+TBIvarAccess.h */,
				0542E2902E6768A500AED658 /* NSObject+TBIvarAccess.m */,
			);
			path = ivar;
			sourceTree = "<group>";
		};

		5FD896E315CED77F00D34824 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				5FD896FC15CED77F00D34824 /* main.m in Sources */,
				5F4153FA15CEF227007B5365 /* AppDelegate.m in Sources */,
				5F4153FB15CEF227007B5365 /* EAGLView.m in Sources */,
				0542E2912E6768A500AED658 /* NSObject+TBIvarAccess.m in Sources */,


]]
    -- Copy Obj-C source files
    local pname="wax" -- plugin name
    local srcDir="[[[sys.pluginDir]]]/source/iOS/" -- source directory
    local tgtDir=Export.getProperty("project.name").."/Plugins/"..pname
    Export.mkdir(tgtDir)
    Export.recursiveCopy(pname,srcDir,tgtDir,"*.m;*.mm;*.c;*.h;*.cpp")

    -- Create Groups
    local iOSProject=require("Tools/export_ios")

    iOSProject.addGroup("wax","Plugins/wax","wax_ios","GroupPlugins_ios")
      iOSProject.addGroup("adaptation","adaptation","wax_adaptation_ios","wax_ios")
      iOSProject.addGroup("extensions","extensions","wax_extensions_ios","wax_ios")
        iOSProject.addGroup("block","block","wax_block_ios","wax_extensions_ios")
        iOSProject.addGroup("CGAffine","CGAffine","wax_CGAffine_ios","wax_extensions_ios")
        iOSProject.addGroup("filesystem","filesystem","wax_filesystem_ios","wax_extensions_ios")
        iOSProject.addGroup("ivar","ivar","wax_ivar_ios","wax_extensions_ios")
        iOSProject.addGroup("memory","memory","wax_memory_ios","wax_extensions_ios")
        iOSProject.addGroup("xml","xml","wax_xml_ios","wax_extensions_ios")
        iOSProject.addGroup("capi","capi","wax_capi_ios","wax_extensions_ios")
        iOSProject.addGroup("CGContext","CGContext","wax_CGContext_ios","wax_extensions_ios")
        iOSProject.addGroup("HTTP","HTTP","wax_HTTP_ios","wax_extensions_ios")
        iOSProject.addGroup("json","json","wax_json_ios","wax_extensions_ios")
        iOSProject.addGroup("SQLite","SQLite","wax_SQLite_ios","wax_extensions_ios")

    -- Add Sources to Groups
    iOSProject.addSources({
      "BhWax.mm", "ProtocolLoader.h",
      "wax_class.h","wax_class.m",
      "wax_define.h",
      "wax_gc.h","wax_gc.m",
      "wax_helpers.h","wax_helpers.m",
      "wax_instance.h","wax_instance.m",
      "wax_luau.h",
      "wax_server.h","wax_server.m",
      "wax_stdlib.h",
      "wax_struct.h","wax_struct.m",
      "wax.h","wax.m"
      },"wax","ios")
      
    iOSProject.addSources({
      "wax_config.m","wax_config.h",
      "wax_lock.m","wax_lock.h"
      },"wax_adaptation","ios")

      iOSProject.addSources({
          "wax_block_call_pool.h","wax_block_call_pool.m","wax_block_call.h","wax_block_call.m","wax_block_description.h","wax_block_description.m","wax_block_transfer_pool.h","wax_block_transfer_pool.m","wax_block_transfer.h","wax_block_transfer.m","wax_block.h","wax_block.m"
          },
          "wax_block","ios")
-- TODO: Add tolua++  && bind   
          iOSProject.addSources({
          "wax_capi.h","wax_capi.m"
          },
          "wax_capi","ios")
    iOSProject.addSources({
          "wax_CGTransform.h","wax_CGTransform.m"
          },
          "wax_CGAffine","ios")
    iOSProject.addSources({
          "wax_CGContext.h","wax_CGContext.m"
          },
          "wax_CGContext","ios")
    iOSProject.addSources({
          "wax_filesystem.h","wax_filesystem.m"
          },
          "wax_filesystem","ios")
    iOSProject.addSources({
          "wax_http_connection.h","wax_http_connection.m","wax_http.h","wax_http.m"
          },
          "wax_HTTP","ios")
    -- BUG - addSources doesn't quote the path="" for files with a +
    --iOSProject.addSources({
    --      "NSObject+TBIvarAccess.h","NSObject+TBIvarAccess.m"
    --      },
    --      "wax_ivar","ios")


-- TODO: add sub folders
    iOSProject.addSources({
          "wax_json.c","wax_json.h"
          },
          "wax_json","ios")
    iOSProject.addSources({
          "wax_memory.h","wax_memory.m"
          },
          "wax_memory","ios")

    iOSProject.addSources({
          "wax_sqlite_operation.h","wax_sqlite_operation.m","wax_sqlite.h","wax_sqlite.m"
          },
          "wax_SQLite","ios")
    iOSProject.addSources({
          "wax_xml.h","wax_xml.m"
          },
          "wax_xml","ios")
                
    iOSProject.commit()