package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.UserVO;

	public class UserModel extends ModelBase
	{
		public var vo : UserVO;
		
		public function UserModel()
		{
			super();
		}
		
		override public function setVO(data:Object):void
		{
			vo = data as UserVO;
			
			Change();
		}
		
		override public function getVO():Object
		{
			return vo;
		}
		
		override protected function Change():void
		{
			ObserverManager.notifyObserver(this._uid, vo);
		}
		
	}
}