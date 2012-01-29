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
	public class HomeMediator extends AbstractMediator 
	{
		public var mview:HomeView;
		private var _data:*;
				
		private var context:ClientContext;

		
		public function HomeMediator($view:Sprite, $data:*) 
		{
			super($view);
			mview = (HomeView)($view);
			_data = $data;
			context = $data.context;
			
			initView();
			trace("home mediator MODEL",_data.model);
		}
		override public function initView():void 
		{
			super.initView();
			trace("homemediator context ",_data.context);
			events();
		}
		override public function events():void 
		{
			super.events();
			mview.btnNew.addEventListener(MouseEvent.CLICK, CLICK_handler);
			mview.btnInst.addEventListener(MouseEvent.CLICK, CLICK_instruc);
			mview.btnCred.addEventListener(MouseEvent.CLICK, CLICK_creditos);
		}
		
		private function CLICK_instruc(e:MouseEvent):void 
		{
			context.changeView("instruction", _data);
		}
		private function CLICK_creditos(e:MouseEvent):void 
		{
			context.changeView("credits", _data);
		}
		
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			trace("click ");
			context.changeView("datos", _data);
		}
	}

}