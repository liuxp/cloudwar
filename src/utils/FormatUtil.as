package utils
{

	
	/**格式转换工具类
	 * leo*/
	public class FormatUtil
	{
		
		public function FormatUtil()
		{
		}
		
		/**日期格式字符转换为时间类
		 * @param formateStr 日期格式
		 * @return*/
		public static function StrToDate(formateStr : String = '2012-08-29 13:43:00'):Date
		{
			var infos : Array = formateStr.split(' ');
			var dates : Array = infos[0].split('-');
			var times : Array = infos[1].split(':');
			
			return new Date(int(dates[0]), int(dates[1]-1), int(dates[2]),
							int(times[0]), int(times[1]), int(times[2]))
		}
		
		/**时间格式转换
		 * 通过毫秒转换成字符串
		 * @param millSecond 毫秒
		 * @param formateStr 日期格式
		 * @param isCN 是否显示中文
		 * @return*/
		public static function TimeToStr(millSecond:Number, formateStr:String=':',
										 isCN:Boolean=false):String
		{
			var timeList : Array = MillSecondToTimeList(millSecond);
			/**得到小时分钟秒的值*/
			var hour : String = timeList[0].toString();
			hour = timeList[0]>9 ? hour : '0'+ hour;
			var minite : String =  timeList[1].toString();
			minite = timeList[1]>9 ? minite : '0'+ minite;
			var second : String = timeList[2].toString();
			second = timeList[2]>9 ? second : '0'+ second;
			
			if(!isCN)
				return hour + formateStr + minite + formateStr + second;
			else 
				return hour + '小时'+ formateStr 
					   + minite + '分钟' + formateStr
					   + second + '秒';
		}
		/**时间格式转换
		 * 通过毫秒转换成对应值的数值
		 * @param millSecond 毫秒
		 * @return*/
		public static function MillSecondToTimeList(millSecond:Number):Array
		{
			var tmp_s : uint = millSecond/1000;
			var second : uint = tmp_s %60;
			var minite : uint = tmp_s / 60 % 60;
			var hour : uint = tmp_s / 3600 % 60;
			return [hour, minite, second];
		}
		/**时间格式转换
		 * 通过毫秒转换成对应值的数值
		 * @param millSecond 毫秒 index所要截取的索引
		 * Peter  2011/11/24
		 * @return*/
		public static function MillSecondToTime(time:*,index:int):String
		{
			var timer_s : String;
			if(time is Number)
			{
				timer_s = FormatUtil.TimeToStr(time);
			}else if(time is String)
			{
				timer_s = time;
			}
			timer_s = timer_s.split(':')[index];
			return timer_s;
		}
		/**时间格式转换
		 * 通过当前时间转换成对应值的数值
		 * @param timer 当前时间
		 * Peter  2011/11/15
		 * @return 秒*/
		public static function TimeStrToMillSecond(timer:String):uint
		{
			var arr : Array = timer.split(':');
			var hour : uint;
			var minite : uint;
			var second : uint;
			if (arr[0]>0) {
				hour=arr[0]*3600;
			}
			if (arr[1]>0) {
				minite=arr[1]*60;
			}
			if (arr[2]>0) {
				second=arr[2];
			}
			return hour + minite + second ;
		}
		
		
		
		
		/**根据类型找到相应的建筑物的类型
		 * Peter 2011/12/8*/
		public static function TypeToBuildType(type:String):String
		{
			switch(type)
			{
				case 'barrack':
					return 'weaponShop';
					break;
			}
			return null;
		}
		
		 
		
		/**英雄品质颜色*/
		public static function HeroQualityToColor(value:int):uint
		{
			/* 白色	0	0x000000
			绿色	1	0x009900
			蓝色	2	0x0033FF
			紫色	3	0x990066
			红色	4	0xFF0000
			橙色	5	0xFF9900 */
			var color : uint;
			switch(value)
			{
				case 0 :
					color = 0xffffff;
					break;
				case 1 :
					color = 0x009900;
					break;
				case 2 :
					color = 0x0033FF;
					break;
				case 3 :
					color = 0x990066;
					break;
				case 4 :
					color = 0xFF0000;
					break;
				case 5 :
					color = 0xFF9900;
					break;					
			}
			
			return color;
			 
		}
		
		
		/**
		 * 根据阵营得到血槽颜色
		 * 我军 00CCFF
			友军 99FF00
			敌军 FF0000
			外框 000000
		 * */
		public static function HeroCampToBloodColor(camp:int):uint
		{
			//0，我方;  1，敌人; 2我方控制的友军  3，ai友军
			switch(camp)
			{
				case 0 :
				case 2 :
					return 0x00CCFF;
				case 1 :
					return 0xff0000;
				default :
					return 0x99FF00;		
					
			}
		}
 
		
		
	}
}