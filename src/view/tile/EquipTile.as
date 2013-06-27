
package view.tile
{
	import component.ui.tiles.Tile;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.EquipVO;
	
	import utils.GameUtil;
	import utils.ObjToModelUtil;
	
	import view.component.GameIcon;
	
	
	/**
	 *
	 * EquipTile.as class. 
	 * @author Administrator
	 * Created 2013-5-25 下午4:30:03
	 */ 
	public class EquipTile extends SelectedTile
	{ 
		private var _icon:GameIcon;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function EquipTile()
		{
			super();
			_icon = new GameIcon();
			addChild(_icon);
		} 
		
		override public function set data(value:Object):void
		{
			if(!value) return;
			super.data = value;
			var vo:EquipVO = value as EquipVO;
			if( !vo)
			{
				var equip_cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Equip, value.ID);
				vo = ObjToModelUtil.ObjToEquip(equip_cfg);
			}
			
			_icon.show(AssetsCfg.Equip, vo.id);
		}
		
	}
	
}