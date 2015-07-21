package net.flashpunk 
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * Main class that allows FlashPunk to run.
	 * Make a child of this class and make it the main class.
	 * @author Copying
	 */
	public class Engine extends MovieClip
	{
		/**
		 * The number of frames that can be skiped before forcing to render.
		 * If it's 0, it doesn't have limit.
		 */
		public var maxFrameSkip:uint = 5;
		
		/**
		 * The frame rate of the game (in frames per second).
		 */
		public final function get frameRate():Number { return _tickRate; }
		
		/**
		 * Time elapsed between this and the last tick in seconds.
		 */
		public final function get elapsed():Number { return _elapsed; }
		
	//Constructor
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
			//Add global FP.engine variable
			FP.engine = this;
			
			//sets the arguments
			addWorld(initialWorld || new World);
			addScreen(screen, _worlds[0]);
			
			
			_tickRate = frameRate;
			_tickLength = 1000 / frameRate;
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
			stage.frameRate = _tickRate;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.NORMAL;
		}
		
	//overridable events
		/**
		 * Called right before the engine main loop starts running.
		 */
		protected function init():void { }
		
	//world functions
		
		/**
		 * Adds an extra world (don't chage, adds another one).
		 * @param	world	World to be added.
		 */
		public final function addWorld(world:World):void
		{
			if (!world || world.linked)
			{
				throw new Error("World must exist and not already be added.");
				return;
			}
			
			world.linked = true;
			world.index = _worlds.push(world);
			world.iAdded();
		}
		
		/**
		 * Removes a world.
		 * @param	world World to be removed.
		 */
		public final function removeWorld(world:World):void
		{
			if (!world || !world.linked)
			{
				throw new Error("World must exist and be added.");
				return;
			}
			
			//Remove the world from the Vector
			_worlds.slice(world.index, 1);
			
			//Correct the target of the screens
			for each (var screen:Screen in _screens)
			{
				if (screen.target == world.index)
				{
					removeScreen(screen);
				}
				else if (screen.target > world.index)
				{
					screen.target--;
				}
			}
			
			world.iRemoved();
			world.linked = false;
		}
		
		/**
		 * Changes a world with another.
		 * All the screens that were rendering the current world, now renders the new one.
		 * @param	currentWorld	World that will no longer be rendered (added).
		 * @param	newWorld		World that will replace the current one.
		 */
		public final function changeWorld(currentWorld:World, newWorld:World):void
		{
			if (!currentWorld || !newWorld || !currentWorld.linked || newWorld.linked)
			{
				throw new Error("Both worlds must exist. The first have to be added but the second one musn't.");
				return;
			}
			
			newWorld.linked = true;
			newWorld.index = currentWorld.index;
			
			_worlds[currentWorld.index] = newWorld;
			
			currentWorld.iRemoved();
			newWorld.iAdded();
			
			currentWorld.linked = false;
		}
		
		
	//screen functions
		/**
		 * Adds an screen that renders the pointed world.
		 * @param	screen	Screen added.
		 * @param	target	The world that is rendered.
		 */
		public final function addScreen(screen:Screen, target:World):void
		{
			if (!target || !screen || !target.linked || screen.linked)
			{
				throw new Error("Both parameters must exist. The first have to not be added but the second one have to.");
				return;
			}
			
			screen.linked = true;
			screen.index = _screens.push(screen);
			//if the target for the world don't exists, it points to the default one.
			screen.target = (_worlds.length > target.index) ? target.index : 0;
			
			screen.iAdded();
		}
		
		/**
		 * Removes an screen.
		 * @param	screen	The removed screen.
		 */
		public final function removeScreen(screen:Screen):void
		{
			if (!screen || !screen.linked) return;
			
			_screens.splice(screen.index, 1);
			
			screen.iRemoved();
			
			screen.linked = false;
		}
		
	//Private event handelers
		/**
		 * Called after the Engine is added to the stage.
		 * Responsable of configurating the stage and starting the main loop.
		 * 
		 * @param	e	The Event from the EventHandler call (ignored).
		 * 
		 * @private
		 */
		private function onStage(e:Event):void
		{
			//not called again but to avoid errors we remove it
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			//save the time (like this was a first frame)
			_currentTime = getTimer();
			
			//Add global FP.stage variable
			FP.stage = stage;
			
			//set the stage properties
			setStageProperties();
			
			//call the event function
			begin();
			
			//start the main loop
			if (fixed)
			{
				_mainTimer = new Timer(_tickLength);
				_mainTimer.addEventListener(TimerEvent.TIMER, onTimer);
				_elapsed = _tickLength / 1000;
				_mainTimer.start();
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, onFrame);
			}
		}
		
		/**
		 * Called every possible tick in fixed mode.
		 * 
		 * @param	e	The Event from The EventHandler call (ignored).
		 * 
		 * @private
		 */
		private function onTimer(e:TimerEvent):void
		{
			_lastTime = _currentTime;
			_currentTime = getTimer();
			_delta += _currentTime - _lastTime;
			
			_skipCount = 0;
			
			while (_delta >= _tickLength)
			{
				_delta -= _tickLength;
				
				updateWorlds();
				
				_skipCount++;
				if (maxFrameSkip > 0 && _skipCount >= maxFrameSkip) break;
			}
			
			renderScreens();
		}
		
		/**
		 * Called every frame in the non-fixed mode.
		 * 
		 * @param	e	The Event from The EventHandler call (ignored).
		 * 
		 * @private
		 */
		private function onFrame(e:Event):void
		{
			//timming
			_lastTime = _currentTime;
			_currentTime = getTimer();
			_elapsed = _currentTime - _lastTime;
			
			//update worlds
			updateWorlds();
			
			//render
			renderScreens();
		}
		
		
		/**
		 * Updates all the worlds of the Engine.
		 * 
		 * @private
		 */
		private function updateWorlds():void
		{
			for each (var w:World in _worlds)
			{
				w.iUpdate();
			}
		}
		
		/**
		 * Renders all the screens.
		 * 
		 * @private
		 */
		private function renderScreens():void
		{
			
			for each (var s:Screen in _screens)
			{
				s.iBeforeRender();
			}
			
			for each (var s:Screen in _screens)
			{
				//render entities graphics.
				
			}
			
			for each (var s:Screen in _screens)
			{
				s.iAfterRender();
			}
		}
		
		
		
		/**
		 * List with all the worlds.
		 * 
		 * @private
		 */
		private var _worlds:Vector.<World> = new Vector.<World>;
		
		/**
		 * Vector with all the screens.
		 * 
		 * @private
		 */
		private var _screens:Vector.<Screen> = new Vector.<Screen>;
		
	//Variables that define the Engine
		/**
		 * If it runs in fixed mode.
		 * 
		 * @private
		 */
		private var _fixed:Boolean;
		
		/**
		 * Tick rate (in ticks [frames] per second).
		 * 
		 * @private
		 */
		private var _tickRate:Number;
		
		/**
		 * The length of a tick (in milliseconds per tick [frame]).
		 * 
		 * @private
		 */
		private var _tickLength:Number;
		
	//Timming Variables
		/**
		 * Time elapsed between this and the last tick in seconds.
		 * _elapsed = _current - _last;
		 * 
		 * @private
		 */
		private var _elapsed:Number = 0;
		
		/**
		 * The time of the last tick.
		 * 
		 * @private
		 */
		private var _lastTime:Number;
		
		/**
		 * The time of the current tick.
		 * 
		 * @private
		 */
		private var _currentTime:Number;
		
		/**
		 * The Timer class for the fixed mode.
		 * 
		 * @private
		 */
		private var _mainTimer:Timer;
		
		/**
		 * Used to calculate if it's necesary to render.
		 * 
		 * @private
		 */
		private var _delta:Number = 0;
		
		
		/**
		 * How many frames we already skiped.
		 * 
		 * @private
		 */
		private var _skipCount:uint = 0;
	}

}