package control.skill
{
	import component.Dict;
	
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
	 *嘲讽 
	 * @author Administrator
	 * 
	 */	
	public class Taunt extends SkillBase
	{

		private var _range:int = 100;
		
		public function Taunt(data:Object)
		{
			super(data);
			_range = this._params[0];
		}
		
		override public function realize():void 
		{
			var targets:Dict = GameUtil.getSearchTargets(_hero.camp);
			var dict:Dictionary = targets.dict;
			var atker:CharacterBase = GameUtil.getCharacterById(_hero.gid);
			
			for each(var i:CharacterBase in dict)
			{
				var len:int = GlobalUtil.getDistance(i.x,i.y, _pos.x, _pos.y);
				if(len > _range) continue;
				
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				
				if(meditor_target && meditor_target.ai)
				{
					
					meditor_target.ai.setTarget(atker, true);
					
					CommandManager.createEffect({type:_effect,
												 container: i
												});
					
					
				}
				
			}
			
			this.done();
		}
		
	}
}