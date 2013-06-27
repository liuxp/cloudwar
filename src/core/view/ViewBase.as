package core.view
{
	
	import core.UID;
	import core.meditor.MeditorBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.core.SpriteAsset;
 
	/**
	 * 视觉基类
	 * */
	public class ViewBase extends Sprite
	{
		private var _uid : String;
		public var asset:DisplayObject;
		
		public function get uid():String{ return _uid};
		
		public function ViewBase(asset:DisplayObject=null)
		{
			if(asset)
			{
				this.asset = asset;
				addChild(asset);
			}
			
			initUID();
		}
		
		
		
		//初始化
		protected function init():void
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
		}
		
		/*public function setControl(value:MeditorBase):void
		{
			_ctr = value;
		}
		
		public function removeControl(value:MeditorBase):void
		{
			_ctr = null;
		}*/
		private function initUID():void
		{
			_uid = UID.createUID();
			this.name = _uid;
		}
		
		public function removeFromParent():void
		{
			if(this.parent && this.parent.contains(this))
			{
				this.parent.removeChild(this);
			}
		}
		
		
		public function dispose():void
		{
			this.removeFromParent();
			//this.removeChildren();
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			
			this.asset = null;
		}
	}
}