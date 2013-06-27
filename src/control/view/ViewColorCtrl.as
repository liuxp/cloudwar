package control.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import utils.ColorTransUtil;

	public class ViewColorCtrl
	{

		private var _icon:Bitmap;
		private var _srcBit:BitmapData;
		private var _grayBit:BitmapData;
		
		public function ViewColorCtrl(view:Bitmap, srcBit:BitmapData)
		{
			_icon = view;

			_srcBit = srcBit;
 
		}
		
		private function getGrayBit(srcBit:BitmapData):BitmapData
		{
			var bit:BitmapData = srcBit.clone();
			var bm:Bitmap = new Bitmap(bit);
			ColorTransUtil.SetColor(ColorTransUtil.GrayMatrix, 
				bm);
			var grayBit :BitmapData = new BitmapData(bit.width, bit.height);
			grayBit.draw(bm);
			bit.dispose();
			return grayBit;
		}
		
		
		
		public function setGray():void
		{
			if(!this._grayBit) this._grayBit = this.getGrayBit(this._srcBit);
			_icon.bitmapData = this._grayBit;
		}
		
		public function resume():void
		{
			_icon.bitmapData = this._srcBit;
		}
		
		public function clear():void
		{
			if(_icon.bitmapData) _icon.bitmapData.dispose();
			_icon = null;
			if(_grayBit) _grayBit.dispose();
			_grayBit = null;
			this._srcBit = null;
		}
		
	}
}