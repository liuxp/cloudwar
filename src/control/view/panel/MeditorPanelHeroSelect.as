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
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import view.panel.PanelCamp;
	import view.panel.PanelEntry;
	import view.panel.PanelHeroSelect;
	import view.panel.PanelHeroSkill;
	import view.scene.SceneBase;
	
	public class MeditorPanelHeroSelect extends ViewMeditorBase
	{
		private var _view:PanelHeroSelect;
		private var _sceneState:String;
		
		public function MeditorPanelHeroSelect(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as PanelHeroSelect;
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
			CommandManager.ChangeScene(_sceneState);
		}
		
		protected function onClick(_event:MouseEvent):void
		{
			_event.stopPropagation();
			var _btn:SimpleButton = _event.target as SimpleButton;
			if(!_btn) return;
			
			
			
			switch(_btn.name)
			{

				case 'back_btn' :
					_sceneState = StaticConfig.Scene_Camp;
					break; 	
			}
			_view.remove(true); 
		}
		
		
	}
}