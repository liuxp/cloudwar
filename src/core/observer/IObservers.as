package core.observer
{
	public interface IObservers
	{
		function update(data:Object):void; //更新数据
		
		function get obsIDs():Array; //得到观察者输出信息
		
		function get obsNames():Array;
	}
}