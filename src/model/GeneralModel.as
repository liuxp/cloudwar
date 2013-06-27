package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.GeneralVO;
	
	public class GeneralModel extends ModelBase
	{
		private var _vo:GeneralVO;
		
		public function GeneralModel(vo:Object=null)
		{
			super(vo);
			_vo = vo as GeneralVO;
		}
		
		override public function setVO(data:Object):void
		{
			_vo = data as GeneralVO
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