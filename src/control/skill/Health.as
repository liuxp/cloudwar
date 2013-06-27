package control.skill
{
	import component.Dict;
	
	import control.ai.CharacterAI;
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *回血 
	 * @author Administrator
	 * 
	 */	
	public class Health extends SkillBase
	{
		private var _range:int = 50;
		private var _atkAI:CharacterAI;
		private var _atkVO:CharacterVO;
		private var _targetAI:CharacterAI;
		
		public function Health(data:Object)
		{
			super(data);
			_atkAI = data.ai_atk;
			_atkVO = _atkAI._vo;
			_range = _skill.range;
			_targetAI = data.ai_target;
		}
		
		override public function realize():void
		{
			var targets:Dict = GameUtil.getArmys(_atkVO.camp);
			var dict:Dictionary = targets.dict;
			var atker:CharacterBase = _atkAI.character;
			var atkVO:CharacterVO = _atkVO;
			
			if(_targetAI && _targetAI._model){
				
				var target:CharacterBase = _targetAI.character;
				var charVO:CharacterVO = _targetAI._vo;
				var model_target:CharacterModel = _targetAI._model;
				var camp:int = charVO.camp;
				
				if(GameUtil.isArmyAlive(camp, target.uid))
				{
					charVO.hp = Math.min(charVO.hp + _skill.buff_hp, charVO.hp_max);
					model_target.setVO(charVO);
					
					createEft(_skill.eff_up_enimy, 60, 
						_atkVO.scaleX, _targetAI.character.container_top);
					
					_targetAI.refreshHeroHP();
				}
				
				
				
			}
			
			 
			
			this.clear();
		}
		
		override public function clear():void
		{
			
			super.clear();
			
		}
	}
}