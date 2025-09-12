--[[
  Wax Unit Tests for Gideros Luau
  
  Gideros has it's own, precompiled, Luau engine which comes with some 
  peculialrities that make testing it harder. Normally Wax compiles directly
  with the Lua 5.1 sources and you run the unit tests by setting the
  WAX_TEST env variable to YES in the wax/tools/Tests project.  But not for Luau.  
 
  To run the unit tests we've added them into this Gideros project which you 
  need to run using the WaxPlayer that has the Classes folder added from 
  wax/tools/Tests
]]--

require "wax.init"

require "tests"
