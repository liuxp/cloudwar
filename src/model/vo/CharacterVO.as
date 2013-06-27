package model.vo
{
	import utils.ObjToModelUtil;

	public class CharacterVO extends SheetVO
	{
		//固有属性
		public var camp : int;
		public var dir :String;
		public var scaleX:int;
		//转换的属性
		public var gid:String;//武将id
		public var res:String; //素材名称
		public var armyType:String;//兵种属性
		public var speed:Number; //移动速度
		public var range_guard:int ;//警戒范围
		public var range_atk:int;//攻击范围
 		public var hp:int;//血量
		public var hp_max:int;
		public var atk:int;//攻击力
		public var def:int;
		public var lv:int;
		public var cost:int;//生产消耗
		public var cd_create:int; //生产cd
		public var cd_atk:int;//攻击cd
		public var cd_skill:int;
		public var name:String;
		public var step:int;//等阶
		
		public var skillId_normal:String;//技能
		public var skillId_active:Array;//技能
		public var skillId_super:String;//技能
		
		public var skill_normal:SkillVO;//技能
		public var skill_active:Array;//技能
		public var skill_super:SkillVO;//技能
		
		public var storySkillId:String;//剧情初始技能
		
		public var init_speed:Number=0;
		public var init_delay:uint = 20;
		public var init_camp:int;
		public var init_ai:String;
		
		public var init_range_atk:int;
		public var init_cd_atk:int = 10;
		
		/***/
		public var invincible:Boolean;//是否无敌
		public var boss:int;
		public var cd_reborn:int;//复活cd
		public var cd_alive:int;//存活cd
 
		public function updateSkill(skillLv:int):void
		{
			ObjToModelUtil.charSkillCfgToVO(this, skillLv);
		}
		
		public function CharacterVO()
		{
			
		}
	}
}