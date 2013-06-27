package component.tracks
{
	import flash.display.DisplayObject;
	/**抛物线*/
	public class Parabola implements ITrack
	{
		private var _view : DisplayObject;
		public var xSpeed:Number;
		public var ySpeed:Number;
		private var t0:Number = 0;
		private var t1:Number = 10;//抛物线高度
		private var g:Number = 0.9;
		private var angel:Number;
		
		public var offsetX : int;
		public var offsetY : int;
		public var posX:Number;
		public var posY:Number;
		
		public function Parabola(_view:DisplayObject, 
								posX:Number, posY:Number, h:int=0)
		{
			this._view = _view;
			this.offsetX = _view.x;
			this.offsetY = _view.y;
			this.posX = posX;
			this.posY = posY;
			var disX:int= posX - offsetX;
			var disY:int = posY - offsetY;
			if(h) t1 = h;
			xSpeed = disX / t1 ;
			ySpeed = ((disY- ((g * t1) * (t1 / 2))) / t1);
			
		}
		
		public function Render():void
		{
			
			
			//trace('pos:', _view.x, '__', _view.y);
			
			t0++;
			
			_view.x = (offsetX + (t0 * xSpeed));
			_view.y = ((offsetY + (t0 * ySpeed)) + (((g * t0) * t0) / 2));
			t0++;
			var Sx:Number = (offsetX + (t0 * xSpeed));
			var Sy:Number = ((offsetY + (t0 * ySpeed)) + (((g * t0) * t0) / 2));
			t0--;
			var dx:Number = Sx - _view.x;
			var dy:Number = Sy - _view.y;
			
			angel = Math.atan2(dy,dx);
			_view.rotation = angel * 180 / Math.PI;
				
		}
		
		public function stopRender():void
		{
			t0 = 0;
			
		}
		
			
	}
}