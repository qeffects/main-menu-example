love.window.setMode(1200, 800)
local helium = require("helium")
local flux = require("flux")
local menuScene = helium.scene.new(true)
local modalScene = helium.scene.new(true)
local modalActive = false
local moonshine = require("moonshine")

local gausBlurs = {
	moonshine(moonshine.effects.fastgaussianblur),
	moonshine(moonshine.effects.fastgaussianblur),
	moonshine(moonshine.effects.fastgaussianblur),
	moonshine(moonshine.effects.fastgaussianblur),
	moonshine(moonshine.effects.fastgaussianblur),
}
gausBlurs[1].fastgaussianblur.taps = 11
gausBlurs[2].fastgaussianblur.taps = 15
gausBlurs[3].fastgaussianblur.taps = 21
gausBlurs[4].fastgaussianblur.taps = 37
gausBlurs[5].fastgaussianblur.taps = 51

local gausWeen = 0
local accumulator = 0

local function switchToModal()
	modalActive = true
	gausWeen = 1
	menuScene:deactivate()
	modalScene:activate()
end

local function switchToMenu()
	modalActive = false
	gausWeen = 0
	modalScene:deactivate()
	menuScene:activate()
end

menuScene:draw()

local modal = require("main-menu.modal")({switch = switchToMenu}, 400, 400)
local menu = require("main-menu.menu")({switch = switchToModal}, 1200, 800)
modalScene:activate()
modal:draw(400, 200)
menuScene:activate()
menu:draw(0, 0)

local fsc = love.graphics.newCanvas(1200/4, 800/4)

function love.draw()
	if modalActive then
		gausBlurs[gausWeen](function()
			menuScene:draw()
		end)
		modalScene:draw()
	else
		menuScene:draw()
	end
end

function love.update(dt)
	flux.update(dt)
	menuScene:update(dt)

	if modalActive then
		modalScene:update(dt)		
	end

	if gausWeen>0 then
		accumulator = accumulator + dt
	end
	if gausWeen>0 and gausWeen<5 and accumulator>0.042 then
		accumulator = 0
		gausWeen = gausWeen + 1
	end
end
