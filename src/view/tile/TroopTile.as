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
	public class TroopTile extends Tile
	{ 
		private var _asset:Sprite;
		private var _icon:GameIcon;
		private var _foodTxt:TextField;
		private var _limitTxt:TextField;
		private var _iconContainer:Sprite;//
		private var _mask:Sprite;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function TroopTile()
		{
			
			_asset = MaterialManager.getInstance().getViewMaterial(AssetsCfg.ArmyProduct);
			addChild(_asset);
			
			_mask = _asset['mask_mc'];
			_mask.visible = false;
			_foodTxt = _asset['food_txt'];
			_limitTxt = _asset['limit_txt'];
			_iconContainer = _asset['icon_mc'];
			
			_icon = GlobalUtil.createChildDisObj(_iconContainer,GameIcon,0,0) as GameIcon
			
		} 
		
		override public function set data(value:Object):void
		{
			super.data = value;
			var mod:GeneralModel = value as GeneralModel;
			var vo:GeneralVO = mod.getVO() as GeneralVO;
			_icon.show(AssetsCfg.S_hero, vo.id);
			
			_foodTxt.text = vo.cost.toString();
			_limitTxt.text = vo.limit.toString();
		}
		
	}
	
}