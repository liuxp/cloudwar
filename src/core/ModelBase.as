package core
{
 	/**
	 * 数据模型
	 * */
	public class ModelBase 
	{
		protected var _uid : String;
		
		public function get uid():String { return _uid; }
		
		public function ModelBase(vo:Object=null)
		{
			_uid = UID.createUID();
 
		}
		
		
		public function setVO(data:Object):void
		{
			
		}
		
		public function getVO():Object
		{
			return null;
		}
 
		protected function Change():void
		{
			//this.dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		
		
	}
}