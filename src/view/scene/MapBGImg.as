package view.scene
{
	import component.Dict;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import manager.MaterialManager;
	import manager.ModelLocator;
	
	import utils.GlobalUtil;
	
	
	public class MapBGImg extends ViewBase
	{
		
		private var _GameBg :Sprite;
		private var _MM : MaterialManager = MaterialManager.getInstance();
		private var _ML:ModelLocator = ModelLocator.getInstance();
		
		public function MapBGImg()
		{
			
			_GameBg = new Sprite();
			addChild(_GameBg);
			
			this.mouseChildren =false;
		}
		
		public function drawBg(BgName:String, size:int):void
		{
			GlobalUtil.removeAllChild(_GameBg);
			
			var bm:Bitmap = _MM.getMapMaterial(BgName);
			for(var i:int; i<size; i++)
			{
				var tmp_bm:Bitmap = new Bitmap(bm.bitmapData);
				_GameBg.addChild(tmp_bm);
				tmp_bm.x = i*bm.width;
			}
			/*_GameBg.graphics.beginBitmapFill(bm.bitmapData)
			_GameBg.graphics.drawRect(0,0,bm.bitmapData.width*5, bm.bitmapData.height);
			*/

			
			

			
			
			var stageW:int =  this.stage.stageWidth
			_ML.camera.x_margin = stageW>>1;
			/*_ML.camera.x_marginL = stageW/4;
			_ML.camera.x_marginR = stageW/4 *3;*/
			_ML.camera.x_marginL =stageW>>1;
			_ML.camera.x_marginR = stageW>>1;
			_ML.camera.x_max = -(_GameBg.width - stageW);
			
			_ML.camera.x_left = 80;
			_ML.camera.x_right = _GameBg.width - 80;
			_ML.camera.y_top = 160;
			_ML.camera.y_bottom = 360;
		}
		
		public function addImg(bit:BitmapData, matrix:Matrix):void
		{
			/*this._GameBg.bitmapData.draw(bit, matrix);
			bit.dispose();
			matrix = null;*/
		}
	}
}