package model.vo
{
	public class WaveVO extends VOBase
	{
		/**
		public var name :String; //(关卡1,utf-8),
		public var lv:uint; //关卡等级，用来算怪物强度
		public var pop_max:uint;   //怪物人口上限
		public var hard_ness:Object; //难度系数
		
		public var boss:String;    //关卡boss，如果没有可以不填
		public var gift:Object;//奖励
		*/
		
		public var formation:Array;  //阵型id
		public var queue:Array;  //怪物队列，随机几率	 
		public var interval:int;//每个阵型之间的间隔
		
		public function WaveVO()
		{
			
		}
	}
}