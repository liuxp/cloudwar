package control.skill
{
	import control.ai.CharacterAI;
	import control.view.EffectMeditor;
	
	import core.meditor.MeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import manager.ModelLocator;
	
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	public class SkillBase extends MeditorBase implements ISkill
	{
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		protected var _pos:Point;
		protected var _hero:CharacterVO
		protected var _params:Object;
		protected var _effect:String;
		protected var _otherSkills:Array;
		protected var _skill:SkillVO;
		
		public function SkillBase(data:Object)
		{
			_skill = data.skill;
			_params = data.params;
			_effect = data.effect;
			_otherSkills = data.otherSkills;
		}
		
		public function realize():void
		{
		}
		
		public function done():void
		{
			 
		}
		
		protected function targetInjured(targetAI:CharacterAI):void
		{
			var vo:CharacterVO = targetAI._vo;
			
			createEft(_skill.eff_up_enimy, vo.delay, 
				vo.scaleX, targetAI.character.container_temp);
 
			if(vo.armyType == ArmyConfig.Type_Dancer)
			{
				var damage:int = -Math.min( _skill.damage, (vo.hp_max - vo.hp));
			}else{
				damage = _skill.damage;
			}
			vo.hp -= damage;
			targetAI._model.setVO(vo);
			
			targetAI.injured();
		}
		
		protected function createEft(eff:String, delay:int, scaleX:int, container:Sprite, cd:int=0):void
		{
			var atkEft:SheetSprite = new SheetSprite(eff);
			new EffectMeditor(atkEft, cd, false, delay);
			atkEft.scaleX = scaleX;
			container.addChild(atkEft);
		}
		
		override public function clear():void
		{
			super.clear();
			_ML = null;
			_pos = null;
			_hero = null;
			_params = null;
		}
	}
}