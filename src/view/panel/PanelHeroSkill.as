
package view.panel
{
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import view.scene.SceneBase;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-20 下午10:18:23
	 */ 
	public class PanelHeroSkill extends SceneBase
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelHeroSkill()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_HeroSKill));
		} 
		
		
		
	}
	
}