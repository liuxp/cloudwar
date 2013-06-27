package command
{
	import control.ai.CharacterAI;
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	import control.view.EffectMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	import control.view.SkillMeditor;
	
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
	 *生成主动技能 
	 * @author Administrator
	 * 
	 */
	public class CreateSkillActiveCommand extends CommandBase
	{
		private var _container:Sprite;
		private var _atkAI:CharacterAI;
		private var _skill:SkillVO;
		
		public function CreateSkillActiveCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			_atkAI = params.ai;
			_skill = params.skill;
			var _target:CharacterBase = params.target;
			
			var _targetAI:CharacterAI;
			var _charVO:CharacterVO;
			var meditor_target:CharacterMeditor;

			
			
			_atkAI._vo.cd_skill = _skill.cd * 1000 / _atkAI._vo.delay;
			
			if(_target)
			{
				meditor_target = GameUtil.getCharMeditorByViewId(_target.uid);
				_targetAI = meditor_target.ai;
			}
				
			_atkAI.releaseSkill({
				skill: _skill,
				ai_atk:_atkAI,
				ai_target:_targetAI,
				params: params.params
				
			});
			
			//释放者的技能特效
			if(_skill.eff_up_self)	
			{
				_charVO = _atkAI._vo;
				
				createEft(_skill.eff_up_self, 60, 
					_charVO.scaleX, _atkAI.character.container_top);
				
			}

			
			
			/*CommandManager.SearchTargetForSkill({
				skill: _skill,
				ai_atk:_atkAI,
				ai_target:_targetAI,
				params: params.params
				
			})*/
			
			
			
			
			this.clear();
			
			//SoundManager.playSound(type);
		}
		
		private function createEft(eff:String, delay:int, scaleX:int, 
								   container:Sprite, cd:int=0):void
		{
			var atkEft:SheetSprite = new SheetSprite(eff);
			new EffectMeditor(atkEft, cd, false, delay);
			atkEft.scaleX = scaleX;
			container.addChild(atkEft);
		}
		
		override public function clear():void
		{
			this._container = null;
			
			super.clear();
		}
	}
}
