package com.projects.limagamejam.games.defenderinfection.view.mediator
{
	import air.update.utils.Constants;
	import com.greensock.TweenLite;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero2;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdShootHero;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdShootHero2;
	import com.projects.limagamejam.games.defenderinfection.utils.CharacterConstant;
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
		private var cmdShoot2:CmdShootHero2;
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
		public var enemyMap2:EnemyMap2;
		public var enemyMira:int;
		public var friendSelected:Boolean=false;
		
		private var enableMoveEn:Boolean = true;
		private var enableMoveDe:Boolean = false;
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
				validateCollition()
			}
			if (enableMoveDe)
			{
				if(hero2!=null&& friendSelected==true){
					checkColisionM2();
					moveEnemyD();
					moveFriendD();
					if (hero2.active == false) {
						friendSelected = false;
						cmdHero2.unexecute();
						cmdShoot2.unexecute();
						for (var i:int = 0; i < arrF.length; i++) 
						{
							if (arrF[i].active == true)
								arrF[i].addEventListener(MouseEvent.CLICK , CLICK_escoger);
						}
					}
				}
				
			}
			e.updateAfterEvent();
		}
		
		private function checkColisionM2():void 
		{
			for (var i:int = 0; i < arrF.length; i++) 
			{
				
				if (enemyMap2.hitTestObject(arrF[i])&&arrF[i].active==true) {
					
					if (enemyMap2.hitTestObject(arrF[i])) {
						var aux:FriendUI = arrF[i];
						aux['mc'].gotoAndPlay(CharacterConstant.FRIEND_DEAD)
						//arrF.slice(i, 1);
						//_area.removeChild(aux);
						arrF[i].active=false;
						numF--;
						break;
					}
				}
			}
			
		}
		
		private function moveFriendD():void 
		{
			
			for (var i:int = 0; i < arrF.length; i++) 
			{
				var rad:int = Math.random()*1000%360;
				var radioM:int = 5;
				var enx:int = arrF[i].x + Point.polar(radioM, rad * Math.PI / 180).x;
				var eny:int = arrF[i].y + Point.polar(radioM, rad * Math.PI / 180).y;
				if(enx>20 && enx<980 )
					arrF[i].x = enx;
				if(eny>20 && eny<700)
					arrF[i].y = eny;
				
			}
		}
		
		private function moveEnemyD():void 
		{
			trace(arrF.length)
			if (arrF.length > 0) {
				var select:int;
				for (var i:int = 0; i < arrF.length; i++) 
				{
					if (arrF[i].active == true)
						select = i;
				}
				var rad:int = 0;
				if(enemyMap2.x<arrF[select].x)
					rad = Math.atan((enemyMap2.y - arrF[select].y) / (enemyMap2.x - arrF[select].x)) * 180 / Math.PI ;
				else
					rad = Math.atan((enemyMap2.y - arrF[select].y) / (enemyMap2.x - arrF[select].x)) * 180 / Math.PI+180 ;
				var radioM:int = 5 ;
				enemyMap2.x = enemyMap2.x + Point.polar(radioM, rad * Math.PI / 180).x;
				enemyMap2.y = enemyMap2.y + Point.polar(radioM, rad * Math.PI / 180).y;
			}
		}
		
		private function validateCollition():void
		{
			//trace("hola "+hero.Hit);
			for (var i:int = 0; i < arrE.length; i++)
			{
				
				if (hero.Hit.hitTestObject(arrE[i])&&arrE[i].active==true)
				{
					arrE[i].active = false;
					arrDead.push(arrE[i].posi);
					enenMap--;
					enableMoveEn = false;
					enableMoveDe = true;
					showArea();
					return;
				}
				if (map.Hit.hitTestObject(arrE[i]) && arrE[i].active == true) {
					arrE[i].active = false;
					arrDead.push(arrE[i].posi);
					enenMap--;
					numF--;
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
			friendsColocation();
			
			if (enemyMap2== null)
				enemyMap2 = new EnemyMap2();
			enemyMap2.x= 120;
			enemyMap2.y = 300;
			_area.addChild(enemyMap2);
		}
		
		private function friendsColocation():void
		{
			var aux:int = 1;
			arrF = new Vector.<FriendUI>();
			var ax:Array = [450, 600, 750,830];
			var ay:Array = [ 130 , 330, 520];
			for (var j:int = 0; j < ax.length; j++) 
			{
				for (var i:int = 0; i < ay.length; i++) 
				{
					if (aux > numF)
						return;
					var xx:int = ax[i];
					var yy:int = ay[j];
					var aux1:FriendUI = new FriendUI();
					aux1.x = xx;
					aux1.y = yy;
					aux1.posi = aux-1;
					aux1.active = true;
					aux1.addEventListener(MouseEvent.CLICK , CLICK_escoger)
					arrF.push(aux1);
					_area.addChild(aux1);
					aux++;
				}
			}
			//hero2 = new FriendUI();
			//hero2.x = 250;
			//hero2.y = 250;
		 //	_area.addChild(hero2);
		}
		
		
		private function CLICK_escoger(e:MouseEvent):void
		{
			hero2 = FriendUI(e.currentTarget);
			hero2.x = hero2.x + 50;
			for (var i:int = 0; i < arrF.length; i++) 
			{
				arrF[i].removeEventListener(MouseEvent.CLICK , CLICK_escoger);
			}
			cmdHero2 = new CmdMoveHero2(this, _data.context);
			cmdHero2.execute();
			cmdShoot2 =new CmdShootHero2(this, _data.context);
			cmdShoot2.execute();
			friendSelected = true;
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
			//trace("create Enemy ");
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
					aux['mc'].gotoAndPlay(CharacterConstant.ENEMY_INIT)
					arrE.push(aux);
					mview.addChild(aux);
				}
				else
				{
					var i:int = arrDead.shift();//devuelve el primer enemigo que murio
					arrE[i]['mc'].gotoAndPlay(CharacterConstant.ENEMY_INIT)
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
		/**
		 * al menos un enemigo vivo
		 * @return
		 */
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

		public function swapMap():void {
			mview.removeChild(_area);
			enableMoveEn = true;
			enableMoveDe = false;
			cmdHero2.unexecute();
			cmdShoot2.unexecute();
			cmdHero.execute()
			cmdShoot.execute();
		}
		
	}
}