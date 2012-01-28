package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import air.update.utils.Constants;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdShootHero;
	import flash.display.Sprite;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
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
		private var arrE:Vector.<EnemyUI>=new Vector.<EnemyUI>();
		private var map:MapUI;
		private var cmdHero:CmdMoveHero;
		private var cmdShoot:CmdShootHero;
		private var timer:Timer;
		private var _data:*;
		private var radio:int = GameConstant.RADIO;
		private var ultPosi:int = -1;//ultima posicion 
		private var enenMap:int = 0 ;//enemigos en mapa
		private var creationTime:int = 0;//tiempo de demora en creacion
		
		public function GameMediator($view:Sprite, $data:*) 
		{
			super($view);
			mview = GameView($view);
			_data=$data
			initView()
		}
		override public function initView():void 
		{
			
			super.initView();
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
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, TIMER_handler);
			timer.start();
		}
		
		private function TIMER_handler(e:TimerEvent):void 
		{
			moveEnemy();
			createEnemy();
			if (arrE.length > 5 && GameConstant.FRECUENCYOUT-1==creationTime) {
				var i:int = Math.random() * 1000 %( GameConstant.NUMENEMY-5);
				arrE[i].active = false;
				enenMap--;
			}
			e.updateAfterEvent();
			
		}
		public function createHero():void {
			hero = new HeroUI();
			hero.x = GameConstant.PATH.x;
			hero.y = GameConstant.PATH.y;
			mview.addChild(hero);
		}
		public function createMap():void {
			trace(mview.height / 2+ "  "+mview.width/2);
			map = new MapUI();
			map.x = GameConstant.PATH.x;
			map.y = GameConstant.PATH.y;
			mview.addChild(map);
			
		}
		public function  createEnemy():void {
			creationTime++;
			
			if (enenMap < GameConstant.NUMENEMY && creationTime==GameConstant.FRECUENCYOUT) {
				var position:int = createPosition();
				if (arrE.length < GameConstant.NUMENEMY&&!enemyDead()) {					
					var aux:EnemyUI = new EnemyUI();
					aux.x = GameConstant.PATH.x+Point.polar(GameConstant.RADIO, position*Math.PI/180).x;
					aux.y = GameConstant.PATH.y + Point.polar(GameConstant.RADIO, position * Math.PI / 180).y;
					aux.rotation = position - 90;
					aux.position = position;
					aux.active = true;//para ver si esta muerto
					aux.radio = GameConstant.RADIO;
					arrE.push(aux);				
					mview.addChild(aux);
				}else {
					for (var i:int = 0; i < arrE.length; i++) 
					{
						if (arrE[i].active == false) {
							arrE[i].x = GameConstant.PATH.x+Point.polar(GameConstant.RADIO, position*Math.PI/180).x;
							arrE[i].y = GameConstant.PATH.y + Point.polar(GameConstant.RADIO, position * Math.PI / 180).y;
							arrE[i].rotation = position - 90;
							arrE[i].position = position;
							arrE[i].active = true;//para ver si esta muerto
							arrE[i].radio = GameConstant.RADIO;
							break;
						}	
					}
				}
				
				enenMap++;
			}
			if (creationTime == GameConstant.FRECUENCYOUT)
				creationTime = 0;
		}
		public function enemyDead():Boolean {
			var r:Boolean = false;
			for (var i:int = 0; i < arrE.length; i++){ 
				if (arrE[i].active == false) {
					r = true;
					break;
				}
			}
			return r;
		}
		public function createPosition():int{
			var condition:Boolean = true;
			var band:int;
			while (condition) {
				band = Math.random()*1000 % GameConstant.RADIO;
				if (band != ultPosi && Math.abs(band-ultPosi)>GameConstant.ENEMYRANG) {
					ultPosi = band;
					condition=false;
				}
			}
			return band;
		}
		public function moveEnemy():void {
			for (var i:int = 0; i < arrE.length ; i++)
			{
				if(arrE[i].active==true){
					arrE[i].radio -= 5;
					arrE[i].x = GameConstant.PATH.x+Point.polar(arrE[i].radio, arrE[i].position*Math.PI/180).x;
					arrE[i].y = GameConstant.PATH.y + Point.polar(arrE[i].radio, arrE[i].position * Math.PI / 180).y;
				}
			}
		}
	}
}