package control.view.sheet
{
	import core.view.ViewBase;
	
	import events.GameEvent;
	import events.UIEvent;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	public class SheetBtnMeditor extends SheetSpriteMeditor
	{
		public function SheetBtnMeditor(view:ViewBase)
		{
			super(view);
		}
		
		override protected function init():void
		{
			addListenerCfg();
			
			initData();
			
			initBitList();
			
			this.Play();
		}
		
		/*override protected function addListenerCfg():void
		{
			super.addListenerCfg();
			
			_view.addEventListener(MouseEvent.CLICK, downHandler);
			
			
			
		}
		
		override protected function removeListenerCfg():void
		{
			super.removeListenerCfg();
			
			_view.removeEventListener(MouseEvent.CLICK, downHandler);
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			this.renderStart();
			 
		}*/
 		
		/**位图渲染*/
		override public function Play():void
		{
			if(!this._render) return;
			
			if(this._render.isEnd())
			{
				
				this.renderStop();
				Reverse();
				return;
			}
			
			var srcBit:BitmapData = _render.render();
			_view.bitmap.bitmapData = srcBit;
 
		}
		
		public function Reverse():void
		{
			_render.reset();
			_render.reverse();
 
		}
	}
}