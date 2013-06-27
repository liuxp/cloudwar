package command
{
	import core.ICommand;
	import core.meditor.MeditorBase;
	
	import manager.ModelLocator;

	public class CommandBase extends MeditorBase implements ICommand
	{
		protected var _ML : ModelLocator = ModelLocator.getInstance();
		
		public function CommandBase()
		{
			super();
		}
		
		public function execute(params:Object=null):void
		{
		}
		
		public function perform(params:Object=null):Object
		{
			return null;
		}
		
		override public function clear():void
		{
			super.clear();
			_ML = null;
		}
	}
}