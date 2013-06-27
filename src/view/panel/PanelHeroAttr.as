
package view.panel
{
	import control.view.HeroAttrMeditor;
	
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	import model.vo.GeneralVO;
	
	import utils.GlobalUtil;
	
	import view.component.ProcessBar;
	import view.component.ProgressBar;
	import view.scene.SceneBase;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelHeroAttr extends SceneBase
	{ 
		public var bar_hp:ProgressBar;
		public var bar_atk:ProgressBar;
		public var bar_def:ProgressBar;
		public var bar_mov:ProgressBar;
		public var bar_crit:ProgressBar;
		public var bar_rate:ProgressBar;
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelHeroAttr()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_HeroAttr));
			
			this.bar_hp = GlobalUtil.createChildDisObj(this, ProgressBar) as ProgressBar;
			this.bar_atk = GlobalUtil.createChildDisObj(this, ProgressBar, 0, 33) as ProgressBar;
			this.bar_def = GlobalUtil.createChildDisObj(this, ProgressBar, 0, 67) as ProgressBar;
			this.bar_mov = GlobalUtil.createChildDisObj(this, ProgressBar, 0, 101) as ProgressBar;
			this.bar_crit = GlobalUtil.createChildDisObj(this, ProgressBar, 0, 136) as ProgressBar;
			this.bar_rate = GlobalUtil.createChildDisObj(this, ProgressBar, 0, 171) as ProgressBar;
			
			init();
			
			new HeroAttrMeditor(this,[_ML.monarch_character, _ML.selEquip]);
		} 
		
		override protected function init():void
		{
			super.init();
		}
		
	}
	
}