
package events
{
	import core.EventBase;
	
	
	/**
	 *
	 * TileEvent.as class. 
	 * @author Administrator
	 * Created 2013-5-29 下午12:41:49
	 */ 
	public class TileEvent extends EventBase
	{ 
		public static const Select_Item :String = 'select_item';
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function TileEvent(type:String, obj:Object=null, bubbles:Boolean=false)
		{
			super(type, obj, bubbles);
		} 
		
		
		
	}
	
}