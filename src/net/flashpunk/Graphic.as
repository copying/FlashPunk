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
		 * If the graphic should be updated.
		 */
		public var active:Boolean = false; //unless the child needs it it doen't need to update.
		
		/**
		 * Offset of the graphic relative to the entity that cointains it.
		 */
		public var offset:Point;
		
		public function Graphic(offsetX:Number = 0, offsetY:Number = 0) 
		{
			offset = new Point(offsetX, offsetY);
		}
		
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