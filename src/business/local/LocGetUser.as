package business.local
{
	import business.BSResponder;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.SkillModel;
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.EquipListVO;
	import model.vo.EquipVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.ObjToModelUtil;
	import utils.SearchUtil;
	
	/**
	 *本地数据读取操作 BSResponder
	 * @author Administrator liaoqicai
	 * 
	 */	
	internal class LocGetUser extends BSResponder
	{
		public function LocGetUser()
		{
			super();
		}  
		
		override public function onFault(value:Object):void
		{
			
		}
		
		override public function onResult(value:Object):void
		{ 
			var user:UserVO = new UserVO;
			_ML.user.setVO(user);
			
			var data:Object = _ML.gameCfg.config.user;
			
			_ML.user.vo.arms = data.arms;
			_ML.user.vo.troops = data.troops; 
			_ML.user.vo.skills = data.skills;
 
			
			initArmies(_ML.user.vo.arms); 
			initTroops(_ML.user.vo.troops);
			initSkills(_ML.user.vo.skills);
			
			_ML.user.vo.seleced_mession = data.progress.mission;//'xinye_JQ_1';
			_ML.user.vo.seleced_chapter = data.progress.chapter;//'chapter1';
			
			_ML.user.vo.progress = data.progress.map;
				
			_ML.user.vo.equips = data.equips;
			 
			_ML.user.vo.heroEquips = data.heroEquips; 
			
			initEquips(_ML.user.vo.equips);
			initHeroEquips(_ML.user.vo.heroEquips);
			initFris();
			initMonarch();
		}
		
		private function initMonarch():void
		{
			var vo_ger:GeneralVO = _ML.monarch_general.getVO() as GeneralVO;
			var vo_char:CharacterVO =  GameUtil.createCharVO(ArmyConfig.MonarchID,vo_ger.lv);
			var mod:CharacterModel = new CharacterModel();
			mod.setVO(vo_char);
			_ML.monarch_character = mod;
		}

		
		private function initHeroEquips(heroEquips:Object):void
		{
			var lisVO:EquipListVO = new EquipListVO;
			var equipsVO:EquipListVO = _ML.equips.getVO() as EquipListVO;
			for(var type:String in heroEquips)
			{
				var arr:Array = heroEquips[type];
				var lis:Array = [];
				for each(var id:String in arr)
				{
					var vo:EquipVO = SearchUtil.getItemByVOFromList(
						'id', id, equipsVO[type]) as EquipVO;
					lis.push(vo);
					vo.isWear = true;
				}
				
				lisVO[type] = lis;
			}
			
			_ML.heroEquip.setVO(lisVO);
			
		}
		
		private function initSkills(skills:Array):void
		{
			var len:uint = skills.length
			var lis:Array = [];
			for(var i:int; i<len; i++)
			{
				var cfg :Object= GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, 
					skills[i]);
				
				var vo:SkillVO = ObjToModelUtil.ObjToSkill(cfg, 1);
				
				var mod:SkillModel = new SkillModel(vo);
				mod.setVO(vo);
				lis.push(mod);
			}
			_ML.skills.setVO(lis);
			_ML.pkSkills.setVO(lis.concat());
		}
		
		private function initEquips(equips:Object):void
		{
			var equipsVO:EquipListVO = new EquipListVO;
			
			for(var type:String in equips)
			{
				var itms:Object = equips[type];
				var lis:Array = equipsVO[type];
				
				for(var id:String in itms)
				{
					var num:uint = itms[id].num;
					var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Equip,id);
					
					for(var i:int=0; i<num; i++)
					{
						var vo:EquipVO = ObjToModelUtil.ObjToEquip(cfg);
						lis.push(vo);
					}
				}
			}
			
			_ML.equips.setVO(equipsVO);
		}
		
		private function initTroops(armies:Array):void
		{
			var generals:Array = [];
			for each(var obj:Object in armies)
			{
				var id:String = obj.id;
				var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, id);
				var lv:int = obj.lv;
				var vo:GeneralVO = ObjToModelUtil.ObjToGeneral(cfg, lv);
				var mod:GeneralModel = new GeneralModel();
				mod.setVO(vo);
				
				if(id != ArmyConfig.MonarchID)
				{
					generals.push(mod);
				}else{
					
					_ML.monarch_general = mod;
				}
				
				
				
			}
			
			_ML.pkHeros.setVO(generals);
		}
		
		private function initArmies(armies:Array):void
		{
			var generals:Array = [];
			for each(var obj:Object in armies)
			{
				var id:String = obj.id;
				var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, id);
				var lv:int = obj.lv;
				var vo:GeneralVO = ObjToModelUtil.ObjToGeneral(cfg, lv);
				var mod:GeneralModel = new GeneralModel();
				mod.setVO(vo);
				generals.push(mod);
 
			}
			
			_ML.arms.setVO(generals);
		}
		
		private function initFris():void
		{
			var arr:Array = [];
			for(var i:int; i<10; i++)
			{
				var fir:Object = {name:'玩家'+i};
				arr.push(fir);
			}
			
			_ML.friends.setVO(arr);
		}
		/*{
			Weapon : {
				NorWea_1 : {step:1, num:1},
				NorWea_2 : {step:1, num:2}
			},
		}*/
		
	}
}