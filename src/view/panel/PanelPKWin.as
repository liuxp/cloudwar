
package view.panel
{
	 
	
	import component.ui.tiles.CellList;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.component.LevelStar;
	import view.scene.SceneBase;
	import view.tile.EquipTile;
	 
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午10:18:23
	 */ 
	public class PanelPKWin extends SceneBase
	{ 
		public var star:LevelStar; 
		public var listUI:CellList;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelPKWin()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Game_Result_WinUI));
			
			this.init();
			
			
		} 
		
		override protected function init():void
		{
			this.mouseChildren = false;
			
			star = GlobalUtil.createChildDisObj(this,LevelStar, 481, 90) as LevelStar;
			listUI = GlobalUtil.createChildDisObj(this,CellList, 469, 304) as CellList;
			listUI.renderClass = EquipTile;
			listUI.columnWidth = 72;
			listUI.rowHeight = 64;
		}
		
		public function showStar(num:int):void
		{
			star.showStars(num);
		}
		
		public function showEquips(lis:Array):void
		{
			listUI.dataProvider(lis);
			listUI.show();
		}
		
	}
	
}
