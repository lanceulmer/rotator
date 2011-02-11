Corona Rotator Library
==================================

This library is a conversion of Bartek Drozdz's actionscript class to lua. It can be used as a 
replacement for the DisplayObject.rotation property.

It rotates a DisplayObject, but it does not limit itself to rotate around it's 
registration point, instead it can rotate the object around any point. The point is
defined in the objects parent coodrinate system.

original author Bartek Drozdz (http://www.everydayflash.com)
based on version 1.0 (http://code.google.com/p/barteksplayground/source/browse/trunk/src/com/everydayflash/util/Rotator.as)

Functions
---------

The following functions are included in the library:

*	Rotator(target, registrationPointX, registrationPointY)
	-- Constructor: Adds the library's functionality to the target object
*	target:setRegistrationPoint(registrationPointX, registrationPointY)
	-- Sets the point that the target will rotate around
*   target:setRotation(angle)
	-- Rotates the target to an angle (in degrees)
*	target:getRotation()
	-- Returns current rotation of the target (in degrees)
*	target:rotateBy(angle)
	-- Adds an angle (in degrees) to the target's rotation

Installation
-----------

Drop rotator.lua into your project folder and load it in your main.lua file.
    
    local r = require("rotator")

Usage
-----

Execute this code to add the rotator functionality to a DisplayObject (in this case an image)

    -- load the library
    local r = require("rotator")

    -- make a new DisplayObject
    local image = display.newImage("image.png")
    -- set the object's x and y coordinates
    image.x = 100
    image.y = 100
  
    -- add the rotator functionality to the object
    -- also set the rotation point to the center of the screen
    r.Rotator(image, display.contentWidth * 0.5, display.contentHeight * 0.5)
   
    -- now that the object has the rotator funcionality, call it's new method setRotation
    -- set the angle to 90 degrees
    image:setRotation(90)