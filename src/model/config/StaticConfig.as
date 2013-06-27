package model.config
{
	public class StaticConfig
	{
 		/**静态文本里的配置类型*/
		public static const Cfg_General : String = 'hero';
		public static const Cfg_Npc : String = 'npc';
		public static const Cfg_Chapter : String = 'chapter'; 
		public static const Cfg_Mession : String = 'mession';
		public static const Cfg_Equip : String = 'equip';
		public static const Cfg_Wave : String = 'scene';
		public static const Cfg_Deploy : String = 'my_queue';
		public static const Cfg_Stuff : String = 'stuff';
		public static const Cfg_DefSkill : String = 'normal_skill';
		public static const Cfg_Skill : String = 'skill';
		public static const Cfg_Bullet : String = 'bullet';
		public static const Cfg_Other : String = 'system_simple'; 
		public static const Cfg_Other_Restriction : String = 'restriction';
		public static const Cfg_Army : String = 'army';
		public static const Cfg_Story : String = 'story';
		/**技能类型*/
		
		public static const SkillType_Normal : String = 'normal'; 
		public static const SkillType_Active : String = 'active';
		public static const SkillType_Super : String = 'super';
		
		public static const Skill_AoeAP : String = 'AoeAP'; //
		public static const Skill_Ice : String = 'Ice'; //
		public static const Skill_DOT : String = 'DOT'; //
		public static const Skill_Shift : String = 'Shift';
		public static const Skill_Giddy : String = 'Giddy';//晕眩
		public static const Skill_Cease : String = 'Cease';//停止
		public static const Skill_Health : String = 'Health';//治疗
		
		//關卡難度
		public static const LEVEL_DIFF_EASY:String = 'easy';
		public static const LEVEL_DIFF_NORMAL:String = 'normal';
		public static const LEVEL_DIFF_HARD:String = 'hard';
		
		//战斗结果 状态 根据 userVo 来对比
		public static const GAME_RESULT_TRUE:int = 0;
		public static const GAME_RESULT_FALSE:int = -1;
		public static const GAME_RESULT_AWARD:int = 1;
		
		
		//游戏场景
		public static const Scene_Chapter:String = 'scene_chapter';
		public static const Scene_Mission:String = 'scene_mession';
		public static const Scene_PK:String = 'scene_pk';
		public static const Scene_PK_Win:String = 'scene_pk_win';
		public static const Scene_PK_Fail:String = 'scene_pk_fail';
		public static const Scene_Rwd:String = 'scene_rwd';
		public static const Scene_Dialog:String = 'scene_dialog';
		public static const Scene_Entry:String = 'scene_entry';
		public static const Scene_Camp:String = 'CampUI';
		public static const Scene_Dispose:String = 'DisposeUI';//战前配置
		public static const Scene_HeroSkill:String = 'scene_heroskill';//英雄技能
		public static const Scene_Army:String = 'scene_army';//军队
		public static const Scene_EquipSelect:String = 'EquipSelectUI';//装备更换
		public static const Scene_EquipStrength :String = 'EquipStrengthUI';//装备强化
		public static const Scene_EquipCompose :String = 'EquipComposeUI';//装备合成
		public static const Scene_HeroSelect :String = 'HeroSelectUI';//英雄更换
		public static const Scene_StoreSold :String = 'StoreSoldUI';//商店
		public static const Scene_StoreBuy :String = 'StoreBuyUI';//商店
		
		
		/**子弹轨迹*/
		public static const Bullet_Track_Arrow : String = 'Parabola'; //直线
		public static const Bullet_Track_Stone : String = 'line'; //抛物线
		public static const Bullet_Track_Bomb : int = 3; //炸弹
		public static const Bullet_Track_Laser : int = 4; //射线
		
		public static const Game_Setting_Pause : String = 'game_pause'; //游戏暂停
		public static const Game_Setting_Resume : String = 'game_resume'; //游戏恢复
		public static const Game_Setting_PKBreak : String = 'game_pkbreak'; //战斗中止
		public static const Game_Setting_SpeedUp : String = 'game_speedup';//游戏加速
		
		/**国家*/
		public static const Country_Type_LiuBei : int = 1; //刘
		public static const Country_Type_CaoCao : int = 2; //曹
		public static const Country_Type_SunQuan : int = 3; //孙
		
		/**上浮提示*/
		public static const FlyTip_PK_Wave: String = 'flytip_pk_wave'; //波提示
		public static const FlyTip_PK_Reward : String = 'flytip_pk_rwd'; //战斗奖励提示
 
		/**************************************************************************************************/
 		/**奖励*/
 		public static const Rwd_Gold : String = 'Money';
 		public static const Rwd_Exp : String = 'EXP';
		public static const Rwd_Stuff : String = 'Stuff';

		
		/**功能建筑类型*/
		public static const Equip_Type_Weapon : String = 'Weapon';
		public static const Equip_Type_Armor : String = 'Armor';
		public static const Equip_Type_Horse : String = 'Horse';
		public static const Equip_Type_Treasure : String = 'Treasure';
		public static const Equip_Type_Extra : String = 'Extra';

		
		/**道具价格类型*/
		public static const Stuff_PriceType_Gold : String = 'gold';
		public static const Stuff_PriceType_Coin : String = 'coin';
		public static const Stuff_PriceType_Prestige : String = 'prestige';
		
	 
		/**对话类型*/
		public static const Dialog_BattleBefore : String = 'BattleBefore';
		public static const Dialog_BattleIn: String = 'BattleIn';
		public static const Dialog_BattleEnd : String = 'BattleEnd';
		public static const Dialog_BattleWin : String = 'BattleWin';
		public static const Dialog_BattleFail : String = 'BattleFail';
		
		 
		
 		
		/**玩家属性*/
		public static const User_Gold : String = 'gold';
		public static const User_Coin : String = 'coin';
		public static const User_Prestige : String = 'prestige';
		public static const User_Exp : String = 'exp';
		public static const User_Energy : String = 'energy';
		public static const Hero_Exp : String = 'hero_exp';
		
	 	public static const Mission_Mode_Story:String = 'story';
		public static const Mission_Mode_Challenge:String = 'challenge';
		
		public static const WaveMode_Loop : String = 'Loop';
		public static const PKMode_Chase : String = 'chase';//追击模式
		
		
		
	}
}