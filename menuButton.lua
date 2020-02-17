local font = require 'common.scripts.fontloader'
local hex = require 'common.scripts.hex'
local flux = require 'lib.flux'
local input = require 'lib.helium.core.input'
local iconFactory = HeliumLoader('/ui/primitive/centerIcon.lua')

local mainFont = font('RobotoCondensed-Bold.ttf',50)
local expansion = 50
local shadowSize = 12

local graphics = love.graphics -- Optimize namespaces with JIT

--Param{ width, content, callback, icon, color, shadowColor }
return function (param, state, view)
	state.offset = 200
	state.wipe = 1

	flux.to(state, 0.2, { wipe = 0, offset = 0 })

	local icon = iconFactory({icon=param.icon},60,view.h-shadowSize)

	input('clicked', function()
		param.callback()
	end)

	input('hover', function ()
		local tween = flux.to(state, 0.2, { wipe = 1, offset = expansion })
		return function ()
			tween:stop()
			flux.to(state, 0.2, { wipe = 0, offset = 0 })
		end
	end)

	return function ()

		graphics.setColor(hex(param.main))
		graphics.rectangle('fill',0,0,view.w,view.h)

		graphics.setColor(hex(param.accent))
		graphics.rectangle('fill',0,view.h-shadowSize-(state.wipe*view.h),view.w,shadowSize+(state.wipe*view.h))

		graphics.setColor(hex('#000'))
		graphics.setFont(mainFont)
		graphics.printf(param.content,0+60+state.offset,5,view.w)
		icon:draw(0,0)
	end
end