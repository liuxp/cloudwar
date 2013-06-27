
package control.view.panel.dispose
{
	import component.ui.tiles.Tile;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	import events.TileEvent;
	
	import flash.events.Event;
	
	import view.dispose.PanelArmyList;
	import view.dispose.PanelFriendList;
	import view.dispose.PanelSkillList;
	
	
	/**
	 *
	 * MeditorPanelFriendList.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:34:34
	 */ 
	public class MeditorPanelArmyList extends ViewWatcherMeditorBase
	{ 
		private var _view:PanelArmyList;
		private var _vo:Array;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MeditorPanelArmyList(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI as PanelArmyList;
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
			_view.listUI.addEventListener(TileEvent.Select_Item, onSelItmHandler);
		}
		
		protected function onSelItmHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			if(tile) this.dispatchMeditorEvent(
				new MeditorEvent(MeditorEvent.Select_Army, 
					tile.data));
		}
		
		override protected function removeListenerCfg():void
		{
			
		}
	}
	
}