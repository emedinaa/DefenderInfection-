package com.projects.limagamejam.games.defenderinfection.controller.comand 
{
	import com.projects.core.icommand.ICommand;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GameMediator;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class CmdMoveHero2 implements ICommand 
	{
		private var _view:GameMediator;
		private var _context:ClientContext;
		private var _hero:FriendUI;
		
		public function CmdMoveHero2($view:GameMediator,$context:ClientContext) 
		{
			_view = $view;
			_context = $context;
			_hero=_view.hero2
		}
		
		/* INTERFACE com.projects.core.icommand.ICommand */
		
		public function execute():void 
		{
			//_context.stage.addEventListener(KeyboardEvent.KEY_UP, KEY_MOVE_up);
			_context.stage.addEventListener(KeyboardEvent.KEY_DOWN, KEY_MOVE_presionar);
		}
		
		
		private function KEY_MOVE_presionar(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case Keyboard.UP:
					_hero.y -= 3;
					break;
				case Keyboard.DOWN:
					_hero.y += 3;
					break;
				case Keyboard.LEFT:
					_hero.x -= 3;
					break;
				case Keyboard.RIGHT:
					_hero.x += 3;
					break;
			}			
		}
		
		public function unexecute():void 
		{
			_context.stage.removeEventListener(KeyboardEvent.KEY_DOWN,KEY_MOVE_presionar);
		}
		
		
	}

}