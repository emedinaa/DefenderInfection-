package com.projects.limagamejam.games.defenderinfection.controller.comand 

{
	import com.projects.core.icommand.ICommand;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.GameMediator;
	import com.projects.limagamejam.games.defenderinfection.view.ui.Ball;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	public class CmdShootHero2 
	{
		
		private var _view:GameMediator;
		private var _context:ClientContext;
		private var _hero:FriendUI
		private var creation:Boolean = false;
		private var _t:Timer;
		private var arrBall:Vector.<VaccineUI>
		
		public function CmdShootHero2($view:GameMediator,$context:ClientContext) 
		{
			_view = $view;
			_context = $context;
			_hero=_view.hero2
		}
		
		/* INTERFACE com.projects.core.icommand.ICommand */
		
		public function execute():void 
		{
			arrBall = new Vector.<VaccineUI>();
			_context.stage.addEventListener(MouseEvent.CLICK, CLICK_handler);
			_t = new Timer(100, 0);
			_t.addEventListener(TimerEvent.TIMER,TIMER_handler)
			_t.start();
		}
		
		private function TIMER_handler(e:TimerEvent):void 
		{
			for (var i:int = 0; i < arrBall.length; i++) 
			{
				arrBall[i].x -= 10;
			}
			for (var j:int = 0; j < arrBall.length; j++) 
			{
						
				if (arrBall[j].hitTestObject(_view.enemyMap2))
				{
					_view.mview.removeChild(arrBall[j]);
					arrBall.splice(j, 1)
					
					while(arrBall.length>0) 
					{
						_view.mview.removeChild(arrBall[0]);
						arrBall.splice(0, 1)
					}
					//    list.splice(i,1);
					//_view.swapMap();
					_view.hideTransition()
					return
				}
				
			}
			
			e.updateAfterEvent()
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
		
				createBall();
		}
		
		private function createBall():void 
		{
			if(creation==true){
				var ball:VaccineUI = new VaccineUI();
				ball.x = _hero.x;
				ball.y = _hero.y;
			//ball.rotation = 90 - _hero.angle
			//ball.radio= 100
				arrBall.push(VaccineUI(_view.mview.addChild(ball)))
				
			}
			creation = true;
			
		}
		public function unexecute():void 
		{
			_context.stage.removeEventListener(MouseEvent.CLICK, CLICK_handler);
			creation = false;
		}
		
	}

}