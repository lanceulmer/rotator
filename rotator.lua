-- Rotator Library
--
-- Version 1.00
--
-- Copyright 2010 Lance Ulmer.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
----------------------------------------------------------------------------------------------------

-- This library is conversion of Bartek Drozdz's actionscript class to lua. It can be used as a 
-- replacement for the DisplayObject.rotation property.
--
-- It rotates a DisplayObject, but it does not limit itself to rotate around it's 
-- registration point, instead it can rotate the object around any point. The point is
-- defined in the objects parent coodrinate system.
--
-- original author Bartek Drozdz (http://www.everydayflash.com)
-- based on version 1.0 (http://code.google.com/p/barteksplayground/source/browse/trunk/src/com/everydayflash/util/Rotator.as)
----------------------------------------------------------------------------------------------------

-- example use
--[[
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
--]]
----------------------------------------------------------------------------------------------------

module(..., package.seeall)

----------------------------------------------------------------------------------------------------
-- cache math functions
local sqrt  = math.sqrt
local atan2 = math.atan2
local pi    = math.pi
local sin   = math.sin
local cos   = math.cos

----------------------------------------------------------------------------------------------------
-- registers a DisplayObject that will be rotated and a registration point around which it will be 
-- rotated
-- 
-- @target - target DisplayObject to rotate
--
-- @registrationPointX, @registrationPointY - point containing the coordinates around which the 
-- object should be rotated (in the targets parent coordinate space) if omitted, the displays object 
-- x and y coordinates are used
function Rotator(target, registrationPointX, registrationPointY)
	if not registrationPointX then 
		registrationPointY = nil 
	end
	if not registrationPointY then 
		registrationPointY = nil 
	end
	
	-- a value that is based on the initial rotation of the display object itself, and
	-- the angle between the registration point of the display object and of the rotator
	local offset = nil
	
	-- the point around which the rotation take place
    local pointX = nil
	local pointY = nil
	
	-- distance between the registration point of the display object and the registration 
	-- point of the rotator
    local dist = nil
    
    ------------------------------------------------------------------------------------------------
	-- once set in the constructor, the rotation registration point can be modified at any moment
	--
	-- @registrationPointX, @registrationPointY - if null defaults to target's x and y coordinates
	function target:setRegistrationPoint(registrationPointX, registrationPointY)
		if not registrationPointX then 
			registrationPointY = nil 
		end
		if not registrationPointY then 
			registrationPointY = nil 
		end
		
		if registrationPointX == nil and registrationPointY == nil then 
			pointX = target.x 
			pointY = target.y
		else 
			pointX = registrationPointX
			pointY = registrationPointY
		end
							
		local dx = pointX - target.x
		local dy = pointY - target.y
		dist = sqrt( dx * dx + dy * dy )
							
		local a = atan2(dy, dx) * 180 / pi
		offset = 180 - a + target.rotation;
	end
	
	------------------------------------------------------------------------------------------------
	-- sets the rotation to the angle passed as parameter
	--
	-- @angle - angle (in degrees) to rotate the target DisplayObject
	function target:setRotation(angle)
		local tpX = target.x 
		local tpY = target.y
	
		local ra = (angle - offset) * pi / 180
							
		target.x = pointX + cos(ra) * dist
		target.y = pointY + sin(ra) * dist
							
		target.rotation =  angle
	end
	
	------------------------------------------------------------------------------------------------
	-- returns current rotation of the target (in degrees)
	function target:getRotation()
		return target.rotation
	end
	
	------------------------------------------------------------------------------------------------
	-- rotates the target by the angle passed as parameter
	-- works the same as Rotator.rotation += angle
	--
	-- @angle - angle (in degrees) to add to the target DisplayObject's rotation
	function target:rotateBy(angle)
		local tpX = target.x 
		local tpY = target.y
	
		local ra = (target.rotation + angle - offset) * pi / 180
							
		target.x = pointX + cos(ra) * dist
		target.y = pointY + sin(ra) * dist
							
		target.rotation =  target.rotation + angle
	end
	
	------------------------------------------------------------------------------------------------
	-- call setRegistrationPoint at the end of the constructor
	-- use either user defined point or target's x and y coordinates
	target:setRegistrationPoint(registrationPointX, registrationPointY)
end