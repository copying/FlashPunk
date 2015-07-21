package net.flashpunk 
{
	import flash.geom.Point;
	
	/**
	 * Renders a world.
	 * @author Copying
	 */
	public class Screen 
	{
		/**
		 * Camera of the Screen.
		 * Change its x and y values to move the screen arround.
		 */
		public var camera:Point = new Point;
		
		
		public function Screen() { }
		
		
		
		/**
		 * Called before start rendering.
		 * Used to prepare anything needed (if any) before rendering.
		 */
		protected function beforeRender():void { }
		
		/**
		 * Renders the graphic g.
		 * 
		 * @param	g	Graphic to be rendered.
		 */
		protected function render(g:Graphic):void { }
		
		/**
		 * Called after rendering everything.
		 * Used to finish the rendering (usually show the final result).
		 */
		protected function afterRender():void { }
		
		/**
		 * Internal caller for beforeRendering();
		 * 
		 * @private
		 */
		internal function iBeforeRender():void { beforeRender(); }
		
		/**
		 * Internal caller for rendering(g);
		 * 
		 * @param	g	Graphic to be rendered.
		 * 
		 * @private
		 */
		internal function iRender(g:Graphic):void { render(g); }
		
		/**
		 * Internal caller for afterRendering();
		 * 
		 * @private
		 */
		internal function iAfterRender():void { afterRender(); }
		
		
		
		/**
		 * Index in the vector in the Engine.
		 * 
		 * @private
		 */
		internal var index:uint = 0;
		
		/**
		 * The index of the targeted world.
		 * 
		 * @private
		 */
		internal var target:uint = 0;
		
		/**
		 * If it's part of the vector in the Engine.
		 * 
		 * @private
		 */
		internal var linked:Boolean = false;
	}

}