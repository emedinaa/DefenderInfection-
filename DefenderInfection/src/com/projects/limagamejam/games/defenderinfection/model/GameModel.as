package com.projects.limagamejam.games.defenderinfection.model 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class GameModel extends EventDispatcher 
	{
		
		public const PAUSE:String = "pause"
		public const GAMEOVER:String = "gameover";
		public const INIT:String = "gameover";
		
		public function GameModel(target:IEventDispatcher = null) 
		{
			super(target);
			
		}
		
		
		
	}

}