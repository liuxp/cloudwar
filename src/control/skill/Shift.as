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
	 *变速 
	 * @author Administrator
	 * 
	 */	
	public class Shift extends SkillOverlay
	{
		 
		public function Shift(data:Object)
		{
			super(data);
		}
		
		override public function realize():void
		{
			 
			
			 
				
				var viewId:String = this._target.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						var speed:int = charVO.speed * this._params[0];
						var count:int = this._params[1]/1000;
						meditor_target.SetPlayRate( 1000, count, StaticConfig.Skill_Cease);
						
						charVO.speed = speed;
						charVO.delay = 1000;
						
						CommandManager.createEffect({type:_effect,
							pos:[0,0], cd:this._params[1], container: this._target});
					}
					
					
					
				}
				
			 
		}
		
	}
	
}