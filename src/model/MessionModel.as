
package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.MessionVO;

	public class MessionModel extends ModelBase
	{
		private var _vo : MessionVO;
		
		public function MessionModel()
		{
			super();
		}
		
		override public function setVO(data:Object):void
		{
			_vo = data as MessionVO;
			Change();
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