local helium = require "lib.helium"

local content = function(param,state,view)
	return function()

	end
end

local wrapperF = HeliumLoader('/common/gamestates/mainmenu/substates/substateWrapper.helium')

-- why short life locals, cant you sub em there directly ? temporary
local main = "#5EBC32"
local accent = "#7EFF42"
local title = "Load"

return function(param,state,view)
	local wrapper = wrapperF({main=main, accent= accent, title = title, content = content, back = param.back},view.w, view.h)--i'm a dumbass

	state.init = wrapper.state.init
	state.exit = wrapper.state.exit

	view.onChange = function()
		wrapper.view.w = view.w
		wrapper.view.h = view.h
	end

	return function()
		wrapper:draw(0,0)
	end
end