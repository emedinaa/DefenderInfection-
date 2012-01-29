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
	public class DatosMediator extends AbstractMediator 
	{
		private var mview:DatosView;
		private var data:*;		
		private var context:ClientContext;
		public function DatosMediator($view:Sprite,$data:*) 
		{
			super($view);
			mview = (DatosView)($view);
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
			mview.btnGo.addEventListener(MouseEvent.CLICK, CLICK_handler);
			mview.btnBack.addEventListener(MouseEvent.CLICK, CLICK_back);
		}
		
		private function CLICK_back(e:MouseEvent):void 
		{
			context.changeView("home", data) ;
			destroy();
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			context.changeView("game", data) ;
		}
		override public function destroy():void 
		{
			super.destroy();
			mview.btnGo.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
	}

}