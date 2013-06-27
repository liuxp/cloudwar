package model.config
{
	public class GameCfg
	{
		
		
		public static var gateWay : String = 'http://192.168.0.180:8089/gateway/'; //网关
		
		public static var version :String = '1.0';
		
		public static var url_swf :String = 'assets/swf/';
		public static var url_xml :String = 'assets/xml/';
		public static var url_sound :String = 'assets/sound/';
		
		public static var stageWidth:uint = 800//960;
		public static var stageHeight:uint = 480//640;
		
		public static var PkScene_Top:uint = 170;
        public static const TOUCH_DRAG_DROP_TIME:uint = 500;//滑屏間隔時間標準
		
		public var config:Object = {};
		
		public function GameCfg()
		{
			
		}
		 
	}
	
	
}