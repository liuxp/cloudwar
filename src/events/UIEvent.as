package events
{
	import core.EventBase;
	
	public class UIEvent extends EventBase
	{
		public static const SheetBtn_Down : String = 'sheetbtn_down';
		public static const SheetBtn_Up : String = 'sheetbtn_up';
		public static const PANEL_NEXT_CLIP_OVER : String = 'PANEL_NEXT_CLIP_OVER';
		 
		
		 
		public function UIEvent(type:String, obj:Object=null, bubbles:Boolean=false)
		{
			super(type, obj, bubbles);
		}
		
	}
}