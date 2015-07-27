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
			var current:Entity = null;
			
			if (botToTop)
			{
				current = _bottomLayer.bottomEntity;
				
				while (current)
				{
					callback(current.graphic);
					current = current.higherEntity;
				}
			}
			else
			{
				current = _topLayer.topEntity;
				
				while (current)
				{
					callback(current.graphic);
					current = current.lowerEntity;
				}
			}
		}
		
		/**
		 * Adds an entity into a layer (on this world).
		 * 
		 * @param	e		The entity to be added.
		 * @param	layer	The layer to be added.
		 * @param	atTop	If it's added on top (or at the bottom) of the layer.
		 * 
		 * @return			The added entity, if the operation was succesfull.
		 */
		public final function addEntity(e:Entity, layer:uint = 0, atTop:Boolean = true):Entity
		{
			if (e.world) return null;
			
			e.world = this;
			
			if (_layer[layer])
			{
				if (atTop)
				{
					_layers[layer].topEntity.addEntityOnTop(e);
				}
				else
				{
					_layers[layer].bottomEntity.addEntityBelow(e);
				}
			}
			else
			{
				//look for the layers which will be by the side of the new one.
				var last:Layer = null;
				var current:Layer = _topLayer;
				while (current)
				{
					if (current.index > layer) break;
					
					last = current;
					current = current.lowerLayer;
				}
				
				//make the new layer.
				var l:Layer = new Layer;
				_layers[layer] = l;
				l.index = layer;
				l.topEntity = l.bottomEntity = e;
				
				if (last)
				{
					//connect with the lower layer (connect layer and the entity)
					l.higherLayer = last;
					last.lowerLayer = l;
					
					e.higherEntity = last.bottomEntity;
					last.bottomEntity.lowerEntity = e;
				}
				else _topLayer = l;
				
				if (current)
				{
					//connect with the highter layer (connect layer and the entity)
					l.lowerLayer = current;
					current.higherLayer = l;
					
					e.lowerEntity = current.topEntity;
					current.topEntity.higherEntity = e;
				}
				else _bottomLayer = l;
			}
			
			return e;
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