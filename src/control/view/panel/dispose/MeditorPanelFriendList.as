
package control.view.panel.dispose
{
	import component.ui.tiles.Tile;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	import events.TileEvent;
	
	import flash.events.Event;
	
	import view.dispose.PanelFriendList;
	
	
	/**
	 *
	 * MeditorPanelFriendList.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:34:34
	 */ 
	public class MeditorPanelFriendList extends ViewWatcherMeditorBase
	{ 
		private var _view:PanelFriendList;
		private var _vo:Array;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MeditorPanelFriendList(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI as PanelFriendList;
			_vo = mod.getVO() as Array;
			
			super(viewUI, mod);
		} 
		
		override protected function init():void
		{
			super.init();
			showFriends();
		}
		override public function update(data:Object):void
		{
			showFriends();
		}
		
		private function showFriends():void
		{
			_view.showFriends(_vo);
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Select_Friend, _vo[0]));
		}
		
		override protected function addListenerCfg():void
		{
			_view.listUI.addEventListener(TileEvent.Select_Item, onSelItmHandler);
		}
		
		protected function onSelItmHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			if(tile) this.dispatchMeditorEvent(
							new MeditorEvent(MeditorEvent.Select_Friend, 
							tile.data));
		}
		
		override protected function removeListenerCfg():void
		{
			
		}
	}
	
}