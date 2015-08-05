package net.flashpunk 
{
	import flash.geom.Point;
	/**
	 * Represents a entity with some sort of graphic.
	 * @author Copying
	 */
	public class Entity 
	{
		/**
		 * If the entity is being updated by the world which contains it.
		 */
		public var active:Boolean = true;
		
		/**
		 * Position of the entity is the world (coordinates).
		 */
		public var position:Point;
		
		/**
		 * If the graphic of the entity is visible (renders).
		 */
		public final function get visible():Boolean { return _graphic ? _graphic.visible : false };
		public final function set visible(b:Boolean):void
		{
			if (_graphic) _graphic.visible = b;
		}
		
		public function Entity(x:Number = 0, y:Number = 0, graphic:Graphic = null) 
		{
			position = new Point(x, y);
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