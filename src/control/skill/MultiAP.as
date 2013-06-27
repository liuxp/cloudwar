package control.skill
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *多点打击
	 * @author Administrator
	 * 
	 */	
	public class MultiAP extends SkillBase
	{
	 
		private var _range:int = 200;
		
		public function MultiAP(data:Object)
		{
			super(data);
		}
		
		
		override public function realize():void
		{
			var targets:Dict = GameUtil.getSearchTargets(_hero.camp);
			var dict:Dictionary = targets.dict;
			var atker:CharacterBase = GameUtil.getCharacterById(_hero.gid);
			var def_skill:Object; 
			
			for each(var i:CharacterBase in dict)
			{
				var len:int = GlobalUtil.getDistance(i.x,i.y, _pos.x, _pos.y);
				if(len > _range) continue;
				
				
				var bullet :String = def_skill.effect[0];
				//生成子弹
				CommandManager.createBullet({atker:atker, target:i, 
					bullet:AssetsCfg.Stone,
					track:def_skill.track});
					
				
				
			}
			
			this.done();
		}
		
	}
}