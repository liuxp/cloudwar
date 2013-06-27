package model.vo
{
	import core.UID;

	public class VOBase
	{
		public var id:String;
		public var vid:String;
		
		public function VOBase()
		{
			vid = UID.createUID();
		}
	}
}