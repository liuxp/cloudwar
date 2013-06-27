package command
{
	import events.MeditorEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.vo.MessionVO;
	
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	 
	
	/**
	 *清除关卡 
	 * @author Administrator
	 * 
	 */
	public class ClearMessionCommand extends CommandBase
	{
		
		
		public function ClearMessionCommand()
		{
			super();
			
			
			
		}

		override public function execute(params:Object=null):void
		{
			if(_ML.game.scene_PK) _ML.game.scene_PK.x = 0;
			_ML.wave = null;
			_ML.master = null;
			
			CommandManager.clearWave();
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.PK_End));
		}
		
		
	}
}