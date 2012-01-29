package com.projects.limagamejam.games.defenderinfection.controller.comand 
{
	import com.greensock.TweenLite;
	import com.projects.core.icommand.ICommand;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.CharacterConstant;
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
	 * @author emedinaa
	 */
	public class CmdShootHero implements ICommand 
	{
		private var _view:GameMediator;
		private var _context:ClientContext;
		private var _hero:HeroUI
		
		private var _t:Timer;
		private var arrBall:Vector.<BulletUI> 
		
		public function CmdShootHero($view:GameMediator,$context:ClientContext) 
		{
			_view = $view;
			_context = $context;
			_hero=_view.hero
		}
		
		/* INTERFACE com.projects.core.icommand.ICommand */
		
		public function execute():void 
		{
			arrBall = new Vector.<BulletUI>();
			_context.stage.addEventListener(MouseEvent.CLICK, CLICK_handler);
			if(_t==null)
				_t = new Timer(100, 0);
			_t.addEventListener(TimerEvent.TIMER,TIMER_handler)
			_t.start();
		}
		
		private function TIMER_handler(e:TimerEvent):void 
		{
			for (var i:int = 0; i < arrBall.length; i++) 
			{
				arrBall[i].radio+=40
				arrBall[i].x=GameConstant.PATH.x+Point.polar(arrBall[i].radio,arrBall[i].rotation*Math.PI/180).x
				arrBall[i].y=GameConstant.PATH.y+Point.polar(arrBall[i].radio,arrBall[i].rotation*Math.PI/180).y
			}
			
			for (var j:int = 0; j < arrBall.length; j++) 
			{
					for (var k:int = 0; k < _view.arrE.length; k++) 
					{
						if (arrBall[j].hitTestObject(_view.arrE[k]))
						{
							if (_view.arrE[k].active == true){
								_view.arrDead.push(_view.arrE[k].posi);
								_view.arrE[k]['mc'].gotoAndPlay(CharacterConstant.ENEMY_DEAD)	
								_view.arrE[k].active = false
								_view.enenMap--
							}
							_view.mview.removeChild(arrBall[j]);
							arrBall.splice(j,1)
							//    list.splice(i,1);
							return
						}
					}
				
			}
			e.updateAfterEvent()
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			_hero['mc'].gotoAndPlay(CharacterConstant.HERO_SHOOT);
			createBall();
		}
		
		private function createBall():void 
		{
			//var ball:Ball = new Ball();
			_view.mSound.addExternalSound("media/submachine_gun.mp3","sndShoot")
			_view.mSound.playSound("sndShoot")
			var ang:Number = 90 - _hero.angle;
			
			var ball:BulletUI=new BulletUI()
			ball.x = _hero.x+Point.polar(25,ang*Math.PI/180).x
			ball.y = _hero.y+Point.polar(25,ang*Math.PI/180).y;
			ball.rotation = ang
			ball.radio = 100
			ball.alpha = 0;
			TweenLite.to(ball,0.5,{alpha:1})
			arrBall.push(BulletUI(_view.mview.addChild(ball)))
			
		}
		
		/*private function MOUSE_MOVE_handler(e:MouseEvent):void 
		{
			var auxMx:int = _context.stage.mouseX-GameConstant.PATH.x;
			if (auxMx > 0) { if (auxMx > 400) { auxMx = 400 }}
			if (auxMx < 0) { if (auxMx < -400) { auxMx = -400 }}
			
			var dx:int = auxMx;
			var percent:Number = auxMx / 400;
			var angle:Number = 180 * percent;
			
			var pos:Point = Point.polar(GameConstant.RADIO_HERO,- angle * Math.PI / 180+Math.PI/2)
			_hero.x=GameConstant.PATH.x+pos.x
			_hero.y=GameConstant.PATH.y+pos.y
			
			trace("dx ",angle)
		}*/
		
		public function unexecute():void 
		{
			_context.stage.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
		
	}

}