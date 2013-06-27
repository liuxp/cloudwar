package control.view.panel.dispose
{
	import business.BSLocUtil;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	import events.TileEvent;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import view.dispose.DisposeBase;
	import view.dispose.PanelDisposeUI;
	import view.panel.PanelCamp;
	import view.panel.PanelEntry;
	import view.panel.PanelEquipStrength;
	import view.panel.PanelHeroSkill;
	import view.scene.SceneBase;
	
	public class MeditorPanelDispose extends ViewWatcherMeditorBase
	{
		private var _view:PanelDisposeUI;
		private var _sceneState:String;
		
		
		public function MeditorPanelDispose(viewUI:ViewBase, model:ModelBase)
		{
			_view = viewUI as PanelDisposeUI;
			super(viewUI, model);
		}
		
		override protected function init():void
		{
			super.init();
			_view.initUIGroup();
			_view.showSelDispose(_view.dis_friend);
		}
		override protected function addListenerCfg():void
		{
			_view.addEventListener(MouseEvent.CLICK, onClick);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			this.addMeditorEventListener(MeditorEvent.Select_Friend, onSelFriHandler);
		}
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			this.removeMeditorEventListener(MeditorEvent.Select_Friend, onSelFriHandler);
		}
		
		protected function onSelFriHandler(event:MeditorEvent):void
		{
			_view.dis_friend.friend.data = event.data;
		}
		
		protected function removeHandler(event:Event):void
		{
			this.clear();
			if(_sceneState)
			{
				CommandManager.ChangeScene(_sceneState);
			}else{
				
				CommandManager.StartPK();
			}
		}
		
		protected function onClick(_event:MouseEvent):void
		{
			_event.stopPropagation();
 
			switch(_event.target.name)
			{
				case 'start_btn' :
					_sceneState = null
					_view.remove(true); 
					break;
				case 'back_btn' :
					_sceneState = StaticConfig.Scene_Mission;
					_view.remove(true); 
					break;
				case 'friend_btn' :
					_view.panelFri.visible=true;
					_view.panelArmies.visible=false;
					_view.panelSkills.visible = false;
					_view.showSelDispose(_view.dis_friend);
					_view.showTitle(AssetsCfg.Title_Dispose_Friend);
					break;
				case 'troop_btn' :
					_view.panelFri.visible=false;
					_view.panelArmies.visible=true;
					_view.panelSkills.visible = false;
					_view.showSelDispose(_view.dis_troops);
					_view.showTitle(AssetsCfg.Title_Dispose_Troop);
					break;
				case 'skill_btn' :
					_view.panelFri.visible=false;
					_view.panelArmies.visible=false;
					_view.panelSkills.visible = true; 
					_view.showSelDispose(_view.dis_skill);
					_view.showTitle(AssetsCfg.Title_Dispose_Skill);
					break;
				default :
					break;
			}

		}
		
		
	}
}