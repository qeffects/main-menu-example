local helium = require("helium")

local buttonFac = require("main-menu.menu-button")

local buttonfont = love.graphics.newFont('main-menu/Roboto-Bold.ttf', 50, 'none')
local headerfont = love.graphics.newFont('main-menu/Roboto-Bold.ttf', 100)

local headerico = love.graphics.newImage('/main-menu/img/Main.png')
local playico = love.graphics.newImage('/main-menu/img/Play.png')
local loadico = love.graphics.newImage('/main-menu/img/Load.png')
local settingico = love.graphics.newImage('/main-menu/img/Settings.png')
local exitico = love.graphics.newImage('/main-menu/img/Exit.png')
local grid = require('helium.layout.grid')
local container = require('helium.layout.container')

local bwidth = 350
local bheight = 80

local playProps = {
	ico = playico,
	color = {0.415, 0.815, 0.6},
	text = 'Play',
}

local loadProps = {
	ico = loadico,
	color = {0.737, 0.517, 0.752},
	text = 'Load',
}

local settingProps = {
	ico = settingico,
	color = {0.815, 0.682, 0.333},
	text = 'Settings',
}

local exitProps = {
	ico = exitico,
	color = {0.933, 0.419, 0.419},
	text = 'Exit',
}

local dummyRectFactory = helium(function(p, view) 
	return function()
		love.graphics.setColor(0.1,0.1,0.1)
		love.graphics.rectangle('fill', 0, 0, view.w, view.h)
		love.graphics.setColor(0.3,0.3,0.3)
		love.graphics.rectangle('line', 0, 0, view.w, view.h)
		love.graphics.setColor(1,1,1)
		love.graphics.printf(p.text, 0, view.h/2-29, view.w, 'center')
	end
end)

return helium(function(param, view)
	settingProps.onClick = param.switch
	local playB = buttonFac(playProps, bwidth, bheight)
	local loadB = buttonFac(loadProps, bwidth, bheight)
	local settingB = buttonFac(settingProps, bwidth, bheight)
	local exitB = buttonFac(exitProps, bwidth, bheight)

	local header = dummyRectFactory({text = 'Header'}, 10, 10, {header = true})
	local sidebar = dummyRectFactory({text = 'Sidebar'}, 10, 10, {sidebar = true})
	local sidebar2 = dummyRectFactory({text = 'Sidebar2'}, 10, 10, {sidebar2 = true})
	local content = dummyRectFactory({text = 'Content'}, 10, 10, {content = true})

	local leftOff = view.w - bwidth
	local topOff = view.h - ((bheight+20)*4)

	return function()
		love.graphics.setColor(0.921, 0.921, 0.949, 1)
		love.graphics.rectangle('fill', 0, 0, view.w, view.h)
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(headerico, 55, 55)
		love.graphics.setColor(0, 0, 0)
		love.graphics.setFont(headerfont)
		love.graphics.print('Main Menu', 155, 35)

		love.graphics.setFont(buttonfont)
		playB:draw(leftOff, topOff)
		loadB:draw(leftOff, topOff+bheight)
		settingB:draw(leftOff, topOff+(bheight*2))
		exitB:draw(leftOff, topOff+(bheight*3))
	end
end)