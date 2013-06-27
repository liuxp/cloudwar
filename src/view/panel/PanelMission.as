
package view.panel
{
	import component.Pool;
	import component.ui.controls.SlidingScreen;
	import component.ui.tiles.CellList;
	import component.ui.tiles.TileList;
	
	import control.view.sheet.SheetLoopMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	import manager.UIManager;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.SearchUtil;
	
	import view.character.SheetSprite;
	import view.component.GameIcon;
	import view.component.LevelStar;
	import view.component.SelectedState;
	import view.component.UpDownME;
	import view.scene.SceneBase;
	import view.tile.MissionTile;
	import view.tile.SelectedTile;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelMission extends SceneBase
	{ 
		public var energyCost_txt:TextField;
		public var rwdExp_txt:TextField;
		public var rwdGold_txt:TextField;
		
		public var chapterIcon:Bitmap;
		public var missionModIcon:Bitmap;
		public var missionIntroIcon:Bitmap;
		
		public var missionTiles:CellList;
		private var tilesCtr:SlidingScreen;
		public var lvstar:LevelStar;
		
		private var _mask:Sprite;
		private var _selTile:SelectedTile;
		
		private var _selState:SelectedState;
		
		private var _ME:UpDownME;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelMission()
		{
			
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_MissionSelect));
			
			this.energyCost_txt = this.asset['energy_txt'];
			this.rwdExp_txt = this.asset['exp_txt'];
			this.rwdGold_txt = this.asset['gold_txt'];
			this._mask = this.asset['mask_mc'];
			
			chapterIcon = GlobalUtil.createChildDisObj(this,GameIcon, 0, 8) as Bitmap;

			missionIntroIcon = GlobalUtil.createChildDisObj(this,GameIcon, 304, 88) as Bitmap;
			missionIntroIcon.mask = this._mask;
			
			missionModIcon = GlobalUtil.createChildDisObj(this,GameIcon, 157, 192) as Bitmap;
			_ME = new UpDownME(missionModIcon);
			_ME.render();
			
			missionTiles = GlobalUtil.createChildDisObj(this,CellList, 8, 407) as CellList;
			missionTiles.rowHeight = 64;
			missionTiles.columnWidth = 64+8;
			missionTiles.renderClass = MissionTile;
			missionTiles.scrollRect = new Rectangle(-5,-5,784,80);
			tilesCtr = new SlidingScreen(missionTiles);
 
			lvstar = GlobalUtil.createChildDisObj(this,LevelStar,572,96) as LevelStar;
			
			
		} 
		
		public function showStars(num:int):void
		{
			lvstar.showStars(num);
		}
		
		public function showMissions(missions:Array):void
		{
			missionTiles.dataProvider(missions);
			missionTiles.show();
			tilesCtr.setDragRect();
		}
		
		public function showMissInfo(miss:Object):void
		{
			energyCost_txt.text = miss.BaseSet.EnergyCost;
			
			var rwds:Object = miss.NormalReward;
			
			var rwd :Object = rwds[StaticConfig.Rwd_Gold];
			this.rwdGold_txt.text = rwd.Amount;
			
			rwd = rwds[StaticConfig.Rwd_Exp];
			rwdExp_txt.text = rwd.Amount;
		}
		public function showAssetIcon(name:String, icon:Bitmap):void
		{
			var bm:Bitmap = MaterialManager.getInstance().getMapMaterial(name);
			if(bm) icon.bitmapData = bm.bitmapData;
		}
		
		public function showSheetIcon(name:String, icon:Bitmap):void
		{
			icon.bitmapData =GameUtil.getArmyIcon(AssetsCfg.L_hero, name);
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
			this._ME.clear();
			super.dispose();
		}
	}
	
}