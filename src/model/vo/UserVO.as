package model.vo
{
	import model.config.StaticConfig;

	public class UserVO extends VOBase
	{
		public var name : String;
		public var country : int;
		public var exp : int;
		public var gold : int;
		public var coin : int;
		public var heros:Array;
		public var arms:Array;
		public var skills:Array;
		public var pkSkills:Array;
		public var equips:Object;//我的所有英雄
		public var heroEquips:Object;
 		public var troops:Array;
		public var progress:Object;
		
		public var mChapter:Object; //章节
		public var mMession:Object;//關卡
	 
		public var mFriend:Array//我的好友
 
		public var seleced_chapter:String = '';
		public var seleced_mession:String = '';
		public var game_result:int = 0;//战斗结果（-1 失败，0 普通战斗 1 最后胜利）
		
		
		
		public function UserVO()
		{
		}

	}
}