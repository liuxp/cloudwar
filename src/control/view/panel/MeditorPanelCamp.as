package control.view.panel
{
	import business.BSLocUtil;
	
	import component.ui.SheetButton;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import utils.MatrixUtil;
	
	import view.panel.PanelCamp;
	import view.panel.PanelEntry;
	import view.scene.SceneBase;
	
	public class MeditorPanelCamp extends ViewMeditorBase
	{
		private var _view:PanelCamp;
		private var _sceneState:String;
		private var _sheetBtn:SheetButton;
		
		public function MeditorPanelCamp(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as PanelCamp;
			super(viewUI, model);
		}
		
		override protected function init():void
		{
			super.init();
			checkSheetBtn(_view.camp_mission);
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
			var _btn:DisplayObject = _event.target as DisplayObject;
			
			 if(_btn as SheetButton){
				
				var gloP:Point = new Point(_event.stageX, _event.stageY);
				var objs:Array = _view.getObjectsUnderPoint(gloP);
				
				for each(var i:DisplayObject in objs)
				{
 
					if(i as Bitmap)
					{
						var isTrans:Boolean
						var locP:Point = i.globalToLocal(gloP);
						isTrans = MatrixUtil.isGetPixel32( Bitmap(i).bitmapData, 
															locP.x, locP.y);
						
						if(isTrans){
							var btn:SheetButton = i.parent as SheetButton;
//							if(btn) this.checkSheetBtn(btn);
							break;
						}
					}
				}
			}else{
				var sheetBtn:SheetButton = _view.getSheetBtn(_btn.name);
				if(sheetBtn)
				{
 
					if(sheetBtn == this._sheetBtn)
					{
						entry(sheetBtn.name);
					}
					
					checkSheetBtn(sheetBtn );
				}
				
				
			}
			
			
			
		}
		
		private function entry(name:String):void
		{
			switch(name)
			{
				case 'camp_mission' :
					_sceneState = StaticConfig.Scene_Mission;
					break;
				case 'camp_equip' :
					_sceneState = StaticConfig.Scene_EquipSelect;
					break; 
				case 'camp_store' :
					_sceneState = StaticConfig.Scene_StoreBuy;
					break; 	
				case 'camp_army' :
					_sceneState = StaticConfig.Scene_Army;
					break; 	
				case 'camp_friend' :
					return;
					//_sceneState = StaticConfig.Scene_HeroSelect;
					break; 
				default :
					break;
			}
			
			_view.remove(true); 
		}
		private function checkSheetBtn(btn:SheetButton):void
		{
			if(!btn) return;

			if(_sheetBtn && btn != _sheetBtn)
			{
				//_sheetBtn.ctrl.Reverse();
				_sheetBtn.ctrl.renderStart();
			}else if(_sheetBtn == btn){
				//entry(btn.name);
				return;
			}
			
			
			btn.ctrl.renderStart();
			_sheetBtn = btn;
			_view.showTitle(btn.name);
		}
		
	}
}
