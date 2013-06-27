
package command
{
	import events.MeditorEvent;
	
	import manager.CommandManager;
	
	import model.config.StaticConfig;
	
	import utils.GameUtil;

	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * GameStateCommand.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-5 下午3:00:40
	 * @history 05/00/12,
	 */ 
	public class SetGameStateCommand extends CommandBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function SetGameStateCommand()
		{
			super();
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function execute(params:Object=null):void
		{
			var state:String = params as String;
			switch(state)
			{
				case StaticConfig.Scene_PK_Fail :
				case StaticConfig.Scene_PK_Win :
					pkOver(state);
					break;
				
				default :
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		private function pkOver(state:String):void
		{
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.AI_Stop));
			
			CommandManager.ChangeScene(state);
			
			
			//GameUtil.delayExecuteFun(1000, delayFun, 1, 'mession_faile');
		}
		
		 
	}
	
}