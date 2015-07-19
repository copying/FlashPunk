package net.flashpunk 
{
	/**
	 * Renders a world.
	 * @author Copying
	 */
	public class Screen 
	{
		
		public function Screen() 
		{
			
		}
		
		/**
		 * @private
		 * Index in the vector in the Engine.
		 */
		internal var index:uint = 0;
		
		/**
		 * @private
		 * The index of the targeted world.
		 */
		internal var target:uint = 0;
		
		/**
		 * @private
		 * If it's part of the vector in the Engine.
		 */
		internal var added:Boolean = false;
	}

}