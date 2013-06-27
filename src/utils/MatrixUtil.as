package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * 位图矩阵变换
	 * leo 2011/10/25*/
	public class MatrixUtil
	{
		public function MatrixUtil()
		{
		}
		//向右旋转90度
		public static function rotateRight(bmpData:BitmapData):BitmapData
		{
			var mc:Matrix = new Matrix();
			mc.rotate(Math.PI/2);
			mc.translate(bmpData.height,0);
			var bmpData:BitmapData = new BitmapData(bmpData.height, bmpData.width,true,0);
			bmpData.draw(bmpData,mc);
			return bmpData;
		}
		//向左旋转90度
		public static  function rotateLeft(bmpData:BitmapData):BitmapData
		{
			var mc:Matrix = new Matrix();
			mc.rotate(-Math.PI/2);
			mc.translate(0,bmpData.width);
			var bmpData:BitmapData = new BitmapData(bmpData.height, bmpData.width,true,0);
			bmpData.draw(bmpData,mc);
			return bmpData;
		}
		//水平翻转
		public static  function flipHorizontal(bt:BitmapData):BitmapData
		{
			 
			var bmd:BitmapData = new BitmapData(bt.width, bt.height, true, 0x00000000);
            for (var yy:uint=0; yy<bt.height; yy++) {
                for (var xx:uint=0; xx<bt.width; xx++) {
                    bmd.setPixel32(bt.width-xx-1, yy, bt.getPixel32(xx,yy));
                }
            }
            return bmd;
		}
		//垂直翻转
		public static  function flipVertical(bt:BitmapData):BitmapData
		{
			var bmd:BitmapData = new BitmapData(bt.width, bt.height, true, 0x00000000);
            for (var xx:uint=0; xx<bt.width; xx++) {
                for (var yy:uint=0; yy<bt.height; yy++) {
                    bmd.setPixel32(xx, bt.height-yy-1, bt.getPixel32(xx,yy));
                }
            }
            return bmd;

		}
		//水平翻转
		public static function setFlipHorizontal(dsp:DisplayObject):void
		{
			var mc:Matrix = dsp.transform.matrix;
			mc.a=-1;
			mc.tx=dsp.width+dsp.x;
			dsp.transform.matrix=mc;
		}
		//垂直翻转
		public static function setFlipVertical(dsp:DisplayObject):void
		{
			var mc:Matrix = dsp.transform.matrix;
			mc.d=-1;
			mc.ty=dsp.height+dsp.y;
			dsp.transform.matrix=mc;
		} 
		//得到发光效果
		public static function getGlowFilter(source:BitmapData,color:uint):BitmapData
		{
			var bmt : BitmapData = source.clone();
			var filter:GlowFilter = new GlowFilter(color,1,6,6,3,2);
			bmt.applyFilter(bmt, new Rectangle(0, 0, bmt.width, bmt.height), new Point(0, 0), filter);
			return bmt;
		}
		//是否得到不透明像素
		public static function isGetPixel32(bmt:BitmapData, x:int, y:int):Boolean
		{
			
			var al : uint = bmt.getPixel32(x, y)
			return al>0;
		}
		/**
		 * 显示对象转位图
		 * */
		public static function disObjToBit(_mc:DisplayObject, _vhInt:int = 0):BitmapData {
			var _rec:Rectangle = _mc.getBounds(_mc);
			var _width:int = Math.max(1,_rec.width);
			var _height:int = Math.max(1, _rec.height);
			var _bitmapData:BitmapData = new BitmapData(_width, _height, true, 0x00FFFFFF);
			//_bitmapData.draw(_mc, new Matrix(1, 0, 0, 1, -_rec.x + _vhInt, -_rec.y + _vhInt));
			_bitmapData.draw(_mc);
			return _bitmapData;			
		}
		/**缩放位图*/
		public static function ScaleBitmapdata(bmtSrc:BitmapData, 
												width:Number, 
												height:Number):BitmapData
		{var bm:Bitmap;
			
			var bmt : BitmapData  = new BitmapData(width, height, true, 0x00000000);
			
				var mtx : Matrix = new Matrix();
				var scaleX : Number = Math.min(width / bmtSrc.width , 2);
				var scaleY : Number = Math.min(height / bmtSrc.height , 2);
				mtx.scale(scaleX,scaleY);
				
				bmt.draw(bmtSrc,mtx,null,null,null,true);
				
				return bmt;
		}
		
		public static function createMaskBitmap(w:Number, h:Number, 
												color:uint=0x00ffffff):Bitmap
		{
			var bm : Bitmap = new Bitmap(new BitmapData(w,h, true, color));
			return bm;
		}
	}
}