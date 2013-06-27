package control.skill
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *冰冻效果 
	 * @author Administrator
	 * 
	 */	
	public class Ice extends SkillBase
	{
		private var _pos:Point;
		private var _hero:GeneralVO;
		private var _range:int = 200;
		
		
		public function Ice(hero:GeneralVO, pos:Point)
		{
			_hero = hero;
			_pos = pos;
		}
		
		override public function realize():void
		{
			var targets:Dict = GameUtil.getSearchTargets(_hero.camp);
			var dict:Dictionary = targets.dict;
			
			for each(var i:CharacterBase in dict)
			{
				var len:int = GlobalUtil.getDistance(i.x,i.y, _pos.x, _pos.y);
				if(len > _range) continue;
				
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						
						
						meditor_target.SetPlayRate( 400, 5, StaticConfig.Skill_Shift);
						
						charVO.speed = 0.02;
						charVO.delay = 80;
					}
					
					
					
				}
				
			}
		}
 
	}
	
}