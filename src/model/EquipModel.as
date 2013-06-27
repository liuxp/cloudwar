package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.EquipListVO;
	import model.vo.VOBase;
	
	public class EquipModel extends ModelBase
	{
		private var _vo:Object;
		
		public function EquipModel(vo:Object=null)
		{
			super(vo);
			_vo = vo ;
		}
		
		override public function setVO(data:Object):void
		{
			_vo = data
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