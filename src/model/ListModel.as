
package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
 
	
	public class ListModel extends ModelBase
	{
		private var _vo:Array;
		
		public function ListModel(list:Array=null)
		{
			super();
			_vo = list;
		}
		
		override public function setVO(data:Object):void
		{
			_vo = data as Array;
			this.Change();
		}
		
		override public function getVO():Object
		{
			return _vo;
		}
		
		override protected function Change():void
		{
			ObserverManager.notifyObserver(this._uid, _vo);
		}
	}
}