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
local target:Object;
                
--[[
* A value that is based on the initial rotation of the display object itself, and
* the angle between the registration point of the display object and of the rotator
--]]
local offset:Number;
                
--[[
* Registration point - the point around which the rotation takse place
--]]
local point:Point;
                
--[[
* Distance between the registration point of the display object and the registration 
* point of the rotator
--]]
local dist:Number;

--[[
* Registers a DisplayObject that will be rotated and an registration Point around which it will be rotated.
* 
* @param       target DisplayObject to rotate
* @param       registrationPoint Point containing the coodrinates around which the object should be rotated 
*          (in the targets parent coordinate space) If omitted, the displays object x and y coordinates are used
--]]
function Rotator(target:Object, registrationPoint:Point=null) 
	this.target = target;
	setRegistrationPoint(registrationPoint);
end
                
--[[
* Once set in the constructor, the rotation registration point can be modified an any moment
* 
* @param       registrationPoint, if null defaults to targets x and y coordinates
--]]
function setRegistrationPoint(registrationPoint:Point=null):void
	if (registrationPoint == null) then 
		point = new Point(target.x, target.y)
	else 
		point = registrationPoint
	end
                        
	var dx:Number = point.x - target.x;
	var dy:Number = point.y - target.y;
	dist = Math.sqrt( dx * dx + dy * dy );
                        
	var a:Number = Math.atan2(dy, dx) * 180 / Math.PI;
	offset = 180 - a + target.rotation;
end
                
--[[
* Sets the rotation to the angle passed as parameter.
* 
* Since it uses a getter/setter Rotator can easily be used with Tween or Tweener classes.
--]]
function set rotation(angle:Number):void
	var tp:Point = new Point(target.x, target.y);

	var ra:Number = (angle - offset) * Math.PI / 180;
                        
	target.x = point.x + Math.cos(ra) * dist;
	target.y = point.y + Math.sin(ra) * dist;
                        
	target.rotation =  angle;
end
                
--[[
* Returns current rotation of the target in degrees
--]]
function get rotation():Number
	return target.rotation;
end
                
--[[
* Rotates the target by the angle passed as parameter. 
* Works the same as Rotator.rotation += angle;
* 
* @param angle angle by which to rotate the target DisplayObject
--]]
function rotateBy(angle:Number):void 
	var tp:Point = new Point(target.x, target.y);

	var ra:Number = (target.rotation + angle - offset) * Math.PI / 180;
                        
	target.x = point.x + Math.cos(ra) * dist;
	target.y = point.y + Math.sin(ra) * dist;
                        
	target.rotation =  target.rotation + angle;
end