package utils
{
	import manager.ModelLocator;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.*;
	
	
	public class ObjToModelUtil
	{
		
		public static const fmt_ObjToBuild : String = 'ObjToBuild';
		public static const fmt_ObjToBuildBit : String = 'ObjToBuildBit';
		public static const fmt_ObjToBarrackData : String = 'ObjToBarrackData';
		public static const fmt_ObjToTavernData : String = 'ObjToTavernData';
		public static const fmt_ObjToStageBuild : String = 'ObjToStageBuild';
		public static const fmt_ObjToStageHero : String = 'ObjToStageHero';
		public static const fmt_ObjToFriend : String = 'ObjToFriend';
		
		 
		
		
		private static var _ML : ModelLocator = ModelLocator.getInstance();
		 
		public function ObjToModelUtil()
		{
			throw Error('can not instantiate')
		}
		
		public static function ListFormat(list:Array , method:String, ...arg):Vector
		{
			var arrColl : Vector;
			if(!list) return arrColl;
			
			arrColl = new Vector;
			
			for(var i : uint = 0,len:uint=list.length; i <len; i++)
			{
				if(arg)
				{
					arrColl.addItem(ObjToModelUtil[method](list[i],arg[0]));
				}else{
					arrColl.addItem(ObjToModelUtil[method](list[i]));
				}
			}
			return arrColl;
		}
		
		/**用户*/
		public static function ObjToUser(obj:Object):UserVO
		{
			var mod : UserVO = new UserVO();
			mod.name = obj.name?obj.name:'no name';
			mod.country = obj.country?obj.country:1;
			mod.exp = obj.exp?obj.exp:0;
			mod.gold = obj.gold?obj.gold:0;
			mod.coin = obj.coin?obj.coin:0;
//			mod.heros = obj.heros?obj.heros:[];
		
			return mod;
		}
 
		 
		/**武将*/
		public static function ObjToGeneral(obj:Object, lv:int=1):GeneralVO
		{
			var mod:GeneralVO = new GeneralVO;
			mod.id = obj.id;
			mod.lv = lv;
			mod.cost  = Math.floor(lv/10+2)*obj.ProduceCostConstant;
			mod.name = obj.UnitName;
			mod.cd_create = obj.ProduceTime;
			
			mod.energy_max = lv*2;
			mod.cd_energy = Math.floor(lv/10);
			mod.food_max = obj.FP;
			mod.cd_food = obj.FPr;
			mod.skillId_active = obj.ActiveSkillID;
			mod.exp_max = (lv-49)*(lv-49) * 1000;
			mod.exp = obj.exp;
			
			return mod;
		}
		/**Skill*/
		public static function ObjToSkill(obj:Object, lv:int=1):SkillVO
		{
			var mod:SkillVO = new SkillVO;
			mod.id = obj.id;
			mod.lv = lv;
			mod.buff_atk = obj.BuffAttackConstantA + (lv-1) * obj.BuffAttackConstantB;
			mod.buff_def = obj.DefenseConstantA + (lv-1) * obj.DefenseConstantB;
			mod.buff_hp = obj.HPConstantA + (lv-1) * obj.HPConstantB;
			mod.buff_speed = obj.MoveSpeedConstantA + (lv-1) * obj.MoveSpeedConstantB;
			mod.bulletId = obj.BulletID;
			mod.cd = obj.ColddownConstantA + (lv-1) * obj.ColddownConstantB; ;
			mod.charState = obj.SkillAnimation;
			mod.critRate = obj.CriticalConstantA + (lv-1) * obj.CriticalConstantB;
			mod.damage = obj.AttackConstantA + (lv-1) * obj.AttackConstantB;
			mod.debuff = obj.Debuff;
			mod.dmgRate = obj.DamageMagnificationConstantA + (lv-1) * obj.DamageMagnificationConstantB;
			mod.duration = obj.DurationConstantA + (lv-1) * obj.DurationConstantB;
			mod.eff_down_enimy = obj.SkillAnimationEffectHitDown;
			mod.eff_down_self = obj.SkillAnimationEffectDown;
			mod.eff_up_enimy = obj.SkillAnimationEffectHitUp;
			mod.eff_up_self = obj.SkillAnimationEffectUp;
			mod.mp = obj.MPCostConstantA + (lv-1) * obj.MPCostConstantB;
			mod.objNum = obj.NumberOfImpact;
			mod.objType = obj.ObjectType;
			mod.radius = obj.RadiusConstantA + (lv-1) * obj.RadiusConstantB;
			mod.range = obj.Range +  Math.random()*20 + Math.random()*30;
			mod.redamge = obj.RedamageConstantA + (lv-1) * obj.RedamageConstantB;
			mod.skillName = obj.SkillName;
			mod.skillType = obj.SkillType;
			
			return mod;
		}
		/**
		 *关卡 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function ObjtoMession(obj:Object):MessionVO
		{
			var mod:MessionVO = new MessionVO;
			mod.name = obj.name;
			mod.info = obj.info;
			mod.Pkid = obj.Pkid;
			mod.reward = obj.reward;
			mod.pass_by = obj.pass_by;
			mod.boss = obj.boss;
			mod.wall = obj.wall;
			return mod;
		}
		/**
		 *波 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function ObjtoWave(obj:Object):WaveVO
		{
			var mod:WaveVO = new WaveVO;
			mod.id = obj.id;
			/*mod.name = obj.name;
			mod.lv = obj.lv;
			mod.pop_max = obj.pop_max;
			mod.hard_ness = obj.hard_ness;
			mod.boss = obj.boss;
			mod.gift = obj.gift;*/
			mod.formation = obj.formation;
			mod.queue = obj.queue;
			mod.interval = obj.interval;
			
			return mod;
		}
		
		public static function ObjToCharacter(obj:Object,lv:uint=1):CharacterVO
		{
			var mod:CharacterVO = new CharacterVO;
			mod.name = obj.UnitName
			mod.armyType = obj.UnitType
			mod.lv = lv;	
			mod.atk = obj.AttackConstantA + (mod.lv-1) * obj.AttackConstantB;
			mod.def = obj.DefenseConstantA + (mod.lv-1) * obj.DefenseConstantB;
			mod.hp_max = obj.HPConstantA + (mod.lv-1) * obj.HPConstantB;
			mod.hp = mod.hp_max;
			mod.speed = obj.MovePIX;
			mod.range_guard = obj.Guard + Math.random()*20 + Math.random()*30;
			mod.range_atk = obj.AttackRange + Math.random()*20 + Math.random()*30;
			mod.cd_create = obj.ProduceTime;
			mod.cost = obj.ProduceCost;
			mod.step = Math.floor(mod.lv/10)+1;
			mod.gid = obj.id;
			
			mod.skillId_normal = obj.NormalAttackSkillID;
			mod.skillId_active = obj.ActiveSkillID;
			mod.skillId_super = obj.SuperActiveSkillID;
			//mod.scale = obj.Scale;	
			
			mod.res = obj.Res;
			//mod.storySkillId = obj.
			return mod;
		}
		
		public static function charSkillCfgToVO(char:CharacterVO, skillLv:int):CharacterVO
		{
			var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, char.skillId_normal);
			char.skill_normal = ObjToSkill(cfg, skillLv);
			
			char.skill_active = [];
			for each(var i:String in char.skillId_active)
			{
				cfg = GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, i);
				char.skill_active.push(ObjToSkill(cfg, skillLv));
			}
			
			
			
			cfg = GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, char.skillId_super);
			char.skill_super = ObjToSkill(cfg, skillLv);
			
			
			return char;
		}
		
		public static function ObjtoBullet(obj:Object):BulletVO
		{
			var mod:BulletVO = new BulletVO;
			mod.speed = obj.Speed;
			mod.type = obj.FlyType; 
			mod.Res = obj.Res; 	
			
			return mod;
		}
		
		public static function ObjToEquip(obj:Object, lv:int=0):EquipVO
		{
			 
			var mod:EquipVO = new EquipVO;
			mod.id = obj.id;
			mod.armyLv = obj.LevelRequirement;
			mod.lv = lv ? lv : obj.ItemLevel;
			mod.Detail = obj.Detail;
			mod.Name = obj.Name;
			mod.Type = obj.Type;
			mod.Quality = obj.Quality;
			
			mod.atk = obj.AttackConstant;
			mod.def = obj.DefenseConstant;
			mod.hp = obj.HPConstant;
			mod.energy = obj.MPConstant;
			
			return mod;
		}
		
	}
}