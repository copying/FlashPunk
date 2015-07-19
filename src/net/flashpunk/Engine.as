package net.flashpunk 
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * Main class that allows FlashPunk to run.
	 * Make a child of this class and make it the main class.
	 * @author Copying
	 */
	public class Engine extends MovieClip
	{
		/**
		 * Time elapsed between this and the last tick in seconds.
		 */
		public final function get elapsed():Number { return _elapsed; }
		
		/**
		 * Constructor.
		 * After calling it, it prepares to start the game.
		 * 
		 * @param	screen			First screen added (you can add more using addScreen(screen) function).
		 * @param	initialWorld	The initial world for the game (usually the main menu).
		 * @param	frameRate		The frame rate(in frames per second) of the game. This can't be changed.
		 * @param	fixed			If the game runs in fixed mode.
		 */
		public function Engine(screen:Screen, initialWorld:World, frameRate:Number = 60, fixed:Boolean = false) 
		{
			//sets the arguments
			_tickRate = frameRate;
			_fixed = fixed;
			
			//Waits untill it's added to the stage
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		/**
		 * Sets the Stage properties.
		 * Override this function if you want to set the stage properties differently.
		 * This function shouldn't be called.
		 */
		protected function setStageProperties():void
		{
			stage.frameRate = FP.assignedFrameRate;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.NORMAL;
		}
		
		/**
		 * @private
		 * Called after the Engine is added to the stage.
		 * Responsable of configurating the stage and starting the main loop.
		 * 
		 * @param	e	The Event from the EventHandler call.
		 */
		private function onStage(e:Event):void
		{
			//not called again but to avoid errors we remove it
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			//set the stage properties
			setStageProperties();
			
			
		}
		
		/**
		 * @private
		 * If it runs in fixed mode.
		 */
		private var _fixed:Boolean;
		
		/**
		 * @private
		 * Tick rate (frames per second).
		 */
		private var _tickRate:Number;
		
		/**
		 * @private
		 * Time elapsed between this and the last tick in seconds.
		 */
		private var _elapsed:Number = 0;
		
	}

}