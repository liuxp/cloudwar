package control.skill
{
	import control.view.CharacterMeditor;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;

	/**
	 *召唤 
	 * @author Administrator
	 * 
	 */	
	public class Summon extends SkillBase
	{
 
		public function Summon(data:Object)
		{
			super(data);
			

		}
		
		override public function realize():void
		{
			createCharacter(getCharVOs(),ArmyConfig.Camp_Me);
			
		}
		
		private function createCharacter(characters:Array, camp:int):void
		{
			
			for(var i:int=0, len:uint=characters.length; i<len; i++)
			{
				var itm:CharacterVO = characters[i];
				itm.camp = camp;
				_pos = _params.pos;
				
				CommandManager.createCharacter(
				{
					vo:itm,
					pos:[_pos.x , _pos.y ],
					container:_ML.game.scene_PK.container_character,
					ai:true,
					cd_alive: _params[1]
				})
 
				//GameUtil.AddArmy(_vo.camp, char);
				
			
				
				
				
			}
			
		}
		
		private function getCharVOs():Array
		{
			/*var arr:Array = [
				'hero_101', 
				'101_huang_gai', 
				'102_cao_zhang',
				'103_xu_shu',
				'104_ma_dai', 
				'100_hua_xiong',
				'117_lu_su',
				'1_cheng_qiang'
			];*/
			var vos:Array = [];
			var arr:Array = _params.heros;
			for(var i :String in arr)
			{
				var id:String = arr[i];
				var cfg : Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, id);
				var ger:CharacterVO = ObjToModelUtil.ObjToCharacter(cfg);
				ger.updateSkill(1);
				ger.range_atk = ger.skill_normal.range + Math.random()*20 + Math.random()*30;
				ger.init_range_atk = ger.range_atk;
				vos.push(ger);
			}
				
			return vos;	

		}
		
		
		
	}
}