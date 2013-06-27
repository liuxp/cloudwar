package view.scene
{
	import core.view.ViewBase;
	
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	import manager.ModelLocator;
	import manager.UIManager;
	
	import model.config.AssetsCfg;
	
	import utils.EffectUtil;
	
	public class SceneBase extends ViewBase
	{
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		protected var _MM:MaterialManager = MaterialManager.getInstance();
		
		public function SceneBase(asset:DisplayObject=null)
		{
			super(asset);
		}
		
		public function remove(destroy:Boolean=false):void
		{
			EffectUtil.Fade_Out(this, cleanUp, [destroy]);
		}
		
		public function show():void
		{
			EffectUtil.Fade_In(this);
		}
		
		protected function cleanUp(destroy:Boolean):void
		{
			if(destroy)
			{
				this.dispose();
			}else{
				this.removeFromParent();
				this.alpha = 1;
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			this._ML = null;
			this._MM = null;
		}
	}
}