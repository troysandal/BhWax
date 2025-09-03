//
// BhWax.mm
// Wax Lua-ObjectiveC bridge plugin for Gideros Studio (IOS Only)
//
// MIT License
// Copyright (C) 2012. Andy Bower, Bowerhaus LLP
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <sys/socket.h>
#import <UIKit/UIKit.h>
#import "objc/runtime.h"
#include "gideros.h"

extern "C"{
    #include "wax.h"
    #include "wax_helpers.h"
    // EXTENSIONS - Add optional wax extension headers here, initialize
    // in g_initializePlugin()
    #include "wax_http.h"
}

@interface WaxFunction : NSObject {}
@end

@interface WaxFunction (Blocks)
- (void (^)())asVoidNiladicBlock;
- (void (^)( NSObject *))asVoidMonadicBlock;
- (void (^)( NSObject *, NSObject *))asVoidDyadicBlock;
- (void (^)( NSObject *, NSObject *))asVoidDyadicBlockName:(NSString *)name;
- (void (^)( BOOL, NSObject *))asVoidDyadicBlockBO;
- (void (^)(BOOL p1, NSObject * p2))asVoidDyadicBlockBOName:(NSString *)name;
- (void (^)( NSObject *, NSObject *, NSObject*))asVoidTriadicBlock;
- (void (^)(NSObject *p1, int p2, NSObject *p3))asVoidTriadicBlockOIO;
- (void (^)(NSObject *p1, int p2, NSObject *p3))asVoidTriadicBlockIOO;
- (void (^)( NSInteger))asVoidMonadicIntBlock;
@end

@implementation WaxFunction (Blocks)

-(void)dealloc {
    NSLog(@"WaxFunction FREED");
    [super dealloc];
}

-(void (^)())asVoidNiladicBlock {
    return [^() {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        lua_call(L, 0, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSObject *p))asVoidMonadicBlock {
    return [^(NSObject *param) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        wax_fromInstance(L, param);
        lua_call(L, 1, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSObject *p1, NSObject * p2))asVoidDyadicBlock {
    return [^(NSObject *param1, NSObject *param2) {
        void (^block)();
        block = ^() {
            [wax_globalLock() lock];
            lua_State *L = wax_currentLuaState();
            wax_fromInstance(L, self);
            wax_fromInstance(L, param1);
            wax_fromInstance(L, param2);
            lua_call(L, 2, 0);
            [wax_globalLock() unlock];
        };
        if (![NSThread isMainThread]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:block];
        } else {
            block();
        }
    } copy];
}

-(void (^)(NSObject *p1, NSObject * p2))asVoidDyadicBlockName:(NSString *)name {
    return [^(NSObject *param1, NSObject *param2) {
        void (^block)();
        block = ^() {
            [wax_globalLock() lock];
            lua_State *L = wax_currentLuaState();
            wax_fromInstance(L, self);
            wax_fromInstance(L, param1);
            wax_fromInstance(L, param2);
            lua_call(L, 2, 0);
            [wax_globalLock() unlock];
        };
        if (![NSThread isMainThread]) {
            NSLog(@"Queing Block%@", name);
            [[NSOperationQueue mainQueue] addOperationWithBlock:block];
        } else {
            NSLog(@"Calling Block %@", name);
            block();
        }
    } copy];
}

-(void (^)(BOOL p1, NSObject * p2))asVoidDyadicBlockBO {
    return [^(BOOL param1, NSObject *param2) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        lua_pushboolean(L, param1);
        wax_fromInstance(L, param2);
        lua_call(L, 2, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(BOOL p1, NSObject * p2))asVoidDyadicBlockBOName:(NSString *)name {
    return [^(BOOL param1, NSObject *param2) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        lua_pushboolean(L, param1);
        wax_fromInstance(L, param2);
        NSLog(@"Calling VDBO %@", name);
        lua_call(L, 2, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSObject *p1, NSObject * p2, NSObject *p3))asVoidTriadicBlock {
    return [^(NSObject *param1, NSObject *param2, NSObject *param3) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        wax_fromInstance(L, param1);
        wax_fromInstance(L, param2);
        wax_fromInstance(L, param3);
        lua_call(L, 3, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSObject *p1, int p2, NSObject *p3))asVoidTriadicBlockOIO {
    return [^(NSObject *param1, int param2, NSObject *param3) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        wax_fromInstance(L, param1);
        lua_pushinteger(L, param2);
        wax_fromInstance(L, param3);
        lua_call(L, 3, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSObject *p1, int p2, NSObject *p3))asVoidTriadicBlockIOO {
    return [^(int param1, NSObject *param2, NSObject *param3) {
        [wax_globalLock() lock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        lua_pushinteger(L, param1);
        wax_fromInstance(L, param2);
        wax_fromInstance(L, param3);
        lua_call(L, 3, 0);
        [wax_globalLock() unlock];
    } copy];
}

-(void (^)(NSInteger p))asVoidMonadicIntBlock {
    return [^(NSInteger param) {
        [wax_globalLock() unlock];
        lua_State *L = wax_currentLuaState();
        wax_fromInstance(L, self);
        lua_pushnumber(L, param);
        lua_call(L, 1, 0);
        [wax_globalLock() unlock];
    } copy];
}

@end

// REFLECTION ***
// Lets add some simple reflection capability to the standard Cocoa runtime. This will
// allow applications to wind through the class hierarchy and discover available methods etc.
// Used by BhWaxAutoComplete Demo app.

@interface NSObject (BhRuntime)
+(NSArray *)bhSubclassNames;
+(NSArray *)bhMethodSelectors;
+ (NSArray *)bhPropertyNames;

-(Class)bhClass;
-(NSString *)bhClassName;
@end

@implementation NSObject (BhRuntime)
+(NSArray *)bhSubclassNames {
    NSMutableArray *subclasses = [NSMutableArray array];
    unsigned count = objc_getClassList(NULL, 0);
    if (count>0) {
        Class *classes = (Class*)malloc(count * sizeof(classes)); // TODO: sizeof(Class) ????
        objc_getClassList(classes, count);

        for(unsigned i=0; i<count; i++)
        {
            Class eachClass = classes[i];
            [subclasses addObject:  ([NSString stringWithUTF8String: class_getName(eachClass)])];
        }
        free(classes);
    }
    return subclasses;
}

-(Class)bhClass {
    Class c=object_getClass(self);
    return c;
}
-(NSString *)bhClassName {
    return [NSString stringWithUTF8String: class_getName([self class])];
}

+(NSArray *)bhMethodSelectors {
    unsigned count;
    Method *methods = class_copyMethodList(self, &count);
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++) {
        SEL sel=method_getName(methods[i]);
        NSString * selectorName= NSStringFromSelector(sel);
        [array addObject:selectorName];
    }
    free(methods);
    return array;
}

+(NSArray *)bhPropertyNames {
    unsigned count;
    objc_property_t *props = class_copyPropertyList(self, &count);
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)  {
         NSString *propName = [NSString stringWithUTF8String:(property_getName(props[i]))] ;
        [array addObject: propName];
    }
    free(props);
    return array;
}
@end

// END REFLECTION ***

static int getRootViewController(lua_State* L)
{
	UIViewController* controller = g_getRootViewController();
    wax_fromInstance(L, controller);

	return 1;
}

static int getPathForFile(lua_State *L) {
    NSString* filename = [NSString stringWithUTF8String: luaL_checkstring(L, 1)];
    lua_pushstring(L, g_pathForFile([filename UTF8String]) );
    return 1;
}

static int logSetLevel(lua_State *L) {
   int level= luaL_checkinteger(L, 1);
    glog_setLevel(level);
    return 1;
}

static int loader(lua_State *L)
{
    //This is a list of functions that can be called from Lua
    const luaL_Reg functionlist[] = {
        {NULL, NULL},
    };
    luaL_register(L, "wax", functionlist);

    lua_pushcfunction(L, getRootViewController, "getRootViewController");
   	lua_setglobal(L, "getRootViewController");
    
    lua_pushcfunction(L, getPathForFile, "getPathForFile");
   	lua_setglobal(L, "getPathForFile");
    
    lua_pushcfunction(L, logSetLevel, "logSetLevel");
   	lua_setglobal(L, "logSetLevel");

    //return the pointer to the plugin
    return 1;
}

static void g_initializePlugin(lua_State* L)
{
    wax_setCurrentLuaState(L);
    wax_setup();
    // EXTENSIONS - Initialize optional wax extensions
    luaopen_wax_http(L);
    
    lua_getglobal(L, "package");
    lua_getfield(L, -1, "preload");

    lua_pushcfunction(L, loader, "loader");
    lua_setfield(L, -2, "wax");

    lua_pop(L, 2);
}

static void g_deinitializePlugin(lua_State * L) {
    // If we've added any subviews to the root view then we should remove them
    // since this will clear down the player's screen for a subsequent run.
    // We need to leave the original EAGLView though.

    UIView *rootView= [g_getRootViewController() view];
    for (UIView *subview in [rootView subviews]) {
        NSString *className= NSStringFromClass([subview class]);
        if (![className isEqualToString:@"EAGLView"]) {
            [subview removeFromSuperview];
        }
    }

    // Stop Wax
    wax_end();
}

REGISTER_PLUGIN("wax", "1.0")

