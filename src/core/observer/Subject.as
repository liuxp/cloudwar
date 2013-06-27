package core.observer
{
	import component.Dict;
	
	import core.observer.IObserver;
	import core.observer.ISubject;
	
	import flash.utils.Dictionary;

	internal class Subject implements ISubject
	{
		protected var _observerDict : Dictionary; //观察者列表
		
		public function Subject()
		{
			_observerDict = new Dictionary();
		}

		public function addObserver(value:IObserver):void
		{
			if(!_observerDict[value.obsID])
				_observerDict[value.obsID] = new Dictionary;
			var obsName : String = value.obsName;
			_observerDict[value.obsID][obsName] = value;
		}
		
		public function addObservers(value:IObservers):void
		{
			var ids:Array = value.obsIDs;
			var names:Array = value.obsNames;
			var len:int = ids.length;
			for(var i:int; i<len; i++)
			{
				var id:String = ids[i];
				var name:String = names[i];
				if(!_observerDict[id])
					_observerDict[id] = new Dictionary;
				
				_observerDict[id][name] = value;
			}
		}
		
		public function removeObservers(value:IObservers):void
		{
			var ids:Array = value.obsIDs;
			var names:Array = value.obsNames;
			var len:int = ids.length;
			for(var i:int; i<len; i++)
			{
				var obsID:String = ids[i];
				var obsName : String = names[i];
				var dict:Dictionary = _observerDict[obsID];
				if(dict)
				{
					dict[obsName] = null;
					delete dict[obsName];
				}
				
				if(isEmpty(dict))
				{
					_observerDict[obsID] = null;
					delete _observerDict[obsID];
				}
				
			}
		}
		
		public function removeObserver(value:IObserver):void
		{
			var obsID : String = value.obsID;
			var dict:Dictionary = _observerDict[obsID];
			if(dict)
			{
				var obsName : String = value.obsName;
				dict[obsName] = null;
				delete dict[obsName];
			}
 
			if(isEmpty(dict))
			{
				_observerDict[obsID] = null;
				delete _observerDict[obsID];
			}
			
			value = null;
		}
		
		public function notifyObserver(obsId:String, data:Object):void
		{
			var dict:Dictionary = _observerDict[obsId];
			for (var obsName : String in dict)
			{
				if(dict[obsName]) dict[obsName].update(data);
			}
			
		}
		
		private function isEmpty(dict:Dictionary):Boolean
		{
			for(var i:String in dict)
			{
				if(dict[i])return false;
			}
			
			return true;
			
		}
	}
}