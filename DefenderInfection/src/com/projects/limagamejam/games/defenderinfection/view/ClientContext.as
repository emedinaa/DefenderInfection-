package com.projects.limagamejam.games.defenderinfection.view 
{
	import com.projects.core.iview.AbstractContext;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.core.iview.AbstractView;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GameMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.HomeMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.IntructionMediator;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class ClientContext extends AbstractContext
	{
		private var _stage:Stage;
		private var _currentMed:AbstractMediator;
		private var content:Sprite;
		
		public function ClientContext($view:AbstractView,$stage:Stage) 
		{
			super($view)
			_stage = $stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.displayState = StageDisplayState.NORMAL;
			
			initView();
		}
		
		private function initView():void 
		{
			content = new Sprite();
			content.mouseEnabled = false;
			
			view.addChild(content);
			
			changeView("home", { context:this } );
			
		}
		public function changeView($name:String,$data:*):void
		{
			if (_currentMed)
			{ 
				_currentMed.destroy()
				if (content.numChildren>0){content.removeChild(_currentMed.view)}
				trace("0");
			}
			//trace("1");
			_currentMed = factoryView($name, { context:this } );
			content.addChild(_currentMed.view);
			//trace("2");
		}
		
		private function factoryView($name:String,$data:*):AbstractMediator 
		{
			var obj:AbstractMediator = null;
			switch($name)
			{
				case "home":
					//trace("home");
					return  new HomeMediator(new HomeView(), $data);
				case "instruction":
					return  new IntructionMediator(new InstructionView(), $data);
				case "game":
					return  new GameMediator(new GameView(), $data);
			}
			return obj;
		}
		
		
		
	}

}