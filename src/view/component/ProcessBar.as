package view.component
{
	import component.RadiusShape;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import model.config.ArmyConfig;
	
	import mx.core.SpriteAsset;
	
	import utils.MatrixUtil;

	/**
	 *进度条 
	 * @author Administrator
	 * 
	 */	
	public class ProcessBar extends ViewBase
	{
		public var barHp:RadiusShape;
		public var borderHP:RadiusShape;
		public var bm_bar:Bitmap;
		public var bm_border:Bitmap;
		private var _container:Sprite;
		
		public function ProcessBar(asset:SpriteAsset=null)
		{
			super(asset);
 			
			bm_bar = new Bitmap();
			addChild(bm_bar);
			
			bm_border = new Bitmap();
			addChild(bm_border);
 
			barHp = new RadiusShape();
			borderHP = new RadiusShape();
			
			
		}
 
		
		public function setProcess(cur:int, max:int, camp:int):void
		{
			
			
			if(!borderHP.width)
			{
				var color:uint = camp == ArmyConfig.Camp_Enemy 
								 ? 0xffcc00 
								 : 0x00ffff;
				barHp.Create(cur,4,0,0xff0000,0xff0000);
				borderHP.Create(max,4,2,color,0xff0000, 0);
				bm_bar.bitmapData = MatrixUtil.disObjToBit(barHp);
				bm_border.bitmapData = MatrixUtil.disObjToBit(borderHP);
			}else{
				bm_bar.width = cur / max * 40
			}
			
			
		}
	}
}