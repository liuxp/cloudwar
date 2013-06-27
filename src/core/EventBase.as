package core
{
	import flash.events.Event;

	public class EventBase extends Event
	{
		protected var _data : Object;
		
		public function get data():Object
		{
			return _data;
		}
		public function EventBase(type:String, obj:Object=null,bubbles:Boolean=false)
		{
			if(obj) _data = obj;
			
			super(type, bubbles);
			
		}
		
		/* override public function clone():Event
		{
			return new EventBase(this.type, _data, this.bubbles);
		} */
		
	}
}