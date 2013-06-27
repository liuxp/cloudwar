
package view.dispose
{
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.component.GameIcon;
	import view.scene.SceneBase;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午10:18:23
	 */ 
	public class DisposeBase extends ViewBase
	{ 
		protected var _bg:Sprite;
		protected var _layer:Sprite;
		protected var _bgReset:Sprite;
		protected var _bgSelect:Sprite;
		protected var _icon:GameIcon;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function DisposeBase()
		{
			_bg = GlobalUtil.createContainer(this,false,false);
			_layer = GlobalUtil.createContainer(this,true,false);
			
			_icon = GlobalUtil.createChildDisObj(_layer, GameIcon) as GameIcon;
		} 
		
		public function showTitle(name:String):void
		{
			_icon.showImg(name);
			_icon.x = _bg.width - _icon.width - 20;
			_icon.y = 20;
		}
		private function createBg(type:String, W:int, H:int, container:Sprite):Sprite
		{
			var bg:Sprite = MaterialManager.getInstance().getViewMaterial(type);
			bg.width = W;
			bg.height = H;
			container.addChild(bg);
			return bg;
		}
		
		public function select():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = true;
			
			if(_bgReset && _bgReset.parent) _bg.removeChild(_bgReset);
			if(!_bgSelect)_bgSelect = this.createBg('Scale9_Blue',464,144,_bg);
			else if(!_bgSelect.parent) _bg.addChild(_bgSelect);
			
			
			this._layer.y = _bg.height - this._layer.height >>1;
			
			
		}
		
		public function reset():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = false;
			
			if(_bgSelect && _bgSelect.parent) _bg.removeChild(_bgSelect);
			if(!_bgReset)_bgReset = this.createBg('Scale9_Brown',464,88,_bg);
			else if(!_bgReset.parent) _bg.addChild(_bgReset);
			
			if(this._bgSelect && this._bgReset)
			{
				this._layer.y = _bg.height - this._layer.height >>1;
			}
			/*trace('this.height: ', this.height);
			trace('this._layer.y: ', this._layer.y)*/
		}
	}
	
}
