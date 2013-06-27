package component.tracks
{
	import flash.display.DisplayObject;
	/**射线*/
	public class Rays implements ITrack
	{
		private var _view : DisplayObject;
		public var xSpeed:Number=5;
		public var ySpeed:Number=0;
		
		private var dir:int;
		
		public var posX:Number;
		public var posY:Number;
		private var _speed : int;
		
		public function Rays(_view:DisplayObject, 
								posX:Number, posY:Number, speed:int)
		{
			this._view = _view;
			this.posX = posX;
			this.posY = posY;
			var disX:int= posX - _view.x;
			var disY:int = posY - _view.y;
			dir *= disX>0 ? 1 : -1;
			_speed = speed; 
		}
		
		public function Render():void
		{ 
			if(_view.x >= this.posX)
			{
				_view.x = this.posX;
				_view.y = this.posY;
				_speed = 0;
				return; 
			}
			
			_view.x = _view.x + _speed;
 
		}
		
		public function stopRender():void
		{
			xSpeed = 0;
			ySpeed = 0;
		}
		
		
	}
}