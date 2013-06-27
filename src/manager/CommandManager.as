package manager
{
	import command.*;
	
	import core.ICommand;
	
	import model.config.StaticConfig;
	
	import view.component.Zone;
	
	public class CommandManager
	{
		public function CommandManager()
		{
		}
		/**
		 *得到配置数据
		 * @param data
		 * 
		 */		
		static public function GetGameCfg():void
		{
			excute(GetGameCfgCommand);
		}
		/**
		 *复活角色 
		 * @param data
		 * 
		 */		
		static public function rebornArmy(data:Object):void
		{
			excute(RebornArmyCommand, data);
		}
		
		/**
		 *英雄技能
		 * @param data
		 * 
		 */		
		static public function createHeroSkill(data:Object):void
		{
			excute(CreateHeroSkillCommand, data);
		}
		/**
		 *释放技能
		 * @param data
		 * 
		 */		
		static public function createSkill(data:Object, type:String):void
		{
			var cmdClass:Class;
			switch(type)
			{
				case StaticConfig.SkillType_Normal :
					cmdClass = CreateSkillNormalCommand;
					break;
				case StaticConfig.SkillType_Active :
					cmdClass = CreateSkillActiveCommand;
					break; 
				default :
					break;
			}
			excute(cmdClass, data);
		}
		
		static public function createStorySkill(data:Object):void
		{
			excute(CreateStorySkillCommand, data);
		}
		
		/**
		 *特效 
		 * @param data
		 * 
		 */		
		static public function createEffect(data:Object):void
		{
			excute(CreateEffectCommand, data);
		}
		/**
		 *生成子弹 
		 * @param data
		 * 
		 */		
		static public function createBullet(data:Object):void
		{
			excute(CreateBulletCommand, data);
		}
		/**
		 *生成关卡 
		 * @param messionId
		 * 
		 */		
		static public function createMession():void
		{
			excute(CreateMessionCommand);
		}
		/**
		 *生成小波敌人 
		 * @param waveId
		 * 
		 */		
		static public function createWave(data:Object):void
		{
			excute(CreateWaveCommand, data);
		}
		/**
		 *生成角色
		 * @param waveId
		 * 
		 */		
		static public function createCharacter(data:Object):void
		{
			excute(CreateCharacterCommand, data);
		}
		 
		
		/**
		 *寻找技能伤害目标 
		 * @param data
		 * 
		 */		
		static public function SearchTargetForSkill(data:Object):void
		{
			excute(SearchTargetForSkillCommand, data)
		}
		/**
		 *得到波奖励 
		 * 
		 */		
		static public function getWaveRwd():void
		{
			excute(GetWaveRwdCommand, null)
		}
		/**
		 *清除关卡 
		 * 
		 */		
		static public function clearMession():void
		{
			excute(ClearMessionCommand, null)
		}
		/**
		 *清除波
		 * 
		 */		
		static public function clearWave():void
		{
			excute(ClearWaveCommand, null)
		}
		/**
		 *改变场景 
		 * 
		 */		
		static public function ChangeScene(scene:String):void
		{
			excute(ChangeSceneCommand, scene)
		}
		/**
		 *游戏设置 
		 * @param value
		 * 
		 */		
		static public function GameSetting(value:String):void
		{
			excute(GameSettingCommand, value)
		}
		/**
		 *游戏状态 
		 * @param value
		 * 
		 */		
		static public function SetGameState(value:String):void
		{
			excute(SetGameStateCommand, value)
		}
		/**
		 *战斗剧情 
		 * @param value
		 * 
		 */		
		static public function CreateBattleStory(value:String):void
		{
			excute(CreateBattleStoryCommand, value)
		}
		/**
		 *生成战斗地图
		 * @param value
		 * 
		 */		
		static public function CreateBattleMap(data:Object=null):void
		{
			excute(CreateBattleMapCommand, data)
		}
		/**
		 *对话 
		 * @param data
		 * 
		 */		
		static public function MakeDialogs(data:Object):void
		{
			excute(MakeDialogsCommand, data)
		}
		/**
		 *开始战斗 
		 * 
		 */		
		static public function StartPK():void
		{
			excute(StartPKCommand);
		}
		/**
		 *移动镜头 
		 * @param data
		 * @return 
		 * 
		 */		
		static public function MoveCamera(data:Object):void
		{
			excute(MoveCameraCommand, data);
		}
		
		static public function ShowTip(data:String):void
		{
			excute(ShowTipCommand, data);
		}
		
		/****************************分割线*****************************/
		//执行命令
		static private function excute(cmdClassObj:Class, params:Object=null):void
		{
			var cmd : ICommand = new cmdClassObj as ICommand;
			cmd.execute(params);
		}
		//回调命令
		static private function perform(cmdClassObj:Class, params:Object=null):Object
		{
			var cmd : ICommand = new cmdClassObj as ICommand;
			return cmd.perform(params);
		}
	}
}