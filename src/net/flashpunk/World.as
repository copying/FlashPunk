package net.flashpunk 
{
	/**
	 * Container of Entities.
	 * @author Copying
	 */
	public class World 
	{
		
		public function World() { }
		
		
		/**
		 * Calls the callback for every entity's graphic. Used mainly for rendering.
		 * @param	botToTop	If the order from the bottom to top (in depth) [true] or from top to bottom [false].
		 * @param	callback	The callback function. I must have Graphic as the first argument.
		 */
		public final function forEachGraphic(botToTop:Boolean, callback:Function):void
		{
			//for each...
			//callback(grpahic);
		}
		
		/**
		 * Called when the world is added to the engine.
		 */
		protected function added():void { }
		
		/**
		 * Called when the world is removed from the engine.
		 */
		protected function removed():void { }
		
		/**
		 * Called once every tick, before updateing the entities.
		 */
		protected function update():void { }
		
		
		
		/**
		 * Internally called when the world is added to the engine.
		 * Calls the protected function.
		 * 
		 * @private
		 */
		internal function iAdded():void { added(); }
		
		/**
		 * Internally called when the world is removed from the engine.
		 * Calls the protected function.
		 * 
		 * @private
		 */
		internal function iRemoved():void { removed(); }
		
		/**
		 * Complete update function.
		 * First it calls the protected update function and then updates all entities.
		 * 
		 * @private
		 */
		internal function iUpdate():void
		{
			update();
			//TO DO: update entities
		}
		
		
		
		/**
		 * Index in the vector in the Engine.
		 * 
		 * @private
		 */
		internal var index:uint = 0;
		
		/**
		 * If it's part of the vector in the Engine.
		 * 
		 * @private
		 */
		internal var linked:Boolean = false;
		
		
		/**
		 * List with all the layers (shortcut to layers having the index).
		 * 
		 * @private
		 */
		private var _layers:Vector.<Layer> = new Vector.<Layer>;
		
		/**
		 * Top layer of the World.
		 * 
		 * @private
		 */
		private var _topLayer:Layer = null;
		
		/**
		 * Bottom layer of the World.
		 * 
		 * @private
		 */
		private var _bottomLayer:Layer = null;
	}

}