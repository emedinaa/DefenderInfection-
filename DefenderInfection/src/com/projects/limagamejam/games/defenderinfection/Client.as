package com.projects.limagamejam.games.defenderinfection 
{
	import com.projects.core.iview.AbstractView;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import com.projects.limagamejam.games.defenderinfection.view.mediator.HomeMediator;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class Client extends AbstractView 
	{
		private var context:ClientContext;
		
		public function Client() 
		{
			super();
			
		}
		
		override protected function app(e:Event = null):void 
		{
			super.app(e);
			context = new ClientContext(this, stage);
			
			/*var med:HomeMediator = new HomeMediator(new HomeView(), null);
			this.addChild(med.mview);*/
		}
		
	}

}