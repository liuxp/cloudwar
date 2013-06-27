
package component
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	public class RadiusShape extends Shape
	{
		/**
		 * 绘制圆弧矩形
		 * @arthor leo
		 * 
		 * */

		private var _width : int;
		private var _height : int;
		
		private var _topLeftRadius : int ;
		private var _topRightRadius : int ;
		private var _bottomLeftRadius : int ;
		private var _bottomRightRadius : int ;
		

		
		private var _side : uint = 0;
		private var _sideColor : uint ;
		private var _color : uint;
		private var _Alpha : Number = 1;
		private var _fillBmt : BitmapData;
		
		public function RadiusShape():void
		{
			super();
			 
		}
		
		public function Create(w:int,h:int,
								side:uint=2, sidecolor:uint=0,
								cor:uint=0xffffff, alpha:Number=1,
								fillbmt:BitmapData=null,
								topLeft:int=5, topRight:int=5,
								bottomLeft:int=5, bottomRight:int=5):void
		{
			
			this._Alpha = alpha;
			this._color = cor;
			this._fillBmt = fillbmt;
			this._height = h;
			this._width = w;
			this._side = side;
			this._sideColor = sidecolor;
			this._topLeftRadius = topLeft;
			this._topRightRadius = topRight;
			this._bottomLeftRadius = bottomLeft;
			this._bottomRightRadius = bottomRight;
			
			this.draw();
		}						
		override public function set width(value:Number):void
		{
			_width = value; 
			//draw();
		}
		
		
		override public function set height(value:Number):void
		{
			_height = value;
			
			//draw();
		}
		public function Radius(topLeft:int, topRight:int,
									bottomLeft:int, bottomRight:int ):void
		{
			this._topLeftRadius = topLeft;
			this._topRightRadius = topRight;
			this._bottomLeftRadius = bottomLeft;
			this._bottomRightRadius = bottomRight;
			//draw();
		}
		
		public function set SideColor(c : uint):void
		{
			_sideColor = c;
			//draw();
		}
		
		
		public function set Color(color:uint):void
		{
			_color = color;
			//draw();
		}
		public function set Alpha(value:Number):void
		{
			_Alpha = value;
			//draw();
		}
		
		/**描边*/
		public function set Side(n : Number):void
		{
			_side = n;
			//draw();
		}
		
		public function set FillBmt(bmt : BitmapData):void
		{
			this._fillBmt = bmt;
			//draw();
		}
		
		public function draw():void
		{

			this.graphics.clear();
			
			_fillBmt ? this.graphics.beginBitmapFill(this._fillBmt)
					 : this.graphics.beginFill(_color,_Alpha);
			
			if (_side)this.graphics.lineStyle(_side,_sideColor,1);
			
			this.graphics.drawRoundRectComplex( 0, 0, _width, _height,
												_topLeftRadius,
												_topRightRadius,
												_bottomLeftRadius,
												_bottomRightRadius);
			this.graphics.endFill();
			
			
		}
		
		
	}
}