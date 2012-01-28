package com.projects.core.iview 
{
	/**
	 * ...
	 * @author emedinaa
	 */
	public class AbstractContext 
	{
		private var _view:AbstractView;
		
		public function AbstractContext($view:AbstractView) 
		{
			_view = $view;
		}
		
		public function get view():AbstractView { return _view; }
		
		public function set view(value:AbstractView):void 
		{
			_view = value;
		}
		
	}

}