package core.observer
{
	public interface IObserver
	{
		function update(data:Object):void; //更新数据
		
		function get obsID():String; //得到观察者输出信息
		
		function get obsName():String;
		
	}
}