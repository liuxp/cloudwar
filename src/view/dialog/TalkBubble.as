
package view.dialog
{
	import com.greensock.TweenLite;
	
	import component.ScaleBitmap;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import utils.TextFieldUtil;
	
	
	/**
	 *
	 * TalkBubble.as class. 
	 * @author Administrator
	 * Created 2013-4-24 上午10:45:27
	 */ 
	public class TalkBubble extends ViewBase
	{ 
		public var txt:TextField;
		public var panel:BitmapData;
		public var scaleBit:ScaleBitmap;
		private var _dir:int;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function TalkBubble(asset:DisplayObject=null)
		{
			var bm:Bitmap = asset as Bitmap;
			panel = bm.bitmapData ;
			scaleBit = new ScaleBitmap(panel, new Rectangle(42,16,73,28))
			txt = TextFieldUtil.create();
			addChild(scaleBit);
			
			txt.defaultTextFormat = TextFieldUtil.createTextformat(0xffffff,20,'黑体');
			txt.width = 150;
			txt.wordWrap = true;
			txt.multiline = true;
			addChild(txt);
			
			txt.x = 20;
			
			
		} 
		
		public function setDir(dir:int):void
		{
			_dir = dir;
			scaleBit.scaleX = dir;
		}
		
		public function setMsg(value:String):void
		{
			txt.text = value;
			txt.height = txt.textHeight+12;
			this.setLayerOut();
		}
		
		public function setLayerOut():void
		{
			txt.y = - txt.height;
			scaleBit.setSize(txt.width + 20, txt.height + 20);
			scaleBit.scaleX = _dir;
			scaleBit.y = -scaleBit.height+5;
			scaleBit.x = scaleBit.scaleX>0 ? 0 : scaleBit.width+10
			/*this.asset.height = txt.height + 20;
			this.asset.width = txt.width + 30;*/
			
		}
		
	}
	
}