package control.skill
{
	import component.Dict;
	
	import control.ai.CharacterAI;
	import control.view.CharacterMeditor;
	
	import core.UID;
	
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
	 *眩晕
	 * @author Administrator
	 * 
	 */	
	public class Giddy implements ISkill
	{
		private var _pos:Point;
		private var _hero:CharacterVO;
		private var _range:int = 200;
		
		
		public function Giddy(hero:CharacterVO, pos:Point)
		{
			_hero = hero;
			_pos = pos;
		}
		
		public function realize():void
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
					meditor_target.ai.wait();
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						meditor_target.SetPlayRate( 4000, 1, StaticConfig.Skill_Shift );
						
						charVO.speed = 0;
						charVO.delay = 4000;
					}
					
				}
				
			}
		}
		
		
	}
	
}