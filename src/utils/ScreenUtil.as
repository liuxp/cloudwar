package utils 
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	
	 
	
	public class ScreenUtil
	{
		public function ScreenUtil()
		{
		}
		public static function fullScreen(stage:Stage):void
		{
			
			switch(stage.displayState)
			{
				case StageDisplayState.NORMAL :
					stage.displayState = StageDisplayState.FULL_SCREEN;
					break;
				case StageDisplayState.FULL_SCREEN :
					stage.displayState = StageDisplayState.NORMAL;
					break;
				default :
					break;		
			}
		}
		
		public static function align(stage:Stage):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.quality = StageQuality.BEST;
		}
	}
}