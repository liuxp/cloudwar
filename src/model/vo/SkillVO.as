package model.vo
{
	public class SkillVO extends VOBase
	{
		public var lv:int=1;//缓存数据
		
		public var cd:Number;//秒
		public var damage:int;
		public var buff_atk:int;
		public var buff_def:int;
		public var skillName:String;
		public var skillType:String;
		public var objType:String;//作用目标类型
		public var objNum:int;//作用目标数量
		public var debuff:String;
		public var range:uint ; //射程
		public var mp:uint;
		public var buff_speed:Number =0;
		public var buff_hp:int;
		public var duration:Number;
		public var redamge:Number;
		public var dmgRate:Number;
		public var radius:int; //作用半径
		public var critRate:Number;
		public var charState:String;//角色动画
		public var eff_up_self:String;
		public var eff_down_self:String;
		public var eff_up_enimy:String;
		public var eff_down_enimy:String;
		public var bulletId:String;
		
		public function SkillVO()
		{
			super();
		}
	}
}