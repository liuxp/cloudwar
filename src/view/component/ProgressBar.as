
package view.component
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import core.view.ViewBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	
	/**
	 *
	 * ProgressBar.as class. 
	 * @author Administrator
	 * Created 2013-6-5 下午2:53:50
	 */ 
	public class ProgressBar extends ViewBase
	{ 
		private var _pro_txt:TextField;
		private var _add_txt:TextField;
		private var _bar:Sprite;
		private var _percent:Number;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function ProgressBar()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_BarHeroAttr));
			
			this._pro_txt = asset['pro_txt'];
			this._add_txt = asset['add_txt'];
			this._bar = asset['bar_mc'];
		} 
		
		public function update(cur:int, max:int, add:int=0):void
		{
			var percent:Number = cur / max; 
			if(_percent != percent)
			{
				_percent = percent;
				TweenMax.to(_bar,0.5,{scaleX: percent, ease:Strong.easeOut});
			}
			//_bar.scaleX = percent;
			
			this._pro_txt.text = cur.toString();
			if(add) this._add_txt.text = '+' + add.toString();
			else this._add_txt.text = '';
		}
		
	}
	
}