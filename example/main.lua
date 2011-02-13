-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- load a white background image
local background = display.newImage("background.png", true)
background.x = display.contentWidth * 0.5
background.y = display.contentHeight * 0.5

-- load the library
local r = require("rotator")

-- make a new DisplayObject
local image = display.newImage("image.png")
image:setReferencePoint(display.CenterReferencePoint)
-- set the object's x and y coordinates
image.x = display.contentWidth * 0.5
image.y = display.contentHeight * 0.5
  
-- add the rotator functionality to the object
-- also set the rotation point to the center of the screen
r.Rotator(image, display.contentWidth * 0.5, display.contentHeight * 0.5)

-- make a crosshair
local cross = display.newImage("cross.png")
cross:setReferencePoint(display.CenterReferencePoint)
-- set the crosshair's x and y coordinates
cross.x = display.contentWidth * 0.5
cross.y = display.contentHeight * 0.5

-- every frame set the point that the object rotates around to the crosshair's x and y coordinates
-- add 7 to the object's angle
function step( event )
	image:setRegistrationPoint(cross.x, cross.y)
	image:rotateBy(7)
end

Runtime:addEventListener("enterFrame", step)

-- set the crosshair's x and y choordinates to the most recent touch location
function touch( event )
	cross.x = event.x
	cross.y = event.y
end

Runtime:addEventListener("touch", touch)