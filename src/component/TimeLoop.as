package component
{
	import flash.utils.getTimer;
	
	public class TimeLoop
	{
		private var _count : uint; /**设定总计数*/
		private var _delay : uint; /**延迟*/
		private var _fun : Function;/**执行函数*/
		private var _curTime : Number = 0; /**当前计时*/
		private var _curCount : uint; /**当前计数*/
		private var _isRunning : Boolean; /**是否在计时中*/
		public var id : String;
		public var funName:String;
		private var _complete:Function;/**倒计时完成执行函数*/
		private var _completeParams:Array;/**函参*/
		private var _funParams:Array;/**函参*/
		
		public function get curCount():uint
		{
			return _curCount;
		}
		public function get isRunning():Boolean
		{
			return _isRunning
		}
		
		/**constructor 
		 * @param delay 延迟
		 * @param count 设定总计数
		 * @param fun 执行函数
		 * */
		public function TimeLoop(delay:uint, count:uint, fun:Function, 
								 complete:Function=null, completeParams:Array=null,
								 funParams:Array=null):void
		{
			_count = count;
			_delay = delay;
			_fun = fun;
			_complete = complete;
			_completeParams = completeParams;
			_funParams = funParams;
			_isRunning = true;
		 	
			
		}
		 
		public function render():void
		{
			if(!_isRunning) return;
			
			if(!_curTime)
			{
				_curTime = getTimer();
			} 
			/**如果达到延迟的时间则执行函数，并更新计数*/
			if(checkTime())
			{
				if(_curCount < _count)
				{
					if(!this._funParams)_fun();
					else _fun.apply(null, _funParams); 
					_curCount ++;
					//_curTime = getTimer();
					
				 
				}else{/**如果总计数为0则无限循环*/
					if(_count>0)
					{
						clear();
						if(_complete!=null)
						{
							if(_completeParams) _complete.call(null,_completeParams);
							else _complete();
						}
					}else{
						if(!this._funParams)_fun();
						else _fun.apply(null, _funParams);
					}
					 
				}
				_curTime = getTimer();
			}
			
		}
		 
		public function clear():void
		{
			 _isRunning = false;
			 _fun = null;
			 //id = null; 
		}
		public function reset():void
		{
			
		}
		private function checkTime():Boolean
		{
			return getTimer() - _curTime >= _delay
		}
	}
}