 
package control.view.popUI
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import manager.ModelLocator;
	
	import mx.core.SpriteAsset;
	
	public class PopUIWatcherMeditor extends ViewWatcherMeditorBase
	{
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		
		protected var _asset:SpriteAsset;
		protected var _closeBtn:SimpleButton;
		private var _view : ViewBase;
		
		public function PopUIMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI;
			_asset = viewUI.asset;
			initAssets();
			super(viewUI, mod);
		}
		 
		protected function initAssets():void
		{
			_closeBtn = _asset['close_btn'];
		}
		
		 
		override protected function addListenerCfg():void
		{
			_closeBtn.addEventListener(MouseEvent.CLICK, closeHandler)
		}
		
		override protected function removeListenerCfg():void
		{
			_closeBtn.removeEventListener(MouseEvent.CLICK, closeHandler)
		}
		
		protected function closeHandler(e:MouseEvent):void
		{
			_view.removeFromParent();
			close();
			
		}
		
		override public function clear():void
		{
			this._ML = null;
			this._view = null;
			this._asset = null;
			this._closeBtn = null;
			super.clear();
			
		}
	}
}