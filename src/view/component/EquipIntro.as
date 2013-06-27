
package view.component
{
	import core.view.ViewBase;
	
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	import model.vo.EquipVO;
	
	import utils.GlobalUtil;
	
	import view.tile.EquipTile;
	
	
	/**
	 *
	 * EquipIntro.as class. 
	 * @author Administrator
	 * Created 2013-6-6 上午10:47:37
	 */ 
	public class EquipIntro extends ViewBase
	{ 
		public var curEquip:EquipTile;
		public var desTxt:TextField;
		public var nameTxt:TextField;
		public var lvTxt:TextField;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function EquipIntro()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_EquipIntro));
			
			desTxt = asset['dsc_txt'];
			nameTxt = asset['name_txt'];
			lvTxt = asset['lv_txt'];
			
			curEquip = GlobalUtil.createChildDisObj(this, EquipTile, 14,15) as EquipTile;
		} 
		
		public function showEquip(vo:EquipVO):void
		{
			curEquip.data = vo;
			desTxt.htmlText = vo.Detail;
			nameTxt.htmlText = vo.Name
			lvTxt.htmlText = vo.lv.toString();
		}
		
	}
	
}