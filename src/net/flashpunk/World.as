package net.flashpunk 
{
	/**
	 * Container of Entities.
	 * @author Copying
	 */
	public class World 
	{
		
		public function World() 
		{
			
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
		internal var added:Boolean = false;
	}

}