
package view.component
{
	import control.view.sheet.SheetLoopMeditor;
	
	import core.view.ViewBase;
	
	import flash.display.Sprite;
	
	import model.config.AssetsCfg;
	
	import view.character.SheetSprite;
	
	
	/**
	 *
	 * SelectedState.as class. 
	 * @author Administrator
	 * Created 2013-6-14 下午2:11:41
	 */ 
	public class SelectedState extends ViewBase
	{ 
		private var selEff:SheetSprite;
		private var _ctr:SheetLoopMeditor;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function SelectedState()
		{
			selEff = new SheetSprite(AssetsCfg.Eff_selected);
			_ctr = new SheetLoopMeditor(selEff);
			addChild(selEff);
			
			init();
		} 
		
		public function show():void
		{
			
			//_ctr.renderStart();
		}
		
		public function stop():void
		{
			//_ctr.renderStop();
		}
		
		override public function dispose():void
		{
			//_ctr.clear();
			selEff.dispose();
			
			super.dispose();
			
			this.selEff = null;
			this._ctr = null;
		}
	}
	
}