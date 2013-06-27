
package control.view.panel.dispose
{
	import component.ui.tiles.Tile;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	import events.TileEvent;
	
	import flash.events.Event;
	
	import model.GeneralModel;
	
	import utils.SearchUtil;
	
	import view.dispose.PanelArmyList;
	import view.dispose.PanelFriendList;
	import view.dispose.PanelTroops;
	
	
	/**
	 *
	 * MeditorPanelFriendList.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:34:34
	 */ 
	public class MeditorPanelTroops extends ViewWatcherMeditorBase
	{ 
		private var _view:PanelTroops;
		private var _vo:Array;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MeditorPanelTroops(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI as PanelTroops;
			_vo = mod.getVO() as Array;
			
			super(viewUI, mod);
		} 
		
		override protected function init():void
		{
			super.init();
			showArmys();
		}
		override public function update(data:Object):void
		{
			showArmys();
		}
		
		private function showArmys():void
		{
			_view.showArmys(_vo);
			
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.Select_Army,onSelArmyHandler);
			_view.listUI.addEventListener(TileEvent.Select_Item, onSelItmHandler);
		}
		
		protected function onSelArmyHandler(event:MeditorEvent):void
		{
			var data:GeneralModel = event.data as GeneralModel;
			if(SearchUtil.getItemByVOFromArr(data,_vo)) return;
			if(_vo.length <5) _vo.push(data);
			
			
			_model.setVO(_vo);
		}
		
		protected function onSelItmHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			var mod:GeneralModel = tile.data as GeneralModel;
			var index:int = SearchUtil.getItemIndexByVO('uid', mod.uid, _vo);
			_vo.splice(index,1);
			
			_model.setVO(_vo);
		}
		
		override protected function removeListenerCfg():void
		{
			
		}
	}
	
}