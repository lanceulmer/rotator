module(..., package.seeall)

--[[
* This class can be used as a replacement for the DisplayObject.rotation property.
* 
* It rotates a DisplayObject, but it does not limit itself to rotate around the it's 
* registration point, instead it can rotate the object around any point. The point is
* defined in the objects parent coodrinate system.
* 
* @author Bartek Drozdz (http://www.everydayflash.com)
* @version 1.0
--]]
--target = nil --:Object;
                
--[[
* A value that is based on the initial rotation of the display object itself, and
* the angle between the registration point of the display object and of the rotator
--]]
--offset = nil --:Number;
                
--[[
* Registration point - the point around which the rotation takse place
--]]
--pointX = nil --:Point;
--pointY = nil
                
--[[
* Distance between the registration point of the display object and the registration 
* point of the rotator
--]]
--dist = nil --:Number;

--[[
* Registers a DisplayObject that will be rotated and an registration Point around which it will be rotated.
* 
* @param       target DisplayObject to rotate
* @param       registrationPoint Point containing the coodrinates around which the object should be rotated 
*          (in the targets parent coordinate space) If omitted, the displays object x and y coordinates are used
--]]
function Rotator(target, registrationPointX, registrationPointY)
	if not registrationPointX then 
		registrationPointY = nil 
	end
	if not registrationPointY then 
		registrationPointY = nil 
	end
	
	local offset = nil --:Number;
    local pointX = nil --:Point;
	local pointY = nil
    local dist = nil --:Number;
	--self.target = target
                
	--[[
	* Once set in the constructor, the rotation registration point can be modified an any moment
	* 
	* @param       registrationPoint, if null defaults to targets x and y coordinates
	--]]
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
		
		--pointY = target.y
							
		local dx = pointX - target.x
		local dy = pointY - target.y
		dist = math.sqrt( dx * dx + dy * dy )
							
		local a = math.atan2(dy, dx) * 180 / math.pi
		offset = 180 - a + target.rotation;
	end
					
	--[[
	* Sets the rotation to the angle passed as parameter.
	* 
	* Since it uses a getter/setter Rotator can easily be used with Tween or Tweener classes.
	--]]
	function target:setRotation(angle)
		local tpX = target.x 
		local tpY = target.y
	
		local ra = (angle - offset) * math.pi / 180
							
		target.x = pointX + math.cos(ra) * dist
		target.y = pointY + math.sin(ra) * dist
							
		target.rotation =  angle
	end
					
	--[[
	* Returns current rotation of the target in degrees
	--]]
	function target:getRotation()
		return target.rotation
	end
					
	--[[
	* Rotates the target by the angle passed as parameter. 
	* Works the same as Rotator.rotation += angle;
	* 
	* @param angle angle by which to rotate the target DisplayObject
	--]]
	function target:rotateBy(angle)
		local tpX = target.x 
		local tpY = target.y
	
		local ra = (target.rotation + angle - offset) * math.pi / 180
							
		target.x = pointX + math.cos(ra) * dist
		target.y = pointY + math.sin(ra) * dist
							
		target.rotation =  target.rotation + angle
	end
	
	target:setRegistrationPoint(registrationPointX, registrationPointY)
end