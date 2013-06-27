
package view.dialog
{
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GameUtil;
	
	
	/**
	 *
	 * DialogUI.as class. 
	 * @author Administrator
	 * Created 2013-4-27 上午10:48:33
	 */ 
	public class DialogUI extends ViewBase
	{ 
		public var icon:Bitmap;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function DialogUI(asset:DisplayObject=null)
		{
			super(asset);
			
			icon = new Bitmap();
			addChild(icon);
			icon.x = 24;
			icon.y = 8;
		} 
		
		public function setHeadIcon(name:String):void
		{
			var bmt:BitmapData = this.getIcon(AssetsCfg.L_hero, name);
			icon.bitmapData = bmt;
		}
		
		
		private function getIcon(type:String, res:String):BitmapData
		{
			
			var _resXML:Vector.<XML> = MaterialManager.getInstance().getSheetMaterialInfos(type, res);
			var srcBit:BitmapData = MaterialManager.getInstance().getSheetMaterial(type);
			return GameUtil.getSheetBitBySheetXML(srcBit, _resXML[0]);
			
		}
	}
	
}