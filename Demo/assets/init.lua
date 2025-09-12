-- We load the Wax system here in init before any other Lua files are loaded.
-- This gives all other Lua files immediate access to Objective-C via Wax.

require "wax"
require "wax.init"

-- Temporary fix for the issue of device orientation when operating under the Gideros player.
-- http://www.giderosmobile.com/forum/discussion/1737/played-with-xcode-4.5-and-ios6#Item_8
-- Fix is from:
-- http://goodliffe.blogspot.co.uk/2009/12/iphone-forcing-uiview-to-reorientate.html
--
local window=UIApplication:sharedApplication():keyWindow()
if window then
	-- If we are running as a standalone app then (window) will be nil.	
	local view=toobjc(window:subviews()):objectAtIndex(0)
	view:removeFromSuperview()
	window:addSubview(view)
end

