
package component
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import utils.ColorTransUtil;
	import utils.EffectUtil;
	import utils.GameUtil;
	
	/**
	 *位图溶解效果
	 * Dissolve.as class. 
	 * @author Administrator
	 * Created 2013-5-7 上午9:19:15
	 */ 
	public class Dissolve extends Sprite
	{ 
		
		//黑色  
		private var _topBit:BitmapData;  
		//白色  
		private var _bottomBit:BitmapData;  
		//图  
		private var _topImg:Bitmap;
		private var _bottomImg:Bitmap;
		
		//种子  
		private var _seed:Number;  
		//像素数  
		private var _pixelCount:int = 0;  
		
		private var _topSrc:BitmapData;
		private var _bottomSrc:BitmapData;
		
		private var i:int;
		
		public function Dissolve()  
		{  
			_bottomImg = new Bitmap();  
			addChild(_bottomImg); 
			
			_topImg = new Bitmap();  
			addChild(_topImg);  
			
			
			
			this.addEventListener(MouseEvent.CLICK, onClick)
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.show();
		}
		
		public function setBit(top:BitmapData, bottom:BitmapData):void
		{
			_topSrc = top;
			this._bottomSrc = bottom;
			
			
			
		}
		
		public function show():void
		{
			this._topBit = _topSrc.clone();
			this._bottomBit = _bottomSrc.clone();
			
			_topImg.bitmapData = _topBit;
			_bottomImg.bitmapData = _bottomBit;
			
			_pixelCount = 0;
			_topImg.alpha = 1;
			i=0;
			
			_seed = Math.random() * 1000;  
			//GameUtil.delayExecuteFun(20, render, 0, 'dissolve');
			
		}
		
		private function render():void
		{  
			blur();
			
		}  
		
		private function blur():void
		{
			i+=0.05;
			_topBit.applyFilter(_topBit, _topBit.rect, new Point, new BlurFilter(i,i));
			_topImg.alpha -= 0.01;
			if(_topImg.alpha<=0) GameUtil.deleteDelayFun('dissolve'); 
			
		}
		
		private function pixelDissolve():void
		{
			//每帧取Bitmap的百分之一  
			var numPixelCount:int = (_bottomBit.width * _bottomBit.width) / 100;  
			
			
			_seed = _topBit.pixelDissolve( _bottomBit, _topBit.rect, 
				new Point(0,0), _seed, numPixelCount);
			
			
			
			
			//判断处理是否完成  
			_pixelCount +=numPixelCount;  
			
			if(_pixelCount >(_topBit.width * _topBit.height))
			{  
				GameUtil.deleteDelayFun('dissolve');
			} 
			
		}
		
		
	}
	
}