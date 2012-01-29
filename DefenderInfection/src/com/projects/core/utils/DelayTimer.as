package com.projects.core.utils 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class DelayTimer 
	{
		private var _callback : Function;
		private var _parameters : Array;
		private var _timer : Timer;
		private var _cleanup : Boolean;
		private var _stack : String;
		
		public function DelayTimer(inCallback : Function, inTime : int = 1000, inParams : Array = null, inStartInstantly : Boolean = true, inCleanupAfterDelay : Boolean = true) 
		{
			_stack = new Error().getStackTrace();
			_callback = inCallback;
			_parameters = inParams;
			
			_timer = new Timer(inTime, 1);
			_timer.addEventListener(TimerEvent.TIMER, handleTimerEvent);
			
			_cleanup = inCleanupAfterDelay;
			
			if (inStartInstantly) {
					resetAndStart();
			}
		}
		
		private function handleTimerEvent(e:TimerEvent):void 
		{
			 if (_parameters == null) {
					try {
							_callback();
					}catch(e : Error) {
							//logger.error("Time delay error (no arguments): " + e.message + (_stack ? "\n" + _stack.split("\n").slice(2).join("\n") : ""));
					}
			} else {
					try {
							_callback.apply(null, _parameters);
					}catch(e : Error) {
							//logger.error("Time delay error (with arguments): " + e.message + (_stack ? "\n" + _stack.split("\n").slice(2).join("\n") : ""));
					}
			}

			if (_cleanup) {
					die();
			}
		}
		
		public function get delay():int 
		{
			return _timer.delay;
		}
		
		public function set delay(inDelay:int):void 
		{
			_timer.delay = inDelay;
		}
		
		public function get running() : Boolean {
				return (_timer && _timer.running);
		}
		public function reset() : void {
				 if (_timer) {
						 _timer.stop();
				 }
		 }
		 
		public function resetAndStart() : void {
				_timer.reset();
				_timer.start();
		}
		
		public function die() : void {
				if (_timer) {
						_timer.removeEventListener(TimerEvent.TIMER, handleTimerEvent);
						_timer.stop();
				}
				_timer = null;
				_callback = null;
				_parameters = null;
		}
		
		
	}

}