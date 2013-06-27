
package manager
{
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class EventManager
	{
		private static var _instance : EventManager;
		
		public function EventManager(instance : SingleTon)
		{
			
			this.gameDispatch = new Shape;
			this.eventDispatcher = new EventDispatcher;
			
		}
		public static function getInstance():EventManager
		{
			if(EventManager._instance == null)
				 _instance = new EventManager(new SingleTon);
			return _instance;
		}
		
		public var eventDispatcher : IEventDispatcher;
		public var gameDispatch : Shape;
	}
}

class SingleTon{};