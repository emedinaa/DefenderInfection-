package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import com.projects.core.iview.AbstractMediator;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class AreaMediator extends AbstractMediator 
	{
		private var mview:AreaView;
		
		public function AreaMediator($view:Sprite) 
		{
			super($view);
			mview = (AreaView)($view)
			
		}
		
	}

}