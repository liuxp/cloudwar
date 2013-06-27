package control.view.panel
{
	import component.ui.tiles.CellList;
	import component.ui.tiles.Tile;
	
	import core.view.ViewBase;
	import core.view.ViewWatchersMeditorBase;
	
	import events.TileEvent;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.CommandManager;
	
	import model.config.StaticConfig;
	import model.vo.EquipListVO;
	import model.vo.EquipVO;
	
	import utils.SearchUtil;
	
	import view.panel.PanelEquipStrength;
	
	public class MeditorPanelEquipStrength extends ViewWatchersMeditorBase
	{
		private var _view:PanelEquipStrength;
		private var _sceneState:String;
		private var _equipsVO:EquipListVO;
		private var _equip:EquipVO;
		private var _selEquip:EquipVO;
		
		public function MeditorPanelEquipStrength(viewUI:ViewBase, mods:Array)
		{
			_view = viewUI as PanelEquipStrength;
			_equipsVO = mods[1].getVO();
					 
			
			super(viewUI, mods);
		}
		
		override protected function init():void
		{
			super.init();
			
			initEquips();
		}
		
		override public function update(data:Object):void
		{
			
		}
		private function initEquips():void
		{
			_selEquip = _ML.selEquip.getVO() as EquipVO;
			
			_view.equipIntro.showEquip(_selEquip);
			
			var lis:Array = _equipsVO[_selEquip.Type];
			var itms:Array = SearchUtil.getItemListByKeysFromList(
							 ['id','isWear'],[_selEquip.id, false], lis);
 
			_view.equips.dataProvider(itms);
			_view.equips.show();
		}
		
		override protected function addListenerCfg():void
		{
			_view.asset.addEventListener(MouseEvent.CLICK, onClick);
			_view.equips.addEventListener(TileEvent.Select_Item, selEquipHandler);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
		}
		
		
		protected function selEquipHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			var vo:EquipVO = tile.data as EquipVO;
			
			this._equip = vo;
			_view.equipIntro.showEquip(vo);
			
			trace(this._equip.Name)
		}
		

		
		override protected function removeListenerCfg():void
		{
			_view.asset.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			_view.equips.removeEventListener(TileEvent.Select_Item, selEquipHandler);
			
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
					_sceneState = StaticConfig.Scene_EquipSelect;
					_view.remove(true); 
					break; 
				case 'compose_btn' :
					compose();	
				case 'strength_btn' :
					_sceneState = StaticConfig.Scene_EquipStrength;
					break; 	
			}
			
		}
		
		private function compose():void
		{
			if(!_equip || _selEquip.id != this._equip.id) return;
			
				var arr:Array = this._equipsVO[_selEquip.Type];

				SearchUtil.delItemFromList(_equip, arr);
				
				this.initEquips();

				CommandManager.ShowTip('合成成功');

		}
		
		override public function clear():void
		{
			super.clear();
			
			_view = null;
			this._equip = null;
			this._selEquip = null;
			_equipsVO = null;
		}
	}
}
