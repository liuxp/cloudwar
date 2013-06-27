package model.config
{
	/**所有兵种的配置信息
	 * leo*/
	public class ArmyConfig
	{
		/**职业*/
		public static const Profession_Walk : String = 'walk'; //近身
		public static const Profession_Archer : String = 'archer'; //远程
		public static const Profession_Magic : String = 'magic'; //魔法
		
		/**兵种类型*/
		public static const Type_Cavalry : String = 'cavalry'; //骑兵
		public static const Type_HorseArcher : String = 'horseArcher'; //骑射
		
		public static const Type_Walk  : String = '盾兵'; //步兵
		public static const Type_Spear : String = '枪兵';
		public static const Type_Archer : String = '弓兵'; //射手
		public static const Type_Warlock : String = '道士'; //术士
		public static const Type_Brainman : String = '军师'; //谋士
		public static const Type_Catapult : String = '炮车'; //投石车
		public static const Type_Dancer : String = '舞娘'; //舞娘
		public static const Type_Fighter:String = '武斗';
		public static const Type_Assassin:String = '刺客';
		
		public static const Type_Monarch : String = '英雄';//君主
		public static const Type_General:String = '武将';
		
 		public static const Type_Wall : String = 'wall';// 城墙
 
 		public static const MonarchID:String = 'Shu_YX1';//君主id
		
		/**兵种状态*/
		public static const State_Mov : String = 'move'; //行走
		public static const State_Atk : String = 'attack01'; //攻击
		public static const State_Def : String = 'defense'; //防御
		public static const State_Injured : String = 'injured'; //受伤
		public static const State_Wait : String = 'wait'; //待命
		public static const State_Die : String = 'die'; //濒死
		public static const State_Burn : String = 'burn';//烧黑
		public static const State_Lightning : String = 'lightning';//雷击
		public static const State_Stuff : String = 'stuff'; /**使用道具*/
		public static const State_Skill : String = 'skill01'; /**使用计谋*/
		public static const State_Dialog : String = 'dialog'; //对话
		public static const State_Appoint : String = 'appoint';/**点将*/
		/**兵种方向*/
		public static const Dir_Left  : String = 'left'; //左上
		public static const Dir_Right  : String = 'right'; //右上
		
		/**兵种颜色*/
		public static const Color_Enemy : String = 'yellow';
		public static const Color_Mine : String = 'blue';
		public static const Color_Friend : String = 'blue';
		
		/**兵种阵型*/
		public static const Camp_Me : int = 2;//可控军队
		public static const Camp_Enemy : int = 1;//敌人
		public static const Camp_Fri : int = 3; //ai友军
		 
		public static const ObjType_Enemy : String = 'enemy';
		public static const ObjType_Self : String = 'self';
		public static const ObjType_Friend : String = 'friend';
	}
}