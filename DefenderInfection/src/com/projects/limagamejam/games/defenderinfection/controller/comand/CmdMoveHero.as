package com.projects.limagamejam.games.defenderinfection.controller.comand 
{
	import com.projects.core.icommand.ICommand;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GameMediator;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class CmdMoveHero implements ICommand 
	{
		private var _view:GameMediator;
		private var _context:ClientContext;
		private var _hero:HeroUI
		
		public function CmdMoveHero($view:GameMediator,$context:ClientContext) 
		{
			_view = $view;
			_context = $context;
			_hero=_view.hero
		}
		
		/* INTERFACE com.projects.core.icommand.ICommand */
		
		public function execute():void 
		{
			_context.stage.addEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE_handler);
		}
		
		private function MOUSE_MOVE_handler(e:MouseEvent):void 
		{
			var auxMx:int = _context.stage.mouseX-GameConstant.PATH.x;
			if (auxMx > 0) { if (auxMx > 400) { auxMx = 400 }}
			if (auxMx < 0) { if (auxMx < -400) { auxMx = -400 }}
			
			var dx:int = auxMx;
			var percent:Number = auxMx / 400;
			var angle:Number = 180 * percent;
			
			var pos:Point = Point.polar(GameConstant.RADIO_HERO,- angle * Math.PI / 180+Math.PI/2)
			_hero.x=GameConstant.PATH.x+pos.x
			_hero.y = GameConstant.PATH.y + pos.y
			_hero.angle=angle
			_hero.rotation = -angle;
			trace("dx ",angle)
		}
		
		public function unexecute():void 
		{
			_context.stage.removeEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE_handler);
		}
		
		
	}

}