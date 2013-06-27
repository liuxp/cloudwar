package view.panel
{
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import view.scene.SceneBase;

	public class PanelEntry extends SceneBase
	{
		public function PanelEntry()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_main_a));
		}
	}
}