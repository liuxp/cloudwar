
package view.tile
{
	import component.ui.tiles.Tile;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	
	/**
	 *
	 * FriendTile.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:06:47
	 */ 
	public class FriendTile extends Tile
	{ 
		private var _asset:Sprite;
		private var _name_txt:TextField;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function FriendTile()
		{
			super();
			
			_asset = MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Dispose_Friend);
			addChild(_asset);
			
			_name_txt = _asset['name_txt'];
		} 
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_name_txt.text = value.name;
		}
		
	}
	
}