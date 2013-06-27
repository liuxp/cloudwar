package core.meditor
{
	import component.Dict;	
	import core.UID;
	import events.MeditorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import manager.EventManager;

	public class MeditorBase 
	{
		protected var dispatcher : IEventDispatcher = EventManager.getInstance().eventDispatcher;
		protected var _mid : String;
		protected var _listenerLis : Dict
		public function get mid():String
		{
			return _mid;
		}
		
		public function MeditorBase()
		{
			_mid = UID.createUID();
		}

		public function addMeditorEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			
			dispatcher.addEventListener(type,listener, useCapture, priority, useWeakReference);
			
			if(!_listenerLis) _listenerLis = new Dict();
			
			if(!_listenerLis.isHaveItem(type))
			{
				_listenerLis.AddItem(type, listener);
			}
			
			
		}
		
		public function removeMeditorEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if(!_listenerLis || !dispatcher) return;
			
			dispatcher.removeEventListener(type, listener, useCapture);

			if(_listenerLis.isHaveItem(type)) _listenerLis.DeleteItem(type);
			listener = null;
		}
		
		public function dispatchMeditorEvent(event:MeditorEvent):Boolean
		{
			
			return dispatcher.dispatchEvent(event);
		
		}
		
		public function hasMeditorEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		
		public function clear():void
		{
 
			if(_listenerLis)
			{
				var dict:Dictionary = this._listenerLis.dict;
				for(var type:String in dict)
				{
					var fun:Function = dict[type];
					this.removeMeditorEventListener(type,fun);
				}
				_listenerLis.DeleteAllItms();
				_listenerLis = null;
			}
			
			dispatcher = null;
		}
		
	}
}