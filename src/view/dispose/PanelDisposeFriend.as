
package view.dispose
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.component.GameIcon;
	import view.scene.SceneBase;
	import view.tile.FriendTile;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午10:18:23
	 */ 
	public class PanelDisposeFriend extends DisposeBase
	{ 
		public var addBtn:Sprite;
		public var friend:FriendTile;
		public var icon:GameIcon;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelDisposeFriend()
		{
			var classObj:Class = MaterialManager.getInstance().getViewClass('Btn_AddFri');
			addBtn = GlobalUtil.createChildDisObj(this._layer,classObj,10,5) as Sprite;//加好友	
			friend = GlobalUtil.createChildDisObj(this._layer,FriendTile,80,0) as FriendTile;
 
			this.select();
			this.showTitle(AssetsCfg.Dispose_Friend_Title);
		} 
		
		
		
	}
	
}