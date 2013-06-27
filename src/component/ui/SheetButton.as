package component.ui
{
	import control.view.sheet.SheetBtnMeditor;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	
	import manager.MaterialManager;
	import manager.UIManager;
	
	import view.character.SheetSprite;
	
	public class SheetButton extends SheetSprite
	{
		protected var _btn :SimpleButton;
		private var _skinName:String;
		
		public var ctrl :SheetBtnMeditor;
		
		public function SheetButton(type : String=null, btnSkinName:String=null)
		{
			_skinName = btnSkinName;
			
			super(type);
			
			initControl();
		}
		
		private function initControl():void
		{
			ctrl = new SheetBtnMeditor(this);
			
		}
		
		override protected function init():void
		{
			super.init();
			
			this.mouseEnabled = true;
			this.buttonMode = true;
			
			
		}
	 
		
		override protected function initView():void
		{
			initBtn();
			this.initBitmap();
			
		}
 		
		protected function initBtn():void
		{
			if(!_skinName) return
				
			_btn = MaterialManager.getInstance().getBtnMaterial(_skinName);
			addChild(_btn);
		}
		
		override public function dispose():void
		{
			this._btn = null;
			this.ctrl = null;
			
			super.dispose();
		}
	}
}