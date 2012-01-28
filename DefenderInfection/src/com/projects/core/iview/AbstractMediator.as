package com.projects.core.iview 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class AbstractMediator 
	{
		private var _view:Sprite;
		
		public function AbstractMediator($view:Sprite) 
		{
			_view = $view;
		}
		public function initView():void{}
		public function events():void{}
		public function destroy():void{}
		
		public function get view():Sprite { return _view; }
		
		
	}

}