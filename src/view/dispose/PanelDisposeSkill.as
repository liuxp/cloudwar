
package view.dispose
{
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	import component.ui.tiles.TileVariables;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.scene.SceneBase;
	import view.tile.DisposeSkillTile;
	import view.tile.FriendTile;
	import view.tile.TroopTile;
	
	
	/**
	 *
	 * FriendListUI.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:02:16
	 */ 
	public class PanelDisposeSkill extends DisposeBase
	{ 
		public var listUI:CellList;
		
		private var _tilesCtr:SlidingScreen;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelDisposeSkill()
		{
			this.init();
		} 
		
		override protected function init():void
		{
			var bm:Bitmap = MaterialManager.getInstance().getMapMaterial('EquipBg');
			for(var i:int; i<3; i++)
			{
				var bg:Bitmap = new Bitmap(bm.bitmapData);
				bg.x = 70*i +9;
				bg.y = 10;
				this._layer.addChild(bg);
			}
			
			listUI = GlobalUtil.createChildDisObj(this._layer,CellList, 10, 10) as CellList

			listUI.align = TileVariables.Align_Horizontal;
			listUI.rowHeight = 64;
			listUI.columnWidth = 70;
			listUI.renderClass = DisposeSkillTile
			listUI.scrollRect = new Rectangle(0,0,375,80);
			_tilesCtr = new SlidingScreen(listUI);
 
			this.reset();
			this.showTitle(AssetsCfg.Dispose_Skill_Title);
		}
		
		public function showSkills(fris:Array):void
		{
			listUI.dataProvider(fris);
			listUI.show();
			//_tilesCtr.setDragRect();
			
		}
	}
	
}