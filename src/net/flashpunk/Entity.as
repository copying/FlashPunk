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
		 * Adds the entity in the same world right on top of this one (same layer).
		 * 
		 * @return	If it was possible to add it.
		 */
		public final function addEntityOnTop(e:Entity):Boolean
		{
			//protection
			if (!layer || e.layer) return false;
			
			//layer
			if (layer.topEntity === this) layer.topEntity = e;
			
			//entity
			e.layer = layer;
			
			if (higherEntity)
			{
				higherEntity.lowerEntity = e;
				e.higherEntity = higherEntity;
			}
			
			higherEntity = e;
			e.lowerEntity = this;
			
			return true;
		}
		
		/**
		 * Adds the entity in the same world right below this one (same layer).
		 * 
		 * @return	If it was possible to add it.
		 */
		public final function addEntityBelow(e:Entity):Boolean
		{
			//protection
			if (!layer || e.layer) return false;
			
			//layer
			if (layer.bottomEntity === this) layer.bottomEntity = e;
			
			//entity
			e.layer = layer;
			
			if (lowerEntity)
			{
				lowerEntity.higherEntity = e;
				e.lowerEntity = lowerEntity;
			}
			
			lowerEntity = e;
			e.higherEntity = this;
			
			return true;
		}
		
		private var _graphic:Graphic;
		public final function get graphic():Graphic { _graphic }
		protected final function set graphic(g:Graphic):void { _graphic = g; }
		
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
		
		/**
		 * World wich contains this Entity.
		 * 
		 * @private
		 */
		internal var world:World = null;
		
		/**
		 * Layer that this entity pertains.
		 * 
		 * @private
		 */
		internal var layer:Layer = null;
	}

}