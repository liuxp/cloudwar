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
	 *投掷
	 * @author Administrator
	 * 
	 */	
	public class Hurl extends SkillBase
	{
		private var _range:int = 50;
		private var _atkAI:CharacterAI;
		private var _atkVO:CharacterVO;
		
		public function Hurl(data:Object)
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
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				var targetAI:CharacterAI = meditor_target.ai;
				if(_skill.bulletId)
				{
					var bullet_cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Bullet, _skill.bulletId);
					var bullet_vo:BulletVO = ObjToModelUtil.ObjtoBullet(bullet_cfg);
					
					CommandManager.createBullet({atker:_atkAI.character, 
						target:i, 
						bullet:bullet_vo, 
						track:bullet_vo.type,
						effect:_skill.eff_up_enimy})
						
						return;
					
				}else if(meditor_target && meditor_target.ai){
					
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						charVO.hp -= atkVO.atk ;
						meditor_target.ai.injured();
						model_target.setVO(charVO);
						
						createEft(_skill.eff_up_enimy, 60, 
							_atkVO.scaleX, targetAI.character.container_top);
					}
					
					if(--num< 0) break;
					
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