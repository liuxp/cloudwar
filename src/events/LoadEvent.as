package events
{
	import flash.events.Event;
	
	public class LoadEvent extends Event
	{

		public static const LoadError : String = 'loaderror';
		/**同一类多文件加载完毕 */
		public static const LoadMultiFileComplete : String = 'loamutifilecmt';
		/**文件全部加载完毕 */
		public static const LoaAllFileComplete : String = 'loaallfilecmt';
		/**单个文件加载完毕*/
		public static const LoaFileComplete : String = 'loafilecmt';
		public static const LoaFileProgress : String = 'loafileprogress';
		public static const LoadSoundCmt : String = 'loasndcmt';
		
		public var data : Object;
		
		public function LoadEvent(type : String = null, 
									obj : Object = null, 
									bubbles : Boolean=false)
		{
			super(type,bubbles);
			this.data = obj;
		}

	}
}