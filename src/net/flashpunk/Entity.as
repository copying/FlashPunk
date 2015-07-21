package net.flashpunk 
{
	/**
	 * Represents a entity with some sort of graphic.
	 * @author Copying
	 */
	public class Entity 
	{
		
		public function Entity() 
		{
			
		}
		
		/**
		 * Entitiy right on top of this one.
		 * 
		 * @private
		 */
		internal var higherEntity:Entity = null;
		
		/**
		 * Entity right below this one.
		 * 
		 * @private
		 */
		internal var lowerEntity:Entity = null;
	}

}