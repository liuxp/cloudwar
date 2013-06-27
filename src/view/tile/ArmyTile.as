package view.tile
{
	import component.ui.tiles.Tile;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	
	import model.GeneralModel;
	import model.config.AssetsCfg;
	import model.vo.EquipVO;
	import model.vo.GeneralVO;
	
	import utils.GlobalUtil;
	
	import view.component.GameIcon;
	
	
	/**
	 *
	 * EquipTile.as class. 
	 * @author Administrator
	 * Created 2013-5-25 下午4:30:03
	 */ 
	public class ArmyTile extends Tile
	{ 
		private var _asset:Sprite;
		private var _icon:GameIcon;
		private var _nameTxt:TextField;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function ArmyTile()
		{
			
			_asset = MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Dispose_Troop);
			addChild(_asset);
			
			_icon = GlobalUtil.createChildDisObj(this,GameIcon,8,29) as GameIcon
			_nameTxt = _asset['name_txt'];
		} 
		
		override public function set data(value:Object):void
		{
			super.data = value;
			var mod:GeneralModel = value as GeneralModel;
			var vo:GeneralVO = mod.getVO() as GeneralVO;
			_icon.show(AssetsCfg.S_hero, vo.id);
			_nameTxt.text = vo.name;
		}
		
	}
	
}