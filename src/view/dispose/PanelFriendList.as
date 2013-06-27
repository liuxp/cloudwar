
package view.dispose
{
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	import component.ui.tiles.TileVariables;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import utils.GlobalUtil;
	
	import view.scene.SceneBase;
	import view.tile.FriendTile;
	
	
	/**
	 *
	 * FriendListUI.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:02:16
	 */ 
	public class PanelFriendList extends SceneBase
	{ 
		public var listUI:CellList;
		
		private var _tilesCtr:SlidingScreen;
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelFriendList()
		{
			this.init();
		} 
		
		override protected function init():void
		{
			listUI = GlobalUtil.createChildDisObj(this,CellList,17,89) as CellList
 
			listUI.align = TileVariables.Align_Vertical;
			listUI.rowHeight = 83;
			listUI.columnWidth = 296;
			listUI.renderClass = FriendTile
			listUI.scrollRect = new Rectangle(0,0,293,372);
			_tilesCtr = new SlidingScreen(listUI);
			
			
		}
		
		public function showFriends(fris:Array):void
		{
			listUI.dataProvider(fris);
			listUI.show();
			_tilesCtr.setDragRect();
			
		}
	}
	
}