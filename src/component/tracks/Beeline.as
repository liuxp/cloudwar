package component.tracks
{
	import flash.display.DisplayObject;
	/**直线*/
	public class Beeline implements ITrack
	{
		private var _view : DisplayObject;
		public var xSpeed:Number=2;
		public var ySpeed:Number=0;

		private var angel:Number;
		private var dir:int;

		public var posX:Number;
		public var posY:Number;
		
		public function Beeline(_view:DisplayObject, 
								 posX:Number, posY:Number)
		{
			this._view = _view;
			this.posX = posX;
			this.posY = posY;
			var disX:int= posX - _view.x;
			var disY:int = posY - _view.y;
			dir *= disX>0 ? 1 : -1;
			angel = Math.atan2(disY,disX);
			_view.rotation = angel * 180 / Math.PI ;
			//trace('angel: ', angel, '_view.rotation: ', _view.rotation)
		}
		
		public function Render():void
		{
			/*_view.x++;
			_view.y++;*/
			
			var disX:int= posX - _view.x;
			var disY:int = posY - _view.y;

			xSpeed =  20;//disX*0.2;
			ySpeed = disY * xSpeed / disX;
 
			if(disX <=2)
			{
				_view.x = this.posX;
				_view.y = this.posY;
				
				return; 
			}
			
			_view.x = _view.x + xSpeed;
			_view.y += ySpeed;
		}
		
		public function stopRender():void
		{
			xSpeed = 0;
			ySpeed = 0;
		}
		
		
	}
}