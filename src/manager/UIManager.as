package manager
{
	import component.Dict;
	import component.Pool;
	
	import control.view.popUI.PopUIMeditor;
	import control.view.popUI.WaveRwdUIMeditor;
	
	import core.meditor.MeditorBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import mx.core.SpriteAsset;
	
	import utils.GlobalUtil;
	
	import view.Game;
	import view.component.SelectedState;
	import view.component.Zone;
	import view.scene.PKScene;
	
	public class UIManager
	{
		public static const Type_Pop : String = '_popUIDict';
		public static const Type_Selected : String = 'pool_selected';
		public static const Type_Hero :String = '_heroDict';
		
		private static var _popUIDict : Dict = new Dict();
		private static var pool_selected : Pool = new Pool(SelectedState, 1);
		private static var _heroDict : Dict = new Dict();
		
		public function UIManager(instance : SingleTon)
		{
			
			 
		}
		/**
		 *添加UI 
		 * @param uid
		 * @param ui
		 * @param type
		 * 
		 */		
		public static function addUIToDict(uid:String, ui:ViewBase, type:String):void
		{
			var lis:Dict = UIManager[type];
			if(!lis.isHaveItem(uid)) lis.AddItem(uid, ui);	
		}
		/**
		 *删除缓存UI 
		 * @param uid
		 * @param type
		 * 
		 */		
		public static function removeUI(uid:String, type:String):void
		{
			var lis:Dict = UIManager[type];
			if(lis.isHaveItem(uid)) lis.DeleteItem(uid);	
		}
		/**
		 *得到某一类UI的缓存列表 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getUILis(type:String):Dict
		{
			var lis:Dict = UIManager[type];
			return lis;
		}
		
		public static function getUIFromPool(type:String):ViewBase
		{
			var pool:Pool = UIManager[type];
			return pool.getItem() as ViewBase;
		}
		public static function addUIToPool(type:String, itm:Object):void
		{
			var pool:Pool = UIManager[type];
			pool.returnItem(itm);
		}
		
		public static function getUIFromDict(uiType:String, viewId:String):ViewBase
		{
			var lis:Dict = getUILis(uiType);
			if(lis.isHaveItem(viewId)) return lis.getItem(viewId);
			return null;	
		}
 
		
		
		public static function ShowPopUI(popUIType:String, meditorClass:Class):void
		{
			var popUI:ViewBase = getUIFromDict(UIManager.Type_Pop, popUIType);
			if(popUI && popUI.parent) return;
			if(!popUI )
			{
				var assets:SpriteAsset = MaterialManager.getInstance().getViewMaterial(popUIType);
				popUI = new ViewBase(assets);
				
				UIManager.addUIToDict(popUIType, popUI, UIManager.Type_Pop);
			}
			
			var ctr:PopUIMeditor = MeditorManager.getMeditor(popUI.uid) as PopUIMeditor;
			if(!ctr)
			{
				ctr = new meditorClass(popUI);
				MeditorManager.addMeditor(popUI.uid, ctr);
			}
			
			var layer:Sprite = ModelLocator.getInstance().game.layer_pop;
			layer.addChild(popUI);
			ctr.refresh();
			
			GlobalUtil.setCenterPos(layer, popUI);
 
		}
		
		
	}
}

class SingleTon {}