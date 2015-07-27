package net.flashpunk 
{
	/**
	 * Points the top and the bottom of the Layer.
	 * @author Copying
	 * 
	 * @private
	 */
	internal final class Layer 
	{
		public var higherLayer:Layer = null;
		public var lowerLayer:Layer = null;
		
		public var topEntity:Entity = null;
		public var bottomEntity:Entity = null;
		
		internal var index:uint;
		
	}

}