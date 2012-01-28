package com.projects.core.iview 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class AbstractView extends Sprite 
	{
		
		public function AbstractView() 
		{
			super();
			if (stage) { app() } else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, app);
			}
		}
		
		protected function  app(e:Event=null):void
		{
			trace("app");
		}
		public function destroy():void
		{
			}
	}

}