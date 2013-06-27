package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.CharacterVO;
	
	public class CharacterModel extends ModelBase
	{
		private var _vo:CharacterVO;
		
		public function CharacterModel()
		{
			super();
		}
		
		override public function setVO(data:Object):void
		{
			_vo = data as CharacterVO;
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