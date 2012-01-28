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
	public class IntructionMediator extends AbstractMediator 
	{
		private var mview:InstructionView;
		private var data:*;
		
		private var context:ClientContext;
		
		public function IntructionMediator($view:Sprite,$data:*) 
		{
			super($view);
			mview = (InstructionView)($view);
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
			mview.btnInstruction.addEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			context.changeView("game", data) ;
		}
		override public function destroy():void 
		{
			super.destroy();
			mview.btnInstruction.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
	}

}