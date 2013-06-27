
package view.panel
{
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	import model.vo.EquipVO;
	
	import utils.GlobalUtil;
	
	import view.component.EquipIntro;
	import view.component.GameIcon;
	import view.scene.SceneBase;
	import view.tile.EquipTile;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelEquipStrength extends SceneBase
	{ 
		public var heroEquips:CellList;
		public var equips:CellList;
		public var equipIntro:EquipIntro;
		public var heroAttr:PanelHeroAttr;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelEquipStrength()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_EquipStrength));
			
			
			equips = GlobalUtil.createChildDisObj(this, CellList, 8,408) as CellList;
			equips.renderClass = EquipTile;
			equips.rowHeight = 64;
			equips.columnWidth = 64 + 16;
			new SlidingScreen(equips);
			
			equipIntro = GlobalUtil.createChildDisObj(this, EquipIntro, 489,87) as EquipIntro;
			
			heroAttr = GlobalUtil.createChildDisObj(this, PanelHeroAttr, 240,96) as PanelHeroAttr;
			
		} 
		
		
		
	}
	
}
