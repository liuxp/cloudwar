package command
{
	import control.ai.CharacterAI;
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	import control.view.EffectMeditor;
	import control.view.SkillMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;
	
	/**
	 *生成剧情技能 
	 * @author Administrator
	 * 
	 */
	public class CreateStorySkillCommand extends CommandBase
	{
		private var _container:Sprite;
		private var _atkAI:CharacterAI;
		private var _skill:SkillVO;
		
		public function CreateStorySkillCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			_atkAI = params.ai;
			var skillId:String = params.skillId;
			var skillCfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, skillId);
			_skill = ObjToModelUtil.ObjToSkill(skillCfg);
			var _target:CharacterBase = params.target;
			
			var _targetAI:CharacterAI;
			var _charVO:CharacterVO;
			var _meditor_target:CharacterMeditor;
 
			
			if(_target)
			{
				_meditor_target = GameUtil.getCharMeditorByViewId(_target.uid);
				_targetAI = _meditor_target.ai;
			}
			
			CommandManager.SearchTargetForSkill({
				skill: _skill,
				target: _target,
				ai_target: _targetAI,
				meditor_target : _meditor_target
			});
			
			
			
			
			
			
			this.clear();
			
			//SoundManager.playSound(type);
		}
 
		
		override public function clear():void
		{
			this._container = null;
			
			super.clear();
		}
	}
}
