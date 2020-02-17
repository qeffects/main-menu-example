local mainFactory = HeliumLoader('/common/gamestates/mainmenu/substates/menuMain.helium')
local settingsF = HeliumLoader('/common/gamestates/mainmenu/substates/settings.helium')
local loadF = HeliumLoader('/common/gamestates/mainmenu/substates/load.helium')
local playF = HeliumLoader('/common/gamestates/mainmenu/substates/play.helium')


--Abstract menu controller
return function (param,state,view)
	state.currentState = nil

	local setBack = function ()
		if state.substates[state.currentState].state.exit then
			state.substates[state.currentState].state.exit(function()
				state.currentState = nil
			end)
		end
	end

	local setState = function(num)
		state.currentState = num
		
		if state.currentState then
			if state.substates[state.currentState].state.init then
				state.substates[state.currentState].state.init()
			end
		end
	end

	local backToMenu = function ()
		setBack()
	end

	state.substates = {
		playF({back = backToMenu},view.w,view.h),
		loadF({back = backToMenu},view.w,view.h),
		settingsF({back = backToMenu},view.w,view.h)
	}

	local menuParam = {
		play = function ()
			setState(1)
		end,
		load = function ()
			setState(2)
		end,
		settings = function ()
			setState(3)
		end,
		exit = function ()
			
		end
	}

	local menu = mainFactory(menuParam,view.w,view.h)

	view.onChange = function()
		menu.view.w = view.w
		menu.view.h = view.h
		for i= 1, #state.substates do
			state.substates[i].view.w = view.w
			state.substates[i].view.h = view.h
		end
	end

	return function ()
		menu:draw(0,0)
		if state.currentState and state.currentState~='none' then
			state.substates[state.currentState]:draw(0,0)
		end
	end
end