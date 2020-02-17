--Centers an Icon in it's viewport
return function(param,state,view)
	state.iconW, state.iconH = param.icon:getDimensions()
	state.scaleW = 1
	--Scale down horizontally
	if state.iconW>view.w then
		state.scaleW = view.w/state.iconW
	end

	return function()
		love.graphics.draw(param.icon,math.floor((view.w-state.iconW)/2),math.floor((view.h-state.iconH)/2),nil)
	end
end