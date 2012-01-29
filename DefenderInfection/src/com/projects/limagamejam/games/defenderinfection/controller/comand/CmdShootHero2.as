package com.projects.limagamejam.games.defenderinfection.controller.comand 

{
	import com.greensock.TweenLite;
	import com.projects.core.icommand.ICommand;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.CharacterConstant;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import com.projects.limagamejam.games.defenderinfection.utils.MathUtils;
	import com.projects.limagamejam.games.defenderinfection.utils.Utils;
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
		private var vy:Number=10;
		private var vx:Number=10;
		
		public function CmdShootHero2($view:GameMediator,$context:ClientContext) 
		{
			_view = $view;
			_context = $context;
			_hero=_view.hero2
		}
		
		/* INTERFACE com.projects.core.icommand.ICommand */
		
		public function execute():void 
		{
			vy=20;
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
				arrBall[i].x -= vx;
				arrBall[i].y -= arrBall[i].vy;
				arrBall[i].vy -= 1
				arrBall[i].rotation=(180/Math.PI)*Math.atan2(arrBall[i].y-arrBall[i].tempy,arrBall[i].x-arrBall[i].tempx)-180
				
				arrBall[i].tempx = arrBall[i].x;
				arrBall[i].tempy = arrBall[i].y;

			}
			for (var j:int = 0; j < arrBall.length; j++) 
			{
						
				if (arrBall[j].hitTestObject(_view.enemyMap2['hit']))
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
			if (creation == true)
			{
				var ball:VaccineUI = new VaccineUI();
				_hero['mc1'].gotoAndPlay( CharacterConstant.FRIEND_WARRIOR_LAUNCH)
				ball.x = _hero.x;
				ball.y = _hero.y-10;
				vx=MathUtils.randomMinMax(10,15)
				vy=MathUtils.randomMinMax(8,12)
				ball.vy = vy;
				ball.vx = vx;
				ball.tempx=ball.x
				ball.tempy = ball.y
				arrBall.push(VaccineUI(_view.mview.addChild(ball)))
				ball.alpha = 0
				TweenLite.to(ball,0.5,{alpha:1})
			}

			/*if(creation==true){
				var ball:VaccineUI = new VaccineUI();
				ball.x = _hero.x;
				ball.y = _hero.y;
				ball.vy = vy;
				ball.tempx=ball.x
				ball.tempy=ball.y

			//ball.rotation = 90 - _hero.angle
			//ball.radio= 100
				arrBall.push(VaccineUI(_view.mview.addChild(ball)))
				
			}*/
			creation = true;
			
		}
		public function unexecute():void 
		{
			_context.stage.removeEventListener(MouseEvent.CLICK, CLICK_handler);
			creation = false;
		}
		
	}

}