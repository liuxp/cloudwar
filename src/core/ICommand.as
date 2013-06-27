package core
{

	public interface ICommand {
	
		function execute(params:Object=null):void;
		function perform(params:Object=null):Object;
	}
}