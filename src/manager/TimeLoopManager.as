
package manager
{
	import component.Dict;
	import component.TimeLoop;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import utils.SearchUtil;
	
	/**
	 * 延迟执行函数管理器
	 * leo
	 * */
	public class TimeLoopManager
	{
	
		private static var _instance : TimeLoopManager;
		private var _loopList : Array;
		private var _render : Shape;
		private var _dict : Dict;
		
		public static function getInstance():TimeLoopManager
		{
			if(!_instance)
			{
				_instance = new TimeLoopManager(new SingleTon);
				
			} 
			return _instance;
		}
		
		public function TimeLoopManager(singleTon:SingleTon)
		{
			if(!singleTon)
			{
				throw new Error('This class is SingleTon!');
				return;
			} 
			
			_dict = new Dict();
			_render = new Shape();
			
		}
		
		public function renderPause():void
		{
			_render.removeEventListener(Event.ENTER_FRAME, renderStart);
		}
		
		public function renderPlay():void
		{
			if(! _render.hasEventListener(Event.ENTER_FRAME))
			{
				trace('start timeloop ...');
				_render.addEventListener(Event.ENTER_FRAME, renderStart);
			} 
		}
		private function renderStart(e:Event):void
		{
			var dict:Dictionary = _dict.dict;
			for each(var i:TimeLoop in dict)
			{
				if(!i.isRunning)
				{
					 
					_dict.DeleteItem(i.id);
					
				}else{
					i.render();
				}
			}
			
			if(_dict.isEmpty())
			{
				_render.removeEventListener(Event.ENTER_FRAME, renderStart);
				trace('stop timeloop ...');
			} 
			
		}
		/**增加时间计时器
		 * @timeLoop 计时器 */
		public function addTimeLoop(timeLoop : TimeLoop, id:String):void
		{
			
			
			if(! _render.hasEventListener(Event.ENTER_FRAME))
			{
				trace('start timeloop ...');
				_render.addEventListener(Event.ENTER_FRAME, renderStart);
			} 
			
			if(id){
				timeLoop.id = id;
				if(!_dict.isHaveItem(id))
				{
					_dict.AddItem(id, timeLoop);
					
				}else{
					var tl:TimeLoop = _dict.getItem(id);
					tl.clear();
					tl = null;
					_dict.setItemValue(id, timeLoop);
				}
				
			}
		}
		
		public function delTimeLoop(id:String):void
		{
			if(_dict.isHaveItem(id))
			{
				var tl : TimeLoop = _dict.getItem(id);
				tl.clear();
				_dict.DeleteItem(id);
			}
 
		}
		
		public function isHaveTimeLoop(id:String):Boolean
		{
			return _dict.isHaveItem(id);
		}
		
		public function getTimeLoop(id:String):TimeLoop
		{
			return _dict.getItem(id);
		} 
	}
}
class SingleTon{};