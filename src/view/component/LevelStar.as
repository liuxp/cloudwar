
package view.component
{
	import component.Pool;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	
	/**
	 *
	 * LevelStar.as class. 
	 * @author Administrator
	 * Created 2013-5-29 下午7:00:04
	 */ 
	public class LevelStar extends ViewBase
	{ 
		private var _starPool:Pool;
		private var _maxLv:int =3;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function LevelStar()
		{
			
			_starPool = new Pool(Bitmap,_maxLv);
		} 
		
		public function showStars(num:int):void
		{
			clearStars();
			
			var empty:int = _maxLv - num;
			var stars:int = _maxLv - empty;
			var index:int;
			var bm:Bitmap;
			var itm:Bitmap;
			 
			for(var i:int; i<this._maxLv; i++)
			{
				var type:String = i<stars ? 'LevelStar' : 'LevelEmpty';
				bm = MaterialManager.getInstance().getMapMaterial(type);
				itm = this._starPool.getItem() as Bitmap;
				itm.bitmapData = bm.bitmapData;
				itm.x = i*(bm.width); 
				
				this.addChild(itm);
			}
		}
		
		public function clearStars():void
		{
			while(this.numChildren)
			{
				var bm:Bitmap = this.removeChildAt(0) as Bitmap;
				_starPool.returnItem(bm);
			}
		}
	}
	
}