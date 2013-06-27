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
	
	import view.panel.PanelEquipSelect;
	import view.tile.SelectedTile;
	
	public class MeditorPanelEquipSelect extends ViewWatchersMeditorBase
	{
		private var _view:PanelEquipSelect;
		private var _sceneState:String;
		private var _heroEquipVO:EquipListVO;
		private var _equipsVO:EquipListVO;
		
		private var _equip:EquipVO;
		private var _heroEquip:EquipVO;
		
		public function MeditorPanelEquipSelect(viewUI:ViewBase, mods:Array)
		{
			_view = viewUI as PanelEquipSelect;
			_heroEquipVO = mods[0].getVO();
			_equipsVO = mods[1].getVO();
			
			super(viewUI, mods);
		}
		
		override protected function init():void
		{
			super.init();
			
			initHeroEquips();
		}
		
		override public function update(data:Object):void
		{
			
		}
		private function initHeroEquips():void
		{
			var arr:Array = [];
			var lis:Array = ['Weapon','Armor','Horse','Treasure','Extra'];
			for(var i:int; i<lis.length; i++)
			{
				var type:String = lis[i];
				var itms:Array = _heroEquipVO[type]
				arr = arr.concat(itms);
			}
			
			_view.heroEquips.dataProvider(arr);
			_view.heroEquips.show();
		}
		
		override protected function addListenerCfg():void
		{
			_view.asset.addEventListener(MouseEvent.CLICK, onClick);
			_view.equips.addEventListener(TileEvent.Select_Item, selEquipHandler);
			_view.heroEquips.addEventListener(TileEvent.Select_Item, selHeroEquipHandler);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
		}
		
		protected function selHeroEquipHandler(event:TileEvent):void
		{
			_view.tip.visible = false;
			var tile:Tile = event.data as Tile;
			var vo:EquipVO = tile.data as EquipVO;
			_ML.selEquip.setVO(vo);
			this._heroEquip = vo;
			this._equip = null;
			showEquip(vo, _view.equips);
			
			trace(this._heroEquip.Name)
		}
		
		protected function selEquipHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			var vo:EquipVO = tile.data as EquipVO;
			_ML.selEquip.setVO(vo);
			this._equip = vo;
			_view.equipIntro.showEquip(vo);
			
			_view.showSelBg(tile as SelectedTile);
			
			trace(this._equip.Name)
		}
		
		private function showEquip(vo:EquipVO, listUI:CellList):void
		{
			var lis:Array = _equipsVO[vo.Type];
			listUI.dataProvider(lis);
			listUI.show();
			_view.equipIntro.showEquip(vo);
		}
		
		override protected function removeListenerCfg():void
		{
			_view.asset.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			_view.equips.removeEventListener(TileEvent.Select_Item, selEquipHandler);
			_view.heroEquips.removeEventListener(TileEvent.Select_Item, selHeroEquipHandler);
			
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
				case 'hero_btn' :
					_sceneState = StaticConfig.Scene_HeroSelect;
					break;
				case 'skill_btn' :
					_sceneState = StaticConfig.Scene_HeroSkill;
					break; 
				case 'back_btn' :
					_sceneState = StaticConfig.Scene_Camp;
					break; 
				case 'equip_btn' :
					replace();
					return; 	
				case 'strength_btn' :
					_sceneState = StaticConfig.Scene_EquipStrength;
					break; 	
			}
			_view.remove(true); 
		}
		
		private function replace():void
		{
			if(!_equip || !_heroEquip) return;
			if(_heroEquip.id != this._equip.id)
			{
				var arr:Array = this._heroEquipVO[_heroEquip.Type];
				
				var itm:EquipVO = SearchUtil.getItemByVOFromArr(_equip, arr);
				if(itm)
				{
					CommandManager.ShowTip('已经装备');
					return;
				}
				
				var index:int = SearchUtil.getItemIndexByVO(
								'id',_heroEquip.id, arr);
				if(index >-1)
				{
					arr[index] = _equip;
				}
				
				this.initHeroEquips();
				/*var tile:Tile = _view.heroEquips.getTileByData(_heroEquip);
				tile.data = _equip;*/
				
				this._heroEquip = this._equip;
				
				CommandManager.ShowTip('装备成功');
			}
			
			trace(this._heroEquip.Name)
			trace(this._equip.Name)
		}
		
		override public function clear():void
		{
			super.clear();
			
			_view = null;
			this._heroEquipVO = null;
			this._equipsVO = null;
			this._equip = null;
			this._heroEquip = null;
		}
	}
}