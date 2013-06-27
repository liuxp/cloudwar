
package view.panel
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import model.config.AssetsCfg;

	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * PanelDrunk.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-6 下午8:35:16
	 * @history 05/00/12,
	 */ 
	public class PanelDrunk extends PanelBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelDrunk()
		{
			super();
			
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function initUI():void {
			this.mouseEnabled = true;
			this.mouseChildren = true;
			
			var bm:Bitmap = _MM.getViewMaterial(AssetsCfg.UI_bg_tavern_0) as Bitmap;
			this.addChild(bm);
			
			this.asset = _MM.getViewMaterial(AssetsCfg.UI_Drunk) as Sprite;
			this.addChild(this.asset);
			this.set_btn_back();
			
			//遮罩黑色覆蓋動畫
			//this.set_mask_a();
			
		}
		override public function nextClip():void {
			
			this.set_mask_a(true);
		}
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}