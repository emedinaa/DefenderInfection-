package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import air.update.utils.Constants;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.controller.comand.CmdMoveHero;
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
		private var mview:GameView;
		public var hero:HeroUI;
		private var arrE:Vector.<EnemyUI>;
		private var arrPosition:Array;
		private var map:MapUI;
		private var cmdHero:CmdMoveHero;
		private var timer:Timer;
		private var _data:*;
		private var radio:int = GameConstant.RADIO;
		
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
			cmdHero.execute()
			initMove();
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
			createPosition();
			arrE = new Vector.<EnemyUI>();
			for (var i:int = 0; i < arrPosition.length; i++) 
			{
				var aux:EnemyUI = new EnemyUI();
				aux.x = GameConstant.PATH.x+Point.polar(GameConstant.RADIO, arrPosition[i]*Math.PI/180).x;
				aux.y = GameConstant.PATH.y + Point.polar(GameConstant.RADIO, arrPosition[i] * Math.PI / 180).y;
				aux.rotation = arrPosition[i]-90;
				arrE.push(aux);				
				mview.addChild(aux);
			}
		}
		public function createPosition():void {
			arrPosition = [];
			var rango:int = 20;
			var ant:int = -1;
			for (var i:int = 0; i < GameConstant.NUMENEMY; ) {
				var band:int = Math.random()*1000 % GameConstant.RADIO;
				if (band != ant && Math.abs(band-ant)>rango) {
					ant = band;
					arrPosition.push(band);
					trace(band);
					i++;
				}
			}
		}
		public function moveEnemy():void {
			radio-=5;
			for (var i:int = 0; i < arrE.length ; i++)
			{
				arrE[i].x = GameConstant.PATH.x+Point.polar(radio, arrPosition[i]*Math.PI/180).x;
				arrE[i].y = GameConstant.PATH.y + Point.polar(radio, arrPosition[i] * Math.PI / 180).y;
			}
		}
	}
}