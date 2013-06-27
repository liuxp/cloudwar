package utils
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	
	public class ColorTransUtil
	{
		/**
		红，绿，蓝通道的值由如下所示计算方法所决定：
		CODE:
		* redResult = a[0] * srcR + a[1] * srcG + a[2] * srcB + a[3] * srcA + a[4]
		* greenResult = a[5] * srcR + a[6] * srcG + a[7] * srcB + a[8] * srcA + a[9]
		* blueResult = a[10] * srcR + a[11] * srcG + a[12] * srcB + a[13] * srcA + a[14]
		* alphaResult = a[15] * srcR + a[16] * srcG + a[17] * srcB + a[18] * srcA + a[19]
		* 注意每行的源值和结果值都是在0到255的区间内。因此即使各个通道的值小于0或大于255都会被强制到该区间内。
 		* 如果你想在红色通道加100(偏移量),将a[4]设置为100;
 		 * 如果想使绿色通道加倍，将a[6]设为2;
 		 * 如果你要使结果图像中的蓝色与原图的红色数量相等，将a[10]设为1， a[12]设为0 
		* 通过将每个颜色通道与一个值相乘按比例的改变亮度，大于1的增加亮度,小于1减小亮度。
		按照原理，将图像转换为灰度图，你需要将每个通道的部分设为等值。因为有三个通道，你可以将每个通道乘以0.33并将它们相加得到结果值
		* 饱和度-100（即变灰），则为：
			* [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]
			* var matrix:Array = new Array(); 
			* matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]); // red 
			* matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]); // green 
			* matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]); // blue 
			* matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha 
		* 饱和度100：
			* [3.0742,-1.8282,-0.246,0,0,-0.9258,2.1718,-0.246,0,0,-0.9258,-1.8282,3.754,0,0,0,0,0,1,0]
		 * 卷积滤镜（ConvolutionFilter）卷积滤镜可用于对BitmapData对象或显示对象应用一些特殊的图像变形，如模糊、锐化、浮雕、背反、光亮等。
		 **/
		public static const GrayMatrix : Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]; 
		public static const BlueMatrix : Array = [-0.574,1.43,0.143,0,0, 0.4259,0.4259,0.144,0,0, 0.426,1.429,-0.85,0,0, 0,0,0,1,0]
		
		public static const GrayTrans : ColorTransform = new ColorTransform(0,0,0,0.8,10,10,10,1);
		public static const PurpleTrans : ColorTransform = new ColorTransform(1,1,1,1,75,1,136,0);
		public static const DefaultTrans : ColorTransform = new ColorTransform();
		
		public function ColorTransUtil()
		{
			 
		}
		public static function SetColor(matrix : Array, disObj : DisplayObject):void
		{
			if(!disObj) return;
			var colorMxFilter : ColorMatrixFilter = new ColorMatrixFilter;
			colorMxFilter.matrix = matrix;
			disObj.filters = [colorMxFilter];
		}
		public static function ResetColor(disObj : DisplayObject):void
		{
			if(disObj)disObj.filters = null;
		}
		
		public static function SetTransColor(trans : ColorTransform, disObj : DisplayObject):void
		{
			if(!disObj) return;
			
			disObj.transform.colorTransform = trans;
		}
		
		public static function ResetTransColor(disObj : DisplayObject):void
		{
			if(!disObj) return;
			
			disObj.transform.colorTransform = DefaultTrans;
		}
	}
}