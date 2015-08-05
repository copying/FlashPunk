package net.flashpunk 
{
	import flash.display.BitmapData;
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
		 * If the graphic should be updated.
		 */
		public var active:Boolean = false; //unless the child needs it it doen't need to update.
		
		/**
		 * Offset of the graphic relative to the entity that cointains it.
		 */
		public var offset:Point;
		
		/**
		 * Contructor.
		 * @param	offsetX	X coordinate of the offset.
		 * @param	offsetY	Y coordinate of the offset.
		 */
		public function Graphic(offsetX:Number = 0, offsetY:Number = 0) 
		{
			offset = new Point(offsetX, offsetY);
		}
		
		/**
		 * Source to be rendered.
		 * Override this getter, returning the correct source.
		 */
		public function get source():BitmapData { return null; }
		
		/**
		 * Updates the graphic (usually used for animations or particle systems).
		 */
		protected function update():void { }
		
		/**
		 * Internal caller for update.
		 * 
		 * @private
		 */
		internal function iUpdate():void { update(); }
	}

}