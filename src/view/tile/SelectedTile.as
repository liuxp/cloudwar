
package view.tile
{
	import component.ui.tiles.Tile;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import utils.GlobalUtil;
	
	
	/**
	 *
	 * SelectedTile.as class. 
	 * @author Administrator
	 * Created 2013-6-14 下午4:57:36
	 */ 
	public class SelectedTile extends Tile
	{ 
		protected var _layer:Sprite;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function SelectedTile()
		{
			super();
			
			_layer = GlobalUtil.createContainer(this,false,false);
		} 
		
		public function showSelBg(bg:Sprite):void
		{
			this._layer.addChild(bg);
			bg.x = -5
			bg.y = -5
		}
 
		public function clearSelBg(bg:Sprite):void
		{
			this._layer.removeChild(bg);
		}
		
		public function getChild(name:String):DisplayObject
		{
			return this._layer.getChildByName(name);
		}
		
	}
	
}