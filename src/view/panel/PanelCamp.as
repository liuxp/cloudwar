
package view.panel
{
	import component.ui.SheetButton;
	
	import control.view.ViewColorCtrl;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.scene.SceneBase;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelCamp extends SceneBase
	{ 
		public var camp_store:SheetButton;
		public var camp_equip:SheetButton;
		public var camp_army:SheetButton;
		public var camp_friend:SheetButton;
		public var camp_mission:SheetButton;
		
		public var titleContainer:Sprite;
		public var title:Sprite;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelCamp()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Camp));
 			
			camp_mission = createSheetBtn("camp_mission", 170, 357);
			camp_store = createSheetBtn("camp_store", 424, 135);
			camp_equip = createSheetBtn("camp_equip", 145, 57);
			camp_army = createSheetBtn("camp_army", 0, 98);
			camp_friend = createSheetBtn("camp_friend", 426, 90);
			
			
			titleContainer = MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Camp_Titles);
			addChild(titleContainer);
			titleContainer.x = 21;
			titleContainer.y = 7;
			GlobalUtil.setChildrenAttrs(titleContainer,{'alpha':0.2});
		} 
		
		public function getSheetBtn(name:String):SheetButton
		{
			return this.getChildByName(name) as SheetButton;
		}
		
		private function createSheetBtn(type:String,x:int,y:int):SheetButton
		{
			var btn:SheetButton = new SheetButton(type);
			btn.x = x;
			btn.y = y;
			btn.name = type;
			addChild(btn);
			return btn;
		}
		
		public function showTitle(name:String):void
		{
			var itm:Sprite = this.titleContainer.getChildByName(name) as Sprite;
			if(!itm) return;
			
			if(title && title != itm)
			{
				title.alpha = 0.2;
			}

			itm.alpha = 1;
			title = itm ;
		}
		
		
	}
	
}