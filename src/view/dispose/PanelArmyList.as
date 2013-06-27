
package view.dispose
{
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	import component.ui.tiles.TileVariables;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import utils.GlobalUtil;
	
	import view.scene.SceneBase;
	import view.tile.ArmyTile;
	import view.tile.FriendTile;
	
	
	/**
	 *
	 * FriendListUI.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:02:16
	 */ 
	public class PanelArmyList extends SceneBase
	{ 
		public var listUI:CellList;
		
		private var _tilesCtr:SlidingScreen;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelArmyList()
		{
			this.init();
		} 
		
		override protected function init():void
		{
			listUI = GlobalUtil.createChildDisObj(this,CellList,19,92) as CellList
			
			
			listUI.align = TileVariables.Align_Vertical;
			listUI.rowHeight = 127;
			listUI.columnWidth = 100;
			listUI.renderClass = ArmyTile;
			listUI.row = 3;
			listUI.column = 3;
			//listUI.scrollRect = new Rectangle(0,0,287,390);
			_tilesCtr = new SlidingScreen(listUI);
		}
		
		public function showArmys(fris:Array):void
		{
			listUI.dataProvider(fris);
			listUI.show();
			//_tilesCtr.setDragRect();
			
		}
	}
	
}