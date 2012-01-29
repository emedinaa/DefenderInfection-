package com.projects.limagamejam.games.defenderinfection.view 
{
	import com.projects.core.iview.AbstractContext;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.core.iview.AbstractView;
	import com.projects.limagamejam.games.defenderinfection.model.GameModel;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.CreditsMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.DatosMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GameMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GOLoseMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GOWinMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.HomeMediator;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.IntructionMediator;
	import com.reintroducing.sound.SoundManager;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class ClientContext extends AbstractContext
	{
		private var _stage:Stage;
		private var _currentMed:AbstractMediator;
		private var content:Sprite;
		private var _gameModel:GameModel;
		private var _managerSnd:SoundManager;
		
		public function ClientContext($view:AbstractView,$stage:Stage) 
		{
			super($view)
			_stage = $stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			initView();
		}
		
		private function initView():void 
		{
			content = new Sprite();
			content.mouseEnabled = false;
			
			view.addChild(content);
			initSound()
			
			_gameModel = new GameModel();
			_gameModel.addEventListener(GameModel.GAMEOVER_WIN, GAMEOVER_WIN_handler);
			_gameModel.addEventListener(GameModel.GAMEOVER_LOSE, GAMEOVER_LOSE_handler);
			
			_stage.addEventListener(Event.RESIZE, RESIZE_handler);
			changeView("home", { context:this, model:_gameModel } )
			
		}
		
		private function initSound():void 
		{
			_managerSnd = SoundManager.getInstance()
			_managerSnd.addExternalSound("media/InfectedDefender.mp3","snd1")
			_managerSnd.playSound("snd1",1,0,800,false)
			
		}
		
		private function RESIZE_handler(e:Event):void 
		{
			if (_currentMed)
			{
				_currentMed.view.x = _stage.stageWidth / 2 - 512
				_currentMed.view.y = _stage.stageHeight / 2 - 384
				
			}
		}
		
		private function GAMEOVER_LOSE_handler(e:Event):void 
		{
			trace("LOSE ...")
			
			changeView("lose",{ context:this,model:_gameModel })
		}
		
		private function GAMEOVER_WIN_handler(e:Event):void 
		{
			trace("WIN ...");
			//changeView("win",null)
			changeView("win",{ context:this,model:_gameModel })
		}
		public function changeView($name:String,$data:*):void
		{
			if (_currentMed)
			{ 
				_currentMed.destroy()
				if (content.numChildren>0){content.removeChild(_currentMed.view)}
				//trace("0");
			}
			//trace("1");
			_currentMed = factoryView($name, $data);
			content.addChild(_currentMed.view);
			
			_stage.dispatchEvent(new Event(Event.RESIZE))
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
				case "credits":
					return  new  CreditsMediator(new CreditsView(), $data);
				case "datos":
					return new DatosMediator(new DatosView(), $data);				
				case "lose":
					return new GOLoseMediator(new LoseView(), $data);				
				case "win":
					return new GOWinMediator(new WinView(), $data);
	
			}
			return obj;
		}
		
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function set stage(value:Stage):void 
		{
			_stage = value;
		}
		
		
		
	}

}