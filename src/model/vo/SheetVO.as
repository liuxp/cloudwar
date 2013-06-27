package model.vo
{
	public class SheetVO
	{
		public var assets:Vector.<XML>;
		public var state:String;
		public var frame:int = -1;
		public var toalFrame:int;
		public var scale:Number =1;// 0.5;//Math.min(1, Math.random() + 0.6);
		public var delay:int = 20;
		
		public function SheetVO()
		{
			
		}
		
	}
}