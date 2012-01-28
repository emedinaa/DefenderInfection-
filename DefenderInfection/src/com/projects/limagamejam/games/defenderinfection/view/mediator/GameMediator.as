package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import com.projects.core.iview.AbstractMediator;
	import flash.display.Sprite;
	import com.projects.limagamejam.games.defenderinfection.utils.GameConstant;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class GameMediator extends AbstractMediator
	{
		private var mview:GameView;
		private var hero:HeroUI;
		private var arrE:Vector.<EnemyUI>;
		private var arrPosition:Array;
		private var map:MapUI;
		public function GameMediator($view:Sprite, $data:*) 
		{
			super($view);
			mview = GameView($view);
			initView()
		}
		override public function initView():void 
		{
			
			super.initView();
			createMap();
			createHero();
			createEnemy();
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
	}
}