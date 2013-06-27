package command
{
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.config.ArmyConfig;
	import model.config.GameCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.MessionVO;
	import model.vo.UserVO;
	import model.vo.WaveVO;
	
	import utils.ColorTransUtil;
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	import view.component.Zone;
	import view.scene.MapBGImg;

	/**
	 *生成关卡 
	 * @author Administrator
	 * 
	 */
	public class CreateMessionCommand extends CommandBase
	{
		private var container_map:MapBGImg;
		private var container_character :Sprite;

		private var _user:UserVO;
 
		private var _charModels:Array;
		
		public function CreateMessionCommand()
		{
			super();
			container_map = _ML.game.scene_PK.map;
			container_character = _ML.game.scene_PK.container_character;

			
			//this.addMeditorEventListener(MeditorEvent.Get_NextWave, getNextWaveHandler);
		}

		
		override public function execute(params:Object=null):void
		{
			
			_user = _ML.user.getVO() as UserVO;
			
			_charModels = [];
			
			var cfg_mession : Object = _user.mMession;
										/*GameUtil.getCfgByItmID(
										StaticConfig.Cfg_Mession, 
										_ML.user.vo.seleced_mession);
				
			
			_user.mMession = cfg_mession;*/
			
			/*var mession:MessionVO = ObjToModelUtil.ObjtoMession(cfg_mession);
			_ML.mession = mession;*/
			var baseSet:Object = cfg_mession.BaseSet
				
			if(baseSet.hasOwnProperty('OurDirDefault'))
			{
				_ML.ourDirDefault = baseSet.OurDirDefault;
			}else{
				_ML.ourDirDefault = true;
			}
 			
			if(baseSet.hasOwnProperty('EnemyDirDefault'))
			{
				_ML.enemyDirDefault = baseSet.EnemyDirDefault;
			}else{
				_ML.enemyDirDefault = true;
			}
			
			
			
			initArmyLimit();
			
			CommandManager.CreateBattleMap();
			
			this.createArmies(cfg_mession.OurBorn, ArmyConfig.Camp_Me);
			this.createArmies(cfg_mession.EnemyBorn,ArmyConfig.Camp_Enemy);	
			
			_ML.dialogType = StaticConfig.Dialog_BattleBefore;
			
			CommandManager.CreateBattleStory(_ML.user.vo.seleced_mession);
			
			SoundManager.stopSound('bg_no');
			SoundManager.playSound('bg_wind',true);
		}

 		private function initArmyLimit():void
		{
			var limit:Object = _user.mMession.BaseSet.Limite;
			var heros:Array = _ML.pkHeros.getVO() as Array;
			for each( var i:GeneralModel in heros)
			{
				var vo:GeneralVO = i.getVO() as GeneralVO
				if(limit[vo.id])
				{
					vo.limit = limit[vo.id];
					
				}
				i.setVO(vo);
			}
			
		}
		
		private function createArmies(armies:Object, camp:int):void
		{

			for each(var itm:Object in armies)
			{
				createCharacter(itm.id, itm, camp);
			}
		}
		
		private function createCharacter(gid:String, cfg:Object, camp:int):void
		{
			
			if(!gid) return;
			var _pos:Array = [cfg.X, cfg.Y];
			var itm:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, gid);
			var lv:int;
			if(itm.id == ArmyConfig.MonarchID)
			{
				var myArmy:GeneralVO = _ML.monarch_general.getVO() as GeneralVO
				lv = myArmy.lv;
			}else{
				lv = cfg.Level;
			}
			
			var vo:CharacterVO =  ObjToModelUtil.ObjToCharacter(itm, lv);
			vo.init_ai = cfg.AiType;
			vo.storySkillId = cfg.SkillType;
			vo.dir = cfg.dir;
			var skill_lv:int=1;
			if(vo.armyType == ArmyConfig.Type_General)
			{
				skill_lv = Math.max(0, vo.lv - 50);
			}
			
			vo.updateSkill(skill_lv);
			vo.range_atk = vo.skill_normal.range + Math.random()*20 + Math.random()*30;
			vo.init_range_atk = vo.range_atk;
			vo.camp = camp;
			
			
			var container: Sprite = _ML.game.scene_PK.container_character;
			CommandManager.createCharacter({vo:vo, pos:_pos, container:container, ai:false});
			
			
		}
		
		override public function clear():void
		{
			super.clear();
			
			container_character = null;
			container_map = null;
			_user = null;
		}
	}
}