package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CreditsMediator extends AbstractMediator 
	{
		private var mview:CreditsView;
		private var data:*;
		
		private var context:ClientContext;
		public function CreditsMediator($view:Sprite,$data:*) 
		{
			super($view);
			mview = (CreditsView)($view);
			data = $data;
			context = $data.context;
			initView();
		}
		override public function initView():void 
		{
			super.initView();
			events();
		}
		override public function events():void 
		{
			super.events();
			mview.btnInicio.addEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			context.changeView("home", data) ;
		}
		override public function destroy():void 
		{
			super.destroy();
			mview.btnInicio.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
	}

}