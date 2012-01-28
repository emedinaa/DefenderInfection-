package com.projects.limagamejam.games.defenderinfection.view.ui 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class Ball extends Sprite 
	{
		private var _id:String;
		private var _active:Boolean
		private var _radio:int
		
		
		public function Ball() 
		{
			super();
			graphics.beginFill(0xff00ff);
			graphics.drawRect( -5, -5, 15, 10)
			graphics.endFill()
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get radio():int 
		{
			return _radio;
		}
		
		public function set radio(value:int):void 
		{
			_radio = value;
		}
		
		
	}

}