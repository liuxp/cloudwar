package control.view.panel
{
	import business.BSLocUtil;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import view.scene.SceneBase;
	
	public class MeditorPanelEntry extends ViewMeditorBase
	{
		private var _view:SceneBase;
		public static const BTN_NAME_START:String = 'start_btn'
			
		public function MeditorPanelEntry(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as SceneBase;
			super(viewUI, model);
		}
		
		override protected function addListenerCfg():void
		{
			_view.addEventListener(MouseEvent.CLICK, onClick);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler)
		}
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler)
		}
		
		protected function removeHandler(event:Event):void
		{
			 
			this.clear();
			CommandManager.ChangeScene(StaticConfig.Scene_Camp);
		}
		
		protected function onClick(_event:MouseEvent):void
		{
			_event.stopPropagation();
			
			if (_event.target is SimpleButton) {
				var _btn:SimpleButton = _event.target as SimpleButton;
				if (_btn.name == BTN_NAME_START) {
					
					
					_view.remove(true);
				}
			}
		}
		
		
	}
}