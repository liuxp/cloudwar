package control.view.popUI
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.ModelLocator;
	
	import mx.core.SpriteAsset;
	
	public class PopUIMeditor extends ViewMeditorBase
	{
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		
		protected var _asset:SpriteAsset;
		protected var _closeBtn:SimpleButton;
		private var _view : ViewBase;
		
		public function PopUIMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI;
			_asset = viewUI.asset as SpriteAsset;
			initAssets();
			super(viewUI, model);
		}
		
		protected function initAssets():void
		{
			_closeBtn = _asset['close_btn'];
		}
		
		override protected function addListenerCfg():void
		{
			_closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			
		}
		
		override protected function removeListenerCfg():void
		{
			_closeBtn.removeEventListener(MouseEvent.CLICK, closeHandler)

		}
		
		protected function closeHandler(e:MouseEvent):void
		{
			close();
			_view.removeFromParent();
			
		}
 
		override public function clear():void
		{
			super.clear();
			
			this._ML = null;
			this._view = null;
			this._asset = null;
			this._closeBtn = null;
			
			
		}
 		public function refresh():void
		{
			
		}
	}
}