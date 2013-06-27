package model.config.sheet
{
	public class GameMaterial
	{
		//config
		/*[Embed(source="assets/xml/configs/army.txt", mimeType='application/octet-stream')]
		public static var army:Class;
		[Embed(source="assets/xml/configs/mession.txt", mimeType='application/octet-stream')]
		public static var mession:Class;
		[Embed(source="assets/xml/configs/story.txt", mimeType='application/octet-stream')]
		public static var story:Class;
		[Embed(source="assets/xml/configs/skill.txt", mimeType='application/octet-stream')]
		public static var skill:Class;
		[Embed(source="assets/xml/configs/bullet.txt", mimeType='application/octet-stream')]
		public static var bullet:Class;
		[Embed(source="assets/xml/configs/follow.txt", mimeType='application/octet-stream')]
		public static var follow:Class;
		[Embed(source="assets/xml/configs/equip.txt", mimeType='application/octet-stream')]
		public static var equip:Class;
		[Embed(source="assets/xml/configs/chapter.txt", mimeType='application/octet-stream')]
		public static var chapter:Class;*/
		//UI
		[Embed(source="assets/swf/asset.swf", symbol="Alert")]
		public static var Alert:Class;
		
		//地图
		
		[Embed(source="assets/swf/asset.swf", symbol="map_1")]
		public static var map_1:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="map_2")]
		public static var map_2:Class;
		[Embed(source="assets/swf/asset.swf", symbol="map_3")]
		public static var map_3:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="map_4")]
		public static var map_4:Class;
	 			
		//大場景 素材
		[Embed(source="assets/swf/asset.swf", symbol="UI_main_a")]
		public static var UI_main_a:Class;		
		//
		[Embed(source="assets/swf/asset.swf", symbol="PKSkillUI")]
		public static var PKSkillUI:Class;//游戏战斗 底部技能UI
		[Embed(source="assets/swf/asset.swf", symbol="HeroSkill")]
		public static var HeroSkill:Class;
		[Embed(source="assets/swf/asset.swf", symbol="ArmyProduct")]
		public static var ArmyProduct:Class;
		[Embed(source="assets/swf/asset.swf", symbol="PKMessionUI")]
		public static var PKMessionUI:Class;//游戏战斗 上部属性UI
		[Embed(source="assets/swf/asset.swf", symbol="WaveRwdUI")]
		public static var WaveRwdUI:Class;//波结算UI
		
		[Embed(source="assets/swf/asset.swf", symbol="WinUI")]
		public static var WinUI:Class;//波结算UI
		[Embed(source="assets/swf/asset.swf", symbol="FailUI")]
		public static var FailUI:Class;//波结算UI
		//button
		[Embed(source="assets/swf/asset.swf", symbol="Btn_Battle")]
		public static var Btn_Battle:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="Btn_Skip")]
		public static var Btn_Skip:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Btn_Game")]
		public static var Btn_Game:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Btn_Sys")]
		public static var Btn_Sys:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Btn_Back")]
		public static var Btn_Back:Class;	
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_Easy")]
		//public static var Btn_Easy:Class;		
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_Normal")]
		//public static var Btn_Normal:Class;	
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_Hard")]
		//public static var Btn_Hard:Class;
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_EnemyInfo")]
		//public static var Btn_EnemyInfo:Class;			
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_Equip")]
		//public static var Btn_Equip:Class;		
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_Skill")]
		//public static var Btn_Skill:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="Btn_cost")]
		public static var Btn_cost:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="Btn_startGame")]
		public static var Btn_startGame:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="Btn_AddFri")]
		public static var Btn_AddFri:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="Btn_myFriend")]
		public static var Btn_myFriend:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="Btn_tavern")]
		public static var Btn_tavern:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="Btn_forge")]
		public static var Btn_forge:Class;		
		//[Embed(source="assets/swf/asset.swf", symbol="Btn_aid")]
		//public static var Btn_aid:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="Btn_forge_friend")]
		public static var Btn_forge_friend:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Btn_forge_equip")]
		public static var Btn_forge_equip:Class;		
		
		//UI 位圖素材 （大章節）
		[Embed(source="assets/swf/asset.swf", symbol="chapter1")]
		public static var chapter1:Class;
		[Embed(source="assets/swf/asset.swf", symbol="chapter2")]
		public static var chapter2:Class;
		[Embed(source="assets/swf/asset.swf", symbol="chapter3")]
		public static var chapter3:Class;
		[Embed(source="assets/swf/asset.swf", symbol="chapter4")]
		public static var chapter4:Class;
		[Embed(source="assets/swf/asset.swf", symbol="chapter5")]
		public static var chapter5:Class;
		
		[Embed(source="assets/swf/asset.swf", symbol="LevelStar")]
		public static var LevelStar:Class;	
		[Embed(source="assets/swf/asset.swf", symbol="LevelEmpty")]
		public static var LevelEmpty:Class;
		
		[Embed(source="assets/swf/asset.swf", symbol="vs")]
		public static var vs:Class;
 
		//每章節 關卡 素材UI
		[Embed(source="assets/swf/asset.swf", symbol="Mis_Fail")]
		public static var Mis_Fail:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Mis_Pass")]
		public static var Mis_Pass:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Mis_Lock")]
		public static var Mis_Lock:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Mis_Perfect")]
		public static var Mis_Perfect:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Mis_Challenge")]
		public static var Mis_Challenge:Class;
		//战前准备
		[Embed(source="assets/swf/asset.swf", symbol="DisposeUI")]
		public static var DisposeUI:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Friend")]
		public static var Dispose_Friend:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Skill")]
		public static var Dispose_Skill:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Troop")]
		public static var Dispose_Troop:Class;
		
		//<!-- 战前准备标题 -->
		[Embed(source="assets/swf/asset.swf", symbol="Title_DisposeFriend")]
		public static var Title_DisposeFriend:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Title_DisposeSkill")]
		public static var Title_DisposeSkill:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Title_DisposeTroop")]
		public static var Title_DisposeTroop:Class;
		
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Friend_Title")]
		public static var Dispose_Friend_Title:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Skill_Title")]
		public static var Dispose_Skill_Title:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Dispose_Troop_Title")]
		public static var Dispose_Troop_Title:Class;
		
			
		//游戏结果 UI
		[Embed(source="assets/swf/asset.swf", symbol="UI_Game_Result_True")]
		public static var UI_Game_Result_True:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="UI_Game_Result_False")]
		public static var UI_Game_Result_False:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="UI_Game_Result_Award")]
		public static var UI_Game_Result_Award:Class;		
		//系统 设置
		[Embed(source="assets/swf/asset.swf", symbol="UI_Game_Sys_Playing")]
		public static var UI_Game_Sys_Playing:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="UI_Game_Sys_Normal")]
		public static var UI_Game_Sys_Normal:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="UI_Radio_Sound")]
		public static var UI_Radio_Sound:Class;		
		[Embed(source="assets/swf/asset.swf", symbol="UI_Radio_Music")]
		public static var UI_Radio_Music:Class;		
 		
		//大本营
		[Embed(source="assets/swf/asset.swf", symbol="CampUI")]
		public static var CampUI:Class;
		//大本营标题
		[Embed(source="assets/swf/asset.swf", symbol="Camp_Titles")]
		public static var Camp_Titles:Class;

		//装备强化
		[Embed(source="assets/swf/asset.swf", symbol="EquipStrengthUI")]
		public static var EquipStrengthUI:Class;
		//装备合成
		[Embed(source="assets/swf/asset.swf", symbol="EquipComposeUI")]
		public static var EquipComposeUI:Class;
		//装备更换
		[Embed(source="assets/swf/asset.swf", symbol="EquipSelectUI")]
		public static var EquipSelectUI:Class;
		//装备信息
		[Embed(source="assets/swf/asset.swf", symbol="EquipIntro")]
		public static var EquipIntro:Class;
		//英雄更换
		[Embed(source="assets/swf/asset.swf", symbol="HeroSelectUI")]
		public static var HeroSelectUI:Class;
		//商店
		[Embed(source="assets/swf/asset.swf", symbol="StoreSoldUI")]
		public static var StoreSoldUI:Class;
		//商店
		[Embed(source="assets/swf/asset.swf", symbol="StoreBuyUI")]
		public static var StoreBuyUI:Class;
		//浏览技能
		[Embed(source="assets/swf/asset.swf", symbol="SkillBrowseUI")]
		public static var SkillBrowseUI:Class;
		//浏览兵种
		[Embed(source="assets/swf/asset.swf", symbol="ArmyBrowseUI")]
		public static var ArmyBrowseUI:Class;
		//关卡选择
		[Embed(source="assets/swf/asset.swf", symbol="MissionSelectUI")]
		public static var MissionSelectUI:Class;
		
		//粮草
		[Embed(source="assets/swf/asset.swf", symbol="FoodUI")]
		public static var FoodUI:Class;
		//拼酒
		[Embed(source="assets/swf/asset.swf", symbol="DrunkUI")]
		public static var DrunkUI:Class;
		//对话框
		[Embed(source="assets/swf/asset.swf", symbol="DialogUI")]
		public static var DialogUI:Class;
		//对话框
		[Embed(source="assets/swf/asset.swf", symbol="TalkBubbleUI")]
		public static var TalkBubbleUI:Class;
		//气力
		[Embed(source="assets/swf/asset.swf", symbol="EnergyUI")]
		public static var EnergyUI:Class;
 
		//英雄属性条
		[Embed(source="assets/swf/asset.swf", symbol="Bar_HeroAttr")]
		public static var Bar_HeroAttr:Class;
		//英雄属性
		[Embed(source="assets/swf/asset.swf", symbol="HeroAttrUI")]
		public static var HeroAttrUI:Class;
		
		//9宫格
		[Embed(source="assets/swf/asset.swf", symbol="Scale9_Blue")]
		public static var Scale9_Blue:Class;
		[Embed(source="assets/swf/asset.swf", symbol="Scale9_Brown")]
		public static var Scale9_Brown:Class;
		[Embed(source="assets/swf/asset.swf", symbol="EquipBg")]
		public static var EquipBg:Class;
		
		//--------------------------------------------------
		//--------------------------------------------------
		//----------------------图标----------------------------
		//人物头象 N_hero
		[Embed(source="assets/swf/icon.swf", symbol="S_hero")]
		public static var S_hero:Class;        
		[Embed(source="assets/swf/icon.swf", symbol="L_hero")]
		public static var L_hero:Class;		
		//技能图标
		[Embed(source="assets/swf/icon.swf", symbol="skill_icon")]
		public static var skill_icon:Class;
		//技能图标
		[Embed(source="assets/swf/icon.swf", symbol="equip_icon")]
		public static var equip_icon:Class;
		//位图序列//////////////////////////////////////////////////////////////
		
		//人物
	
		
		
		
		//特效
		//打击
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_WN_step1_skill01")]
		public static var hit_up_Shu_WN_step1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_WD_step1_skill01")]
		public static var hit_up_Shu_WD_step1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_PC_step1_skill01")]
		public static var hit_up_Shu_PC_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_JS_step1_skill01")]
		public static var hit_up_Shu_JS_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_GB_step1_skill01")]
		public static var hit_up_Shu_GB_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_GB_step1_attack01")]
		public static var hit_up_Shu_GB_step1_attack01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_DS_step1_skill01")]
		public static var hit_up_Shu_DS_step1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_DB_step1_attack01")]
		public static var hit_up_Shu_DB_step1_attack01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="hit_up_Shu_CK_step1_skill01")]
		public static var hit_up_Shu_CK_step1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="hit_down_Shu_YX1_skill01")]
		public static var hit_down_Shu_YX1_skill01:Class;
		//技能
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_attack01")]
		public static var effect_up_Shu_YX1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill01")]
		public static var effect_up_Shu_YX1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill02")]
		public static var effect_up_Shu_YX1_skill02:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill03")]
		public static var effect_up_Shu_YX1_skill03:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill04")]
		public static var effect_up_Shu_YX1_skill04:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill05")]
		public static var effect_up_Shu_YX1_skill05:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill06")]
		public static var effect_up_Shu_YX1_skill06:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_down_Shu_YX1_skill07")]
		public static var effect_down_Shu_YX1_skill07:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_YX1_skill08")]
		public static var effect_up_Shu_YX1_skill08:Class;
		
		//武将
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ1_attack01")]
		public static var effect_up_Shu_WJ1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ2_attack01")]
		public static var effect_up_Shu_WJ2_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ3_attack01")]
		public static var effect_up_Shu_WJ3_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ4_attack01")]
		public static var effect_up_Shu_WJ4_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ5_attack01")]
		public static var effect_up_Shu_WJ5_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WJ6_attack01")]
		public static var effect_up_Shu_WJ6_attack01:Class;
		
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WD_step1_attack01")]
		public static var effect_up_Shu_WD_step1_attack01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_WD_step1_skill01")]
		public static var effect_up_Shu_WD_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_QI_step1_attack01")]
		public static var effect_up_Shu_QI_step1_attack01:Class; 
		
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_QB_step1_attack01")]
		public static var effect_up_Shu_QB_step1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_QB_step1_skill01")]
		public static var effect_up_Shu_QB_step1_skill01:Class;
		
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_DB_step1_attack01")]
		public static var effect_up_Shu_DB_step1_attack01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_DB_step1_skill01")]
		public static var effect_up_Shu_DB_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_DS_step1_skill01")]
		public static var effect_up_Shu_DS_step1_skill01:Class; 
		
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_CK_step1_attack01")]
		public static var effect_up_Shu_CK_step1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Shu_CK_step1_skill01")]
		public static var effect_up_Shu_CK_step1_skill01:Class;
		
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Wei_WJ1_attack01")]
		public static var effect_up_Wei_WJ1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Wei_WJ1_skill01")]
		public static var effect_up_Wei_WJ1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Wei_WJ1_skill02")]
		public static var effect_up_Wei_WJ1_skill02:Class;
		[Embed(source="assets/swf/effect.swf", symbol="effect_up_Wei_WJ2_attack01")]
		public static var effect_up_Wei_WJ2_attack01:Class;
		
		
		[Embed(source="assets/swf/effect.swf", symbol="bullet_Shu_PC_step1_skill01")]
		public static var bullet_Shu_PC_step1_skill01:Class; 
		[Embed(source="assets/swf/effect.swf", symbol="bullet_Shu_GB_step1_attack01")]
		public static var bullet_Shu_GB_step1_attack01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="bullet_Shu_WD_step1_skill01")]
		public static var bullet_Shu_WD_step1_skill01:Class;
		[Embed(source="assets/swf/effect.swf", symbol="bullet_Shu_GB_step1_skill01")]
		public static var bullet_Shu_GB_step1_skill01:Class;
		//UI特效
		[Embed(source="assets/swf/effect_UI.swf", symbol="effect_start")]
		public static var effect_start:Class;
		[Embed(source="assets/swf/effect_UI.swf", symbol="effect_selected")]
		public static var effect_selected:Class;
		
		[Embed(source="assets/swf/effect_UI.swf", symbol="camp_army")]
		public static var camp_army:Class;
		[Embed(source="assets/swf/effect_UI.swf", symbol="camp_equip")]
		public static var camp_equip:Class;
		[Embed(source="assets/swf/effect_UI.swf", symbol="camp_friend")]
		public static var camp_friend:Class;
		[Embed(source="assets/swf/effect_UI.swf", symbol="camp_store")]
		public static var camp_store:Class;
		[Embed(source="assets/swf/effect_UI.swf", symbol="camp_mission")]
		public static var camp_mission:Class;
	}
}