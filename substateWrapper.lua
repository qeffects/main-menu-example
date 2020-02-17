local font = require 'common.scripts.fontloader'
local hex = require 'common.scripts.hex'
local flux = require 'lib.flux'
local helium = require 'lib.helium'
local input = require 'lib.helium.core.input'
local titleFont = font('RobotoCondensed-Bold.ttf',81)
local graphics = love.graphics --LG or graphics :mmmyeah:
local backIcon = graphics.newImage('/assets/icons/keyboard-backspace.png')
local backButtonFactory = HeliumLoader("/ui/generic/actionButton.helium")

return function(param, state, view)
	state.offset = view.w*2
	local backButton = backButtonFactory({callback = param.back,text="",icon = backIcon},60,45)
	if param.content then
		state.content = helium(param.content)({},view.w, view.h)
	end
	state.init = function()
		state.offset = view.w*2
		local ease = (view.w/800)*0.2
		flux.to(state, ease, {offset = 0})
	end

	state.exit = function(finished)
		state.offset = 0
		local ease = (view.w/800)*0.2
		flux.to(state, ease, {offset = view.w*2}):oncomplete(function()
			if finished then
				finished()
			end
		end)
	end

	return function()
		--Backdrop
		graphics.setColor(hex(param.main))
		graphics.push()
		graphics.translate(state.offset,0)
		graphics.polygon('fill',0,0,-view.w,view.h,0,view.h)
		graphics.setScissor(0,0, view.w, view.h)
		graphics.rectangle('fill', 0, 0, view.w+200, view.h)
		--Title
		graphics.setColor(hex(param.accent))
		graphics.polygon('fill', 0, 0, 300,0, 0, 300,-(view.w/2),view.h,-view.w,view.h,-(view.w/2),view.h/2)
		graphics.push()
		graphics.translate(-260,140)
		graphics.rotate(-0.8)
		graphics.setColor(hex("#000"))
		graphics.setFont(titleFont)
		graphics.print(param.title,150,200)

		--Content goes here
		graphics.pop()
		if state.content then
			state.content:draw(300,0)
		end

		
		backButton:draw(10,view.h-55)
		graphics.pop()
		graphics.setScissor()
	end
end