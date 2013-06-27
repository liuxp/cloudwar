
package view.character
{
	 /**
	 * 位图序列动画对象
	 * */
	
	 
	
	import control.view.sheet.SheetSpriteMeditor;
	
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	 
	
	public class SheetSprite extends ViewBase
	{
		 

		public var bitmap : Bitmap;
 
		//public var bitLis : Vector.<BitmapData>;
		
		public var types:String;
		 
		
		public function SheetSprite(type : String=null)
		{
			 super();
			 
			this.types = type;
			
			init();
		}
		
		override protected function init():void
		{

			initView();
			

		}
		
		
		protected function initView():void
		{
			initBitmap();
		}
		
		protected function initBitmap():void
		{
			bitmap = new Bitmap();
			addChild(bitmap);
		}
		
		
		
	}
}