package view.component
{
	import core.view.ViewBase;
	
	import flash.display.Shape;
	
	import utils.GlobalUtil;
	
	public class Zone extends ViewBase
	{
		
		private var _ranges:Array;
		private var _shape:Shape;
		
		public function Zone()
		{
			
			super();
			
			init();
		}
		
		public function set ranges(value:Array):void
		{
			_ranges = value;
			draw();
		}

		public function get ranges():Array
		{
			return _ranges;
		}
		
		
		override protected function init():void
		{
			super.init();
			
			_shape = new Shape();
			addChild(_shape);
			
			
		}
		
		private function draw():void
		{
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xff0000, .2);
			_shape.graphics.drawCircle(0,0,_ranges[0]);
			_shape.graphics.drawCircle(0,0,_ranges[1]);
			_shape.graphics.endFill();
		}
		
		public function clear():void
		{
			_shape.graphics.clear();
		}
	}
}