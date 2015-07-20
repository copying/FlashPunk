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
		 * @private
		 * Internally called when the world is added to the engine.
		 * Calls the protected function.
		 */
		internal function iAdded():void { added(); }
		
		/**
		 * @private
		 * Internally called when the world is removed from the engine.
		 * Calls the protected function.
		 */
		internal function iRemoved():void { removed(); }
		
		/**
		 * @private
		 * Complete update function.
		 * First it calls the protected update function and then updates all entities.
		 */
		internal function iUpdate():void
		{
			update();
			//TO DO: update entities
		}
		
		/**
		 * @private
		 * Index in the vector in the Engine.
		 */
		internal var index:uint = 0;
		
		/**
		 * @private
		 * If it's part of the vector in the Engine.
		 */
		internal var linked:Boolean = false;
	}

}