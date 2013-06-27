package command
{
 
	import control.sound.SoundManager;
	
	import manager.CommandManager;
	import manager.TimeLoopManager;
	
	import model.config.StaticConfig;
	 
	
	 
	/**
	 *游戏设置(暂停、恢复、中断战斗重新选关)
	 * @author Administrator
	 * 
	 */
	public class GameSettingCommand extends CommandBase
	{
		
		
		public function GameSettingCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			switch(params)
			{
				case StaticConfig.Game_Setting_Pause :
					//_ML.game.mPanelScene.setSys(true);
					TimeLoopManager.getInstance().renderPause();
					SoundManager.pauseAllSounds();
					break;
				case StaticConfig.Game_Setting_Resume :
					TimeLoopManager.getInstance().renderPlay();
					SoundManager.resumeAllSounds();
					break;
				case StaticConfig.Game_Setting_PKBreak :
					TimeLoopManager.getInstance().renderPlay();
					CommandManager.clearWave();
					CommandManager.ChangeScene(StaticConfig.Scene_Mission);
					break;
				case StaticConfig.Game_Setting_SpeedUp :
					speedup();
				default :
					break;
			}
			
			//CommandManager.clearWave();
			
		}
		
		private function speedup():void
		{
			var fr:int = _ML.game.stage.frameRate;
			if(fr <= 25) _ML.game.stage.frameRate = 50;
			else if(fr >25) _ML.game.stage.frameRate = 25;
		}
		
	}
}