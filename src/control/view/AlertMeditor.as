package control.view
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import mx.core.ButtonAsset;
	
	import utils.GlobalUtil;
	
	
	

	public class AlertMeditor extends ViewMeditorBase
	{
		private var _view : ViewBase;
		private var _btn :SimpleButton;
		
		public function AlertMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI;
			_btn = _view['close_btn'];
			super(viewUI, model);
			
			
		}
		
		override protected function addListenerCfg():void
		{
			
			_btn.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		override protected function removeListenerCfg():void
		{
			
			_btn.removeEventListener(MouseEvent.CLICK, onClickHandler);
		}
			
		
		private function onClickHandler(e:MouseEvent):void
		{
			
			this.clear();
			
		}
		
		override public function clear():void
		{
			if(_view.parent) _view.parent.removeChild(_view);
			
			super.clear();

			_view = null;
			_btn = null;
		}
	}
}