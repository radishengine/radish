
-- import the engine's main library
local core = require 'radish.core'
-- import the engine's graphics library
local visual = require 'radish.visual'

-- declare a variable to hold the current scene
local current_scene

-- scene setup: main screen
function main_scene()
	local scene = visual.raster 'main.png'

	scene.cup = visual.raster 'main.cup.png'
	scene.dollar = visual.raster 'main.dollar.png'
	scene.shoe = visual.raster 'main.shoe.png'

	scene.cup.click = function()
		current_scene = sodapool_scene()
	end

	scene.dollar.click = function()
		current_scene = dollar_scene()
	end

	scene.shoe.click = function()
		current_scene = shoecave_scene()
	end

	return scene
end

-- scene setup: soda cup closeup
function sodapool_scene()
	local scene = visual.raster 'sodapool.png'

	scene.button = visual.raster 'sodapool.button.png'

	scene.button.click = function()
		current_scene = main_scene()
	end

	return scene
end

-- scene setup: dollar bill closeup
function dollar_scene()
	local scene = visual.raster 'dollar.png'

	scene.button = visual.raster 'dollar.button.png'

	scene.button.click = function()
		current_scene = main_scene()
	end

	return scene
end

-- scene setup: shoe closeup
function shoecave_scene()
	local scene = visual.raster 'shoecave.png'

	scene.button = visual.raster 'shoecave.button.png'

	scene.button.click = function()
		current_scene = main_scene()
	end

	return scene
end

-- initially, the current scene is the main scene
current_scene = main_scene()

core.window:SetTitle('Radish Engine Demo 1 (2016-07-21)')

function core.draw(renderer)
	renderer:Copy(current_scene.texture, nil, nil)
	for k,v in pairs(current_scene) do
		if type(v) == 'table' and v.texture then
			renderer:Copy(v.texture, nil, nil)
		end
	end
	renderer:Present()
end

local mouse_over = nil

function core.onmousepos(x, y)
	mouse_over = nil
	for k,v in pairs(current_scene) do
		if type(v) == 'table' and v.surface then
			if v:alphatest(x, y) >= 0.5 then
				mouse_over = v
				break
			end
		end
	end
	core.setcursor(mouse_over and core.cursors.hand or core.cursors.arrow)
end

function core.onleftclick(x, y)
	if mouse_over and mouse_over.click then
		mouse_over.click()
		core.draw(core.renderer)
		core.onmousepos(x, y)
	end
end

-- begin main loop
core.main()
