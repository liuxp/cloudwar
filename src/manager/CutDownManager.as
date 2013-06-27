package manager
{
	import component.Dict;
	import component.TimeCD;
	import component.TimeLoop;
	
	import core.UID;

	public class CutDownManager
	{
		public static const CD_PK : String = 'cd_pk'; //战斗
		
		private static var _dict:Dict = new Dict;
		
			
		public static function addTime(time:int, timeType:String):void
		{
			var cd:TimeCD = new TimeCD();
			cd.time = time;
			cd.type = timeType;
			
			var tl:TimeLoop = new TimeLoop(1000,0, addFun, null, null, [cd]);
			tl.id = timeType;
			TimeLoopManager.getInstance().addTimeLoop(tl, timeType);
			
			_dict.AddItem(timeType,cd);
		}
		
		public static function stopTime(timeType:String):void
		{
			TimeLoopManager.getInstance().delTimeLoop(timeType);
		}
		
		public static function delTime(timeType:String):void
		{
			if(_dict.isHaveItem(timeType))
			{
				_dict.DeleteItem(timeType);
			}
		}
		
		public static function getTime(timeType:String):int
		{
			if(_dict.isHaveItem(timeType))
			{
				var cd:TimeCD = _dict.getItem(timeType);
				return cd.time;
			}
			return 0;
		}
		
		private static function addFun(cd:TimeCD):void
		{
			cd.time++
		}
	}
}