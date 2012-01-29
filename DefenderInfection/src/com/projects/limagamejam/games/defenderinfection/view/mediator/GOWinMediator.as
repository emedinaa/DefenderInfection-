package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class GOWinMediator extends AbstractMediator 
	{
		private var mview:WinView;
		private var data:*;
		
		private var context:ClientContext;
		public function GOWinMediator($view:Sprite,$data:*) 
		{
			super($view);
			mview = (WinView)($view);
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
			//mview.btnGo.addEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			context.changeView("home", data) ;
		}
		override public function destroy():void 
		{
			super.destroy();
			//mview.btnInicio.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
	}

}