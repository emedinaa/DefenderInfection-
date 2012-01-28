package com.projects.limagamejam.games.defenderinfection.view.mediator
{
	import air.update.utils.Constants;
	import com.greensock.TweenLite;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero2;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdShootHero;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import flash.display.Sprite;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameMediator extends AbstractMediator
	{
		public var mview:GameView;
		public var hero:HeroUI;
		public var arrE:Vector.<EnemyUI>;
		private var map:MapUI;
		private var cmdHero:CmdMoveHero;
		private var cmdHero2:CmdMoveHero2;
		private var cmdShoot:CmdShootHero;
		private var timer:Timer;
		private var _data:*;
		private var radio:int = GameConstant.RADIO;
		private var ultPosi:int = -1; //ultima posicion 
		public var enenMap:int = 0; //enemigos en mapa
		private var creationTime:int = 0; //tiempo de demora en creacion
		public var arrDead:Array = [];
		//nivel 2
		public var arrF:Vector.<FriendUI>;
		public var numF:int = GameConstant.NUMFRIENDS;
		public var hero2:FriendUI;
		public var enableMoveDe:Boolean = false;
		
		private var enableMoveEn:Boolean = true;
		private var _area:AreaView;
		private var context:ClientContext
		
		public function GameMediator($view:Sprite, $data:*)
		{
			super($view);
			mview = GameView($view);
			_data = $data
			context = $data.context
			
			initView()
		}
		
		override public function initView():void
		{
			
			super.initView();
			arrE = new Vector.<EnemyUI>();
			
			createMap();
			createHero();
			createEnemy();
			
			cmdHero = new CmdMoveHero(this, _data.context)
			cmdShoot = new CmdShootHero(this, _data.context)
			
			cmdHero.execute()
			initMove();
			cmdShoot.execute();
		}
		
		private function initMove():void
		{
			timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, TIMER_handler);
			timer.start();
		}
		
		private function TIMER_handler(e:TimerEvent):void
		{
			if (enableMoveEn)
			{
				moveEnemy()
				createEnemy();
				if (arrE.length > 5 && GameConstant.FRECUENCYOUT - 1 == creationTime)
				{
					var i:int = Math.random() * 1000 % (GameConstant.NUMENEMY - 5);
					arrE[i].active = false;
					enenMap--;
				}
				validateCollition()
			}
			if (enableMoveDe)
			{
				moveEnemyD();
				moveFriendD();
				
			}
			e.updateAfterEvent();
		
		}
		
		private function moveFriendD():void 
		{
			
		}
		
		private function moveEnemyD():void 
		{
			
		}
		
		private function validateCollition():void
		{
			for (var i:int = 0; i < arrE.length; i++)
			{
				if (hero.hitTestObject(arrE[i]))
				{
					enableMoveEn = false;
					enableMoveDe = true;
					showArea();
					return;
				}
			}
		}
		
		private function showArea():void
		{
			cmdHero.unexecute()
			cmdShoot.unexecute();
			_area = new AreaView();
			_area.bg.width = context.stage.stageWidth
			_area.bg.height = context.stage.stageHeight
			_area.mc_base.scaleX = 0
			_area.mc_base.scaleY = 0
			TweenLite.to(_area.mc_base, 0.8, {scaleX: 1, scaleY: 1});
			mview.addChild(_area)
			FriendsColocation();
			cmdHero2 = new CmdMoveHero2(this, _data.context);
			cmdHero2.execute();
		}
		
		private function FriendsColocation():void
		{
			var xx:int = 400;
			var yy:int = 200;
			var aux:int = 1;
			arrF = new Vector.<FriendUI>();
			for (var i:int = 0; i < numF; i++)
			{
				
				var alex:int = xx + Math.random() % 60;
				var aley:int = yy + Math.random() % 100;
				if (aux < 5)
				{
					yy += 80;
				}
				else
				{
					xx = 600;
					yy = 120;
					aux = 1;
				}
				aux++;
				trace(alex + " " + aley);
				var aux1:FriendUI = new FriendUI();
				aux1.x = alex;
				aux1.y = aley;
				aux1.posi = i;
				//aux1.addEventListener(MouseEvent.CLICK , CLICK_escoger)
				arrF.push(aux1);
				_area.addChild(aux1);
				
			}
			hero2 = new FriendUI();
			hero2.x = 250;
			hero2.y = 250;
			_area.addChild(hero2);
		}
		
		
		private function CLICK_escoger(e:MouseEvent):void
		{
			hero2 = e.target();
			hero2.x = hero2.x + 50;
			trace("me escogiste:");
		}
		
		public function createHero():void
		{
			hero = new HeroUI();
			hero.x = GameConstant.PATH.x;
			hero.y = GameConstant.PATH.y;
			//hero.rotation = 180;
			mview.addChild(hero);
		}
		
		public function createMap():void
		{
			trace(mview.height / 2 + "  " + mview.width / 2);
			map = new MapUI();
			map.x = GameConstant.PATH.x;
			map.y = GameConstant.PATH.y;
			mview.addChild(map);
		
		}
		
		public function createEnemy():void
		{
			creationTime++;
			
			if (enenMap < GameConstant.NUMENEMY && creationTime == GameConstant.FRECUENCYOUT)
			{
				var position:int = createPosition();
				if (arrE.length < GameConstant.NUMENEMY && !enemyDead())
				{
					var aux:EnemyUI = new EnemyUI();
					aux.x = GameConstant.PATH.x + Point.polar(GameConstant.RADIO, position * Math.PI / 180).x;
					aux.y = GameConstant.PATH.y + Point.polar(GameConstant.RADIO, position * Math.PI / 180).y;
					//aux.rotation = position - 90;
					aux.position = position;
					aux.active = true; //para ver si esta muerto
					aux.radio = GameConstant.RADIO;
					aux.posi = arrE.length;
					arrE.push(aux);
					mview.addChild(aux);
				}
				else
				{
					var i:int = arrDead.shift();
					arrE[i].x = GameConstant.PATH.x + Point.polar(GameConstant.RADIO, position * Math.PI / 180).x;
					arrE[i].y = GameConstant.PATH.y + Point.polar(GameConstant.RADIO, position * Math.PI / 180).y;
					//arrE[i].rotation = position - 90;
					arrE[i].position = position;
					arrE[i].active = true; //para ver si esta muerto
					arrE[i].radio = GameConstant.RADIO;
				}
				
				enenMap++;
			}
			if (creationTime == GameConstant.FRECUENCYOUT)
				creationTime = 0;
		}
		
		public function enemyDead():Boolean
		{
			var r:Boolean = false;
			for (var i:int = 0; i < arrE.length; i++)
			{
				if (arrE[i].active == false)
				{
					r = true;
					break;
				}
			}
			return r;
		}
		
		public function createPosition():int
		{
			var condition:Boolean = true;
			var band:int;
			while (condition)
			{
				band = Math.random() * 1000 % GameConstant.RADIO;
				if (band != ultPosi && Math.abs(band - ultPosi) > GameConstant.ENEMYRANG)
				{
					ultPosi = band;
					condition = false;
				}
			}
			return band;
		}
		
		public function moveEnemy():void
		{
			for (var i:int = 0; i < arrE.length; i++)
			{
				if (arrE[i].active == true)
				{
					arrE[i].radio -= 5;
					arrE[i].x = GameConstant.PATH.x + Point.polar(arrE[i].radio, arrE[i].position * Math.PI / 180).x;
					arrE[i].y = GameConstant.PATH.y + Point.polar(arrE[i].radio, arrE[i].position * Math.PI / 180).y;
				}
			}
		}
	
	}
}