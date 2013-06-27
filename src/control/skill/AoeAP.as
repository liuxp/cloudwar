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
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	/**
	 *AOE效果 
	 * @author Administrator
	 * 
	 */	
	public class AoeAP extends SkillBase
	{

		private var _range:int = 200;
		
		public function AoeAP(data:Object)
		{
			super(data);
			_range = _params[1];
		}
		
		override public function realize():void
		{
			var targets:Dict = GameUtil.getSearchTargets(_hero.camp);
			var atker:CharacterBase = GameUtil.getCharacterById(_hero.gid);
			var atkVO:CharacterVO = GameUtil.getCharVOByViewId(atker.uid);
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
						charVO.hp -= atkVO.atk * _params[0];    
						model_target.setVO(charVO);
						meditor_target.ai.injured();
						
						
						
					}
					
					
					
					
				}
				
			}
			
			this.done();
			
		}
		
		
	}
}