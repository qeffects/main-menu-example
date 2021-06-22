local helium = require("helium")
local useButton = require("helium.shell.button")
local useState = require("helium.hooks.state")
local flux = require("flux")

local white = {1, 1, 1}
local color = {0.905, 0.866, 0.768}

return helium(function(param, view)
	local colorAnim = useState(color)
	local animProg = useState{
		state = 1
	}
	local btn = useButton(
		param.onClick,
		nil,
		function()
			flux.to(colorAnim, 0.4, white)
			flux.to(animProg, 0.3, {state = 0})
		end,
		function()
			flux.to(colorAnim, 0.4, color)
			flux.to(animProg, 0.3, {state = 1})
		end)
	
	return function()
		love.graphics.setColor(colorAnim[1], colorAnim[2], colorAnim[3], 1)
		love.graphics.setLineWidth('5')
		love.graphics.setLineJoin('none')
		love.graphics.line(view.w-(5*animProg.state), (5*animProg.state), (5*animProg.state), view.h-(5*animProg.state))
		love.graphics.line((5*animProg.state), (5*animProg.state), view.w-(5*animProg.state), view.h-(5*animProg.state))
	end
end)