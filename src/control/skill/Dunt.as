
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
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *重击
	 * @author Administrator
	 * 
	 */	
	public class Dunt extends SkillBase
	{
		
		private var _range:int = 50;
		private var _atkAI:CharacterAI;
		private var _atkVO:CharacterVO;
		
		public function Dunt(data:Object)
		{
			super(data);
			_atkAI = data.ai_atk;
			_atkVO = _atkAI._vo;
			_range = _skill.range;
		}
		
		override public function realize():void 
		{
			var targets:Dict = GameUtil.getSearchTargets(_atkVO.camp);
			var dict:Dictionary = targets.dict;
			var atker:CharacterBase = _atkAI.character;
			var atkVO:CharacterVO = _atkVO;
			var num:int = _skill.objNum;
			for each(var i:CharacterBase in dict)
			{
				var len:int = GlobalUtil.getDistance(i.x,i.y, atker.x, atker.y);
				if(len > _range) continue;
				//trace('beat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				var targetAI:CharacterAI = meditor_target.ai;
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						charVO.hp -= this._skill.damage ;
						model_target.setVO(charVO);
						meditor_target.ai.injured();
						
						createEft(_skill.eff_up_enimy, 60, 
							_atkVO.scaleX, targetAI.character.container_temp);
					}
					
					if(--num<= 0) break;
					
				}
				
				
			}
			
			this.clear();
		}
		
		override public function clear():void
		{
			this.done();
			super.clear();
			
		}
		
	}
}