local helium = require("helium")
local btnFac = require("main-menu.modal-button")
local context = require("helium.hooks.context")
local sliderFac = require("main-menu.modal-slider")
local inputFac = require("main-menu.modal-textInput")
local useState = require("helium.hooks.state")
local flux = require "flux"
local modfont = love.graphics.newFont(20)

return helium(function(param, view)
	local theme = context.use('settingsContext', {
		red = 1,
		green = 1,
		blue = 1,
		title = 'Modal Title'
	})
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

	local sliderRed = sliderFac({color = 'red'}, 200, 20)
	local sliderGreen = sliderFac({color = 'green'}, 200, 20)
	local sliderBlue = sliderFac({color = 'blue'}, 200, 20)
	local textInput = inputFac({}, 260, 40)

	flux.to(squishState, 0.5, {state = 0.5}):ease('cubicinout')
	return function()
		if squishState.state == 0 and squishState.rep then
			squishState.rep = false
			flux.to(squishState, 0.5, {state = 0.5}):ease('cubicinout')
		end
		love.graphics.translate(0,(-0.5+squishState.state)*((view.h/2)))
		love.graphics.scale(1,squishState.state*2)
		love.graphics.setColor(theme.red*0.905, theme.green*0.866, theme.blue*0.768, 1)
		love.graphics.rectangle('fill',0,0,view.w,view.h)
		love.graphics.setColor(theme.red*0.815,theme.green*0.682, theme.blue*0.333, 1)
		love.graphics.rectangle('fill',0,0,view.w,40)
		love.graphics.setColor(0.905, 0.866, 0.768, 1)
		love.graphics.setFont(modfont)
		love.graphics.printf(theme.title, 15, 8, view.w-45, 'center')
		closeB:draw(5, 5)
		sliderRed:draw(0, 50)
		sliderGreen:draw(0, 80)
		sliderBlue:draw(0, 110)
		textInput:draw(10, 140)
	end
end)