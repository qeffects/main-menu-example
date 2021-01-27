local helium = require("helium")
local btnFac = require("main-menu.modal-button")
local useState = require("helium.control.state")
local flux = require "flux"
local modfont = love.graphics.newFont(20)

return helium(function(param, view)
	local squishState = useState{
		state = 0,
		rep = false,
	}
	local closeB = btnFac({onClick = function()
		if param.switch then
			squishState.rep = true
			flux.to(squishState, 0.5, {state = 0}):ease('cubicinout'):oncomplete(param.switch)
		end
	end}, 30, 30)

	flux.to(squishState, 0.5, {state = 0.5}):ease('cubicinout')
	return function()
		if squishState.state == 0 and squishState.rep then
			squishState.rep = false
			flux.to(squishState, 0.5, {state = 0.5}):ease('cubicinout')
		end
		love.graphics.translate(0,(-0.5+squishState.state)*((view.h/2)))
		love.graphics.scale(1,squishState.state*2)
		love.graphics.setColor(0.905, 0.866, 0.768, 1)
		love.graphics.rectangle('fill',0,0,view.w,view.h)
		love.graphics.setColor(0.815, 0.682, 0.333, 1)
		love.graphics.rectangle('fill',0,0,view.w,40)
		love.graphics.setColor(0.905, 0.866, 0.768, 1)
		love.graphics.setFont(modfont)
		love.graphics.print("This is a separate scene", 60, 8)
		closeB:draw(5, 5)
	end
end)