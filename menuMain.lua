local font = require 'common.scripts.fontloader'
local graphics = love.graphics

local mainFont = font('Roboto-Bold.ttf',78)
local icon = graphics.newImage('/assets/icons/castle.png')
local iconExit = graphics.newImage('/assets/icons/exit.png')
local iconLoad = graphics.newImage('/assets/icons/load.png')
local iconPlay = graphics.newImage('/assets/icons/play.png')
local iconSettings = graphics.newImage('/assets/icons/settings.png')

local mainFactory =   HeliumLoader('/common/gamestates/mainmenu/substates/menuButton.helium')
local buttons = {
	play = { main = '#42FFD2', accent = '#33A388', text = '#000', content = "Play game", icon = iconPlay },
	load = { main = '#7EFF42', accent = '#5EBC32', text = '#000', content = "Load game", icon = iconLoad },
	settings = { main = '#FF8642', accent = '#CD662C', text = '#000', content = "Settings", icon = iconSettings },
	exit = { main = '#FF4242', accent = '#B02525', text = '#000', content = "Exit", icon = iconExit },
}

return function(param,state,view)
	buttons.play.callback = param.play
	buttons.load.callback = param.load
	buttons.settings.callback = param.settings
	buttons.exit.callback = param.exit


	local play = mainFactory(buttons.play,450,80)
	local load = mainFactory(buttons.load,410,80)
	local settings = mainFactory(buttons.settings,370,80)
	local exit = mainFactory(buttons.exit,330,80)



	return function ()
		graphics.draw(icon, 10, 10)
		graphics.setFont(mainFont)
		graphics.print('Draft Fortress',110,20)

		local padding = math.floor((view.h - 250)/2)
		--410px tall
		play:draw(view.w-450,padding)
		load:draw(view.w-410,padding+110)
		settings:draw(view.w-370,padding+220)
		exit:draw(view.w-330,padding+330)
	end
end