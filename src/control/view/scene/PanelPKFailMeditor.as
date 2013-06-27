
package control.view.scene
{
	import control.sound.SoundManager;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.CommandManager;
	
	import model.config.StaticConfig;
	
	import view.scene.SceneBase;
	
	
	
	
	public class PanelPKFailMeditor extends ViewMeditorBase
	{
		private var _view : SceneBase;
		private var _asset:Sprite;
		private var _sceneState:String;
		
		public function PanelPKFailMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as SceneBase;
			_asset = _view.asset as Sprite;
			
			
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
			
			SoundManager.stopSound('bg_wind');
			SoundManager.playSound('bg_no',true);
		}
		
		 
		
		private function onClick(e:MouseEvent):void
		{
			e.stopPropagation();
			var _btn:SimpleButton = e.target as SimpleButton;
			
			if(!_btn) return;
			
			switch(_btn.name)
			{
				case 'back_btn' :
					_sceneState = StaticConfig.Scene_Mission;
					break;
				case 'equip_btn' :
					_sceneState = StaticConfig.Scene_EquipSelect;
					break; 
				case 'store_btn' :
					_sceneState = StaticConfig.Scene_StoreBuy;
					break; 	
				case 'army_btn' :
					_sceneState = StaticConfig.Scene_Army;
					break; 	

				default :
					break;
			}
			_view.remove(true); 
			
		}
		
		override public function clear():void
		{
			
			super.clear();
			this._view = null;
			this._asset = null;

			
		}
	}
}
 