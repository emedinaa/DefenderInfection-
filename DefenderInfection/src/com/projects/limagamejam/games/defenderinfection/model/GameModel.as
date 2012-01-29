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
		
		public static const PAUSE:String = "pause"
		//public static const GAMEOVER:String = "gameover";
		public static const GAMEOVER_WIN:String = "gameoverwin";
		public static const GAMEOVER_LOSE:String = "gameoverlose";
		public static const INIT:String = "gameover";
		
		public function GameModel(target:IEventDispatcher = null) 
		{
			super(target);
			
		}
		
		
		
	}

}