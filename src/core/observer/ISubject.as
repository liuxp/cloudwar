package core.observer
{
	public interface ISubject
	{
		//添加观察者
		function addObserver(value:IObserver):void;
		//取消观察者
		function removeObserver(value:IObserver):void;
		//发送更改通知
		function notifyObserver(obsId:String, data:Object):void;
	}
}