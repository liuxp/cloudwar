package core.observer
{
	import core.observer.IObserver;
	/**
	 * 数据绑定管理
	 * */
	public class ObserverManager
	{
		private static var _subject : Subject = new Subject;
		
		public function ObserverManager()
		{
		}
		
		public static function addObserver(obs:IObserver):void
		{
			_subject.addObserver(obs);
		}
		
		public static function addObservers(obs:IObservers):void
		{
			_subject.addObservers(obs);
		}
		
		public static function removeObserver(obs:IObserver):void
		{
			_subject.removeObserver(obs);
		}
		
		public static function removeObservers(obs:IObservers):void
		{
			_subject.removeObservers(obs);
		}
		
		public static function notifyObserver(obsId:String, data:Object):void
		{
			_subject.notifyObserver(obsId, data);
		}
		
	}
}