package control.view.sheet
{

	import component.Dict;
	
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import manager.MaterialManager;
	import manager.UIManager;
	
	import model.vo.SheetVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.SheetSprite;

	public class SheetLoopMeditor extends SheetSpriteMeditor
	{
		 
		
		
		public function SheetLoopMeditor(view:ViewBase)
		{
			_view = view as SheetSprite;
			
			super(view);
			
			//init();
		}
		
		
		override protected function init():void
		{
			initData();
			
			initBitList();
			
			GameUtil.delayExecuteFun(_delay, Play, 0, _mid);
			
			super.init();			
		} 
		 
		
		 
		override protected function addListenerCfg():void
		{
			/**移除view对象 liuxp 2011/9/20*/
			this.addMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.addMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.addMeditorEventListener(MeditorEvent.Render_Pause, renderStop);
			this.addMeditorEventListener(MeditorEvent.Render_Resume, renderStart) 
		}
		
		override protected function removeListenerCfg():void
		{
			this.removeMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.removeMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.removeMeditorEventListener(MeditorEvent.Render_Pause, renderStop);
			this.removeMeditorEventListener(MeditorEvent.Render_Resume, renderStart) 
		}
 
	}
}