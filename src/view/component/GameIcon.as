
package view.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import manager.MaterialManager;
	
	import utils.GameUtil;
	
	
	/**
	 *
	 * Icon.as class. 
	 * @author Administrator
	 * Created 2013-5-25 下午4:05:54
	 */ 
	public class GameIcon extends Bitmap
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function GameIcon(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		} 
		
		public function show(type:String, res:String):void
		{
			//if(this.bitmapData) this.bitmapData.dispose();
			this.bitmapData = GameUtil.getArmyIcon(type, res);
		} 
		
		public function showImg(res:String):void
		{
			if(this.bitmapData) this.bitmapData.dispose();
			var bm:Bitmap = MaterialManager.getInstance().getMapMaterial(res);
			this.bitmapData = bm.bitmapData;
			
		}
		
		public function clear():void
		{
			this.bitmapData.dispose();
			this.bitmapData = null;
		}
		
	}
	
}