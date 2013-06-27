package model.vo
{
	public class MessionVO extends VOBase
	{
 		
		public var name:String;//关卡名称
		public var info:String;//关卡说明
		public var Pkid:Array;//关卡内包含的PK
		public var pass_by:String;//前置关卡
		//public var gift:Object; //关卡奖励
		public var boss:Array;//['NPC_zhang_jiao',5]
		public var wall:String;
		public var reward:Object;
		public var us:Array = [
			{type:'walk_lv2_blue', pos:[470, 230], speed:3, range_guard:100, range_atk:50},
			{type:'cavalry_lv2_blue', pos:[470,460], speed:3, range_guard:100, range_atk:80},
			{type:'brainman_lv2_blue', pos:[390,280], speed:3, range_guard:200, range_atk:200},
			{type:'archer_lv2_blue', pos:[390,410], speed:3, range_guard:200, range_atk:200},
			{type:'catapult_lv2_blue', pos:[270,345], speed:3, range_guard:500, range_atk:500},
			{type:'dancer_lv2_blue', pos:[190,230], speed:3, range_guard:100, range_atk:80},
			{type:'dancer_lv2_blue', pos:[190,460], speed:3,  range_guard:200, range_atk:200},
			
			{type:'wall', pos:[0, 520]}
		]
		
		public var enemies:Array = [
			{type:'cavalry_lv2_yellow', pos:[1000, 400], speed:3, range_guard:100, range_atk:50},
			{type:'walk_lv2_yellow', pos:[1000, 250], speed:2,  range_guard:100, range_atk:50},
			{type:'brainman_lv2_yellow', pos:[1000, 300], speed:2, range_guard:100, range_atk:50},
			{type:'catapult_lv2_yellow', pos:[1000, 200], speed:1,  range_guard:200, range_atk:200},
			{type:'archer_lv2_yellow', pos:[1000, 450], speed:1,  range_guard:200, range_atk:200},
			{type:'dancer_lv2_yellow', pos:[1000, 400], speed:2, range_guard:100, range_atk:40}
			/*,  
			{type:'cavalry_lv2_yellow', pos:[0, 400], speed:3, range:100},
			{type:'catapult_lv2_yellow', pos:[0, 400], speed:1, range:200},
			{type:'walk_lv2_yellow', pos:[0, 430], speed:3, range:100},
			{type:'archer_lv2_yellow', pos:[0, 440], speed:3, range:200},
			{type:'catapult_lv2_yellow', pos:[0, 300], speed:1, range:200}
			,
			{type:'cavalry_lv2_yellow', pos:[0, 400], speed:3, range:100},
			{type:'catapult_lv2_yellow', pos:[0, 400], speed:1, range:200},
			{type:'walk_lv2_yellow', pos:[0, 430], speed:3, range:100},
			{type:'archer_lv2_yellow', pos:[0, 440], speed:3, range:200},
			{type:'catapult_lv2_yellow', pos:[0, 300], speed:1, range:200}*/
		]
			
		public function MessionVO()
		{
			
		}

	}
}