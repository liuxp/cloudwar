package net 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Elvis
	 */
	public class NetEvent extends Event 
	{
		public static const NET_STATUS_ERROR:String = 'net_status_error';
		public static const NET_SECURITY_ERROR:String = 'net_security_error';
		public static const NET_ASYNC_ERROR:String = 'net_ASYNC_error';
		public static const NET_BROADCAST_ALL:String = 'net_broadcast_all';
		public static const ERROR_BROADCAST:String = 'error_broadcast';
		
		public static const UI_LOADING:String = 'ui_loading';
		public static const UI_ERROR:String = 'ui_error';
		public static const UI_ERROR_LOADING:String = 'ui_error_loading';
//		public static const UI_IS_COMPLETE:String = 'ui_is_complete';
		public static const UI_WAS_COMPLETE:String = 'ui_was_complete';
		public static const SERVICE_SEND:String = 'service_send';
		public static const SERVICE_RE:String = 'service_re';
		
		public static const ASSETS_LOAD:String = 'assets_load';
		public static const ASSETS_OPEN:String = 'assets_open';
		
		public var data:Object
		public var contentObj:Object
		public function NetEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
		public static function setNeEventObj(_obj:Object,_eventString:String):NetEvent {
			var _event:NetEvent = new NetEvent(_eventString);
			_event.data = _obj;
			return _event;
		}	
	}

}