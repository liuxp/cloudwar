
package component.ui.tiles
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 * TileList.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-18 上午11:46:26
	 * @history 05/00/12,
	 */ 
	public class TileList extends ListUIBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _tilesPool:Vector.<Tile>;
		
		
		public var layers:Vector.<Sprite>;
		private var _curPage:int;
		private var _minPos:int;
		private var _maxPos:int;
		//--------------------------------------------------------------------------
		public function TileList()
		{
			super();
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------

		override public function set rowHeight(value:int):void
		{
			super.rowHeight = value;
		}
		
		override public function set columnWidth(value:int):void
		{
			super.columnWidth = value;
		}
		
		public function setMarginPos():void
		{
			if(this.align == TileVariables.Align_Horizontal)
			{
				this._maxPos = this.column * this.columnWidth;
				this._minPos = -this.column * this.columnWidth;
			}else{
				this._maxPos = this.row * this.rowHeight;
				this._minPos = -this.row * this.rowHeight;
			}
			
		}
		
		public function setLayerOut():void
		{
			var centerLayer:DisplayObject = layer.getChildByName(this._curPage.toString());//当前显示层
			var leftLayer:DisplayObject = layer.getChildByName((this._curPage-1).toString());//左侧
			var rightLayer:DisplayObject = layer.getChildByName((this._curPage+1).toString());//右侧

			if(this.align == TileVariables.Align_Horizontal)
			{
				centerLayer.x = 0;
				rightLayer.x = this.column * this.columnWidth;
				leftLayer.x = -this.column * this.columnWidth;
			}else{
				centerLayer.y = 0;
				rightLayer.y = this.row * this.rowHeight;
				leftLayer.y = -this.row * this.rowHeight;
			}	 

		}
		
		public function resizeLayer():void
		{
			var len:int = this.layer.numChildren;
			for(var i:int; i<len; i++)
			{
				var _view:DisplayObject = this.layer.getChildAt(i);
				//最小位置
				if(_view.x < this._minPos 
					&& this.align == TileVariables.Align_Horizontal){
					
					_view.x = this._maxPos;
					
				}else if(_view.y < this._minPos 
					&& this.align == TileVariables.Align_Horizontal){
					
					_view.y = this._maxPos;
				}
				
				//最大位置
				if(_view.x > this._minPos 
					&& this.align == TileVariables.Align_Horizontal){
					
					_view.x = this._minPos;
					
				}else if(_view.y > this._minPos 
					&& this.align == TileVariables.Align_Horizontal){
					
					_view.y = this._minPos;
				}
			}
		}
		
		public function cleanLayer(_layer:Sprite):void
		{
			while(_layer.numChildren)
			{
				var tile:Tile = _layer.removeChildAt(0)as Tile;
				this.returnTile(tile);
			}
		}
		
		
		
		
		
		override protected function init():void
		{
			
			super.init();
			/*layers = new Vector.<Sprite>;
			
			for(var i:int; i<3; i++)
			{
				var spr:Sprite = new Sprite;
				layer.addChild(spr);
				layers.push(spr);
				spr.graphics.clear();
				spr.graphics.beginFill(0x333333);
				//this.graphics.drawCircle(0,0,circle);
				spr.graphics.drawRect(0,0,100,100);
			}*/
			

			
		}

		override public function show():void
		{
			this.setTilesPool();
			setMarginPos();
			
			for(var i:int=1; i<=this.pages; i++)
			{
				Show(i,this.layer);
			}
			
			/*_curPage = 1;
			Show(this._curPage,this.layers[1]);
			Show(this._curPage-1,this.layers[0]);
			Show(this._curPage+1,this.layers[2]);
			
			this.setLayerOut();*/
		}
		
		public function Show(page:int, _layer:Sprite):void
		{
			/*cleanLayer(_layer);
			_layer.name = page.toString();*/
			
			if(pages<1 || page > pages) return;

			var items:Array = this.getDatasByPage(page);
			var len:int = items.length;
			
			for(var r:int; r<row; r++)
			{
				for(var c:int=0; c<column; c++)
				{
					var itm:Tile = this.getTile();

					var index:int = r*column + c;
					
					trace(index);
					if(index >= len) return;
					
					itm.data = items[index];
					
					itm.x = c * this.columnWidth; 
					itm.y = r * this.rowHeight;
					
					if(this.align == TileVariables.Align_Horizontal)
					{
						itm.x += _maxPos*(page-1);
					}else{
						itm.y += _maxPos*(page-1);
					}
					
					_layer.addChild(itm);
				}
			}
		}
		
		private function setTilesPool():void
		{
			if(!pages || this._tilesPool) return;
			
			var pageNum:int = this.column*this.row;
			var len:int = pageNum*pages;
			
			this._tilesPool = new Vector.<Tile>;
			
			while(len>0)
			{
				this._tilesPool.push( new renderClass);
				len--;
			}
		}
		
		public function getTile():Tile
		{
			return this._tilesPool.pop();
		}
		
		public function returnTile(render:Tile):void
		{
			this._tilesPool.unshift(render);
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