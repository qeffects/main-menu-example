local helium = require("helium")
local useInput = require("helium.shell.input")
local context = require("helium.hooks.context")

local defFont = love.graphics.newFont(18)

return helium(function(param, view)
	local style = context.get('settingsContext')
	local textinput = useInput(function(fintxt)
		style.title = fintxt
	end,nil, style.title)

	return function()
		local fintext = textinput.text
		love.graphics.setColor(0.929, 0.921, 0.874)
		love.graphics.rectangle('fill', 3, 3, view.w-6, view.h-6, 3, 3)
		if textinput.focused then
			love.graphics.setColor(0.462, 0.756, 0.490)
			love.graphics.setLineWidth(4)
			love.graphics.rectangle('line', 2, 2, view.w-4, view.h-4, 2, 2)
			fintext = fintext..'|'
		else
			love.graphics.setColor(0.768, 0.768, 0.768)
			love.graphics.setLineWidth(2)
			love.graphics.rectangle('line', 2, 2, view.w-4, view.h-4, 3, 3)
		end
		love.graphics.setColor(0.1,0.1,0.1)
		love.graphics.setFont(defFont)
		love.graphics.print(fintext, 8, 9)
	end
end)