local graphics = love.graphics

local font = require 'common.scripts.fontloader'
local hex = require 'common.scripts.hex'
local flux = require 'lib.flux'
local input = require 'lib.helium.core.input'
local newProxy = require 'lib.helium.core.element'.newProxy
local iconFactory = HeliumLoader('/ui/primitive/centerIcon.lua')

local themeColors = {
	base = hex("#FFCA42"),
	accent = hex("#FF9D42"),
	hoverBase = hex("#42FFD2"),
	hoverAccent = hex("#33A388")
}

local mainFont = font('SpaceMono-Regular.ttf',16)
local shadowH = 4
local padding = 25

return function (param,state,view)
	local base, accent, hoverBase, hoverAccent = themeColors.base, themeColors.accent, themeColors.hoverBase, themeColors.hoverAccent

	if param.base and param.accent and param.hoverBase and param.hoverAccent then
		base, accent, hoverBase, hoverAccent = param.base, param.accent, param.hoverBase, param.hoverBase
	end

	local currentBase = newProxy(themeColors.base)
	local currentAccent = newProxy(themeColors.accent)
	local icon
	if param.icon then
		icon = iconFactory({icon = param.icon},view.h-shadowH,view.h-shadowH)
	end
	input('clicked', param.callback)
	input('hover', function()
		local t1 = flux.to(currentBase,0.2,hoverBase)
		local t2 = flux.to(currentAccent,0.2,hoverAccent)
		return function()
			t1:stop()
			t2:stop()
			flux.to(currentBase,0.2,base)
			flux.to(currentAccent,0.2,accent)
		end
	end)
	return function ()
		graphics.setColor(currentBase[1],currentBase[2],currentBase[3])
		love.graphics.rectangle('fill',0,0,view.w,view.h-shadowH)
		graphics.setColor(currentAccent[1],currentAccent[2],currentAccent[3])
		love.graphics.rectangle('fill',0,view.h-shadowH,view.w,shadowH)
		graphics.setFont(mainFont)
		local cmode = 'center'
		if icon then
			cmode = 'right'
			icon:draw(10,0)
		end
		graphics.setColor(hex("#000"))
		graphics.printf(param.text or '', padding,math.floor(0+((view.h-shadowH)/2)-12), view.w -(padding*2),cmode)
	end
end