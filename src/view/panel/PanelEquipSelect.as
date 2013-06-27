
package view.panel
{
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	import manager.UIManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.component.EquipIntro;
	import view.component.SelectedState;
	import view.scene.SceneBase;
	import view.tile.EquipTile;
	import view.tile.SelectedTile;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelEquipSelect extends SceneBase
	{ 
		public var heroEquips:CellList;
		public var equips:CellList;
		public var equipIntro:EquipIntro;
		public var heroAttr:PanelHeroAttr;
		public var tip:Sprite;
		
		private var _selTile:SelectedTile;
		
		private var _selState:SelectedState;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelEquipSelect()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_EquipSelect));
			
			this.tip = asset['tip_mc'];
			heroEquips = GlobalUtil.createChildDisObj(this, CellList, 8,320) as CellList;
			heroEquips.renderClass = EquipTile;
			heroEquips.rowHeight = 64;
			heroEquips.columnWidth = 64 + 16;
			new SlidingScreen(heroEquips);
			
			equips = GlobalUtil.createChildDisObj(this, CellList, 8,408) as CellList;
			equips.renderClass = EquipTile;
			equips.rowHeight = 64;
			equips.columnWidth = 64 + 16;
			new SlidingScreen(equips);
			
			equipIntro = GlobalUtil.createChildDisObj(this, EquipIntro, 489,87) as EquipIntro;
			
			heroAttr = GlobalUtil.createChildDisObj(this, PanelHeroAttr, 240,96) as PanelHeroAttr;
			
		} 
		
		public function showSelBg(tile:SelectedTile):void
		{
			if(this._selTile && this._selTile!= tile)
			{
				_selState = this._selTile.getChild(UIManager.Type_Selected) as SelectedState;
				this._selTile.clearSelBg(_selState);
				UIManager.addUIToPool(UIManager.Type_Selected,_selState);
				_selState.stop();
			}else if(this._selTile == tile)
			{
				return;
			}
			
			_selState = UIManager.getUIFromPool(UIManager.Type_Selected)as SelectedState;
			_selState.name = UIManager.Type_Selected;
			this._selTile = tile;
			_selState.show();
			this._selTile.showSelBg(_selState);
		}
		
		override public function dispose():void
		{
			if(_selState)
			{
				UIManager.addUIToPool(UIManager.Type_Selected,_selState);
			}
			super.dispose();
		}
		
	}
	
}