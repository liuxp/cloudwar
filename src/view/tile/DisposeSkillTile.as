package view.tile
{
	import component.ui.tiles.Tile;
	
	import core.view.ViewBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	
	import model.GeneralModel;
	import model.SkillModel;
	import model.config.AssetsCfg;
	import model.vo.EquipVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GlobalUtil;
	
	import view.component.GameIcon;
	
	
	/**
	 *
	 * EquipTile.as class. 
	 * @author Administrator
	 * Created 2013-5-25 下午4:30:03
	 */ 
	public class DisposeSkillTile extends Tile
	{ 
		private var _icon:GameIcon;
		private var _nameTxt:TextField;
		
		private var _iconContainer:Sprite;
		private var _energyTxt:TextField;
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function DisposeSkillTile()
		{
			_icon = new GameIcon;
			var asset:Object = MaterialManager.getInstance().getViewMaterial(AssetsCfg.HeroSkill);
			var skillUI:ViewBase = new ViewBase(asset as DisplayObject);
			addChild(skillUI);
			asset.mask_mc.visible = false;;
			_iconContainer = asset.icon_mc;
			_iconContainer.addChild(_icon);
			_energyTxt = asset.energy_txt;
		} 
		
		override public function set data(value:Object):void
		{
			super.data = value;
			var mod:SkillModel = value as SkillModel;
			var vo:SkillVO = mod.getVO() as SkillVO;
			_icon.show(AssetsCfg.SkillIcon, vo.id);
			_energyTxt.text = vo.mp.toString();;
			
		}
		
	}
	
}