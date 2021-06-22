local helium = require("helium")
local useSlider = require("helium.shell.slider")
local useState = require("helium.hooks.state")
local flux = require("flux")
local context = require("helium.hooks.context")

local defFont = love.graphics.newFont()

return helium(function(param, view)
	local style = context.get('settingsContext')
	local slider, handle = useSlider({
		min = 0,
		max = 1,
		value = 1,
		divider = 0.00001,
	}, view.w-20, view.h,
	function(val)
		style[param.color] = val
	end,nil,nil,nil,nil,nil, 10)

	return function()
		love.graphics.setColor(0.668, 0.668, 0.668)
		love.graphics.rectangle('fill', 10, 6, view.w-20, view.h-12, 5, 5)
		if handle.down or handle.over then
			love.graphics.setColor(0.768, 0.85, 0.768)
		else
			love.graphics.setColor(0.768, 0.768, 0.768)
		end
		love.graphics.rectangle('fill', 10, 6, (view.w-20)*slider.value/1, view.h-12, 5, 5)
		if handle.down or handle.over then
			love.graphics.setColor(0.95, 0.95, 0.95)
		else
			love.graphics.setColor(0.7, 0.7, 0.7)
		end
		local dim = math.min(view.w, view.h)
		love.graphics.rectangle('fill', handle.x-dim/4, handle.y, dim/2, dim)
		if handle.down then
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.rectangle('fill', (handle.x-dim/4)+3, handle.y+3, (dim/2)-6, dim-6)
		end
	end
end)