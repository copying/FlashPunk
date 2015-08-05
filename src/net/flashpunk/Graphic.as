package net.flashpunk 
{
	import flash.geom.Point;
	/**
	 * Represents any Grpahic
	 * @author Copying
	 */
	public class Graphic 
	{
		/**
		 * If the graphic should render.
		 */
		public var visible:Boolean = true;
		
		/**
		 * Offset of the graphic relative to the entity that cointains it.
		 */
		public var offset:Point;
		
		public function Graphic(offsetX:Number = 0, offsetY:Number = 0) 
		{
			offset = new Point(offsetX, offsetY);
		}
		
	}

}