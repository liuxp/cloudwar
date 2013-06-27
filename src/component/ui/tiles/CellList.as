package component.ui.tiles
{
	import component.Pool;

	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	
	
	
	
	/**
	 * TileList.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-18 上午11:46:26
	 * @history 05/00/12,
	 */ 
	public class CellList extends ListUIBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _tilesPool:Vector.<Tile> = new Vector.<Tile>;
		//--------------------------------------------------------------------------
		public function CellList()
		{
			super();
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------

		override public function show():void
		{
			returnAllTiles();
			
			if(!pages) return;
			
			layer.x = 0;
			layer.y = 0;
			
			var index:int;
			var len:int = this.dataList.length
			for(var p:int=0; p< pages; p++)
			{
				for(var r:int=0; r< row; r++)
				{
					for(var c:int=0; c< column; c++)
					{
						var itm:Tile = this.getTile();
						
						index = r* column + c + p*( row * column);
						
						trace('tile_index:', index);
						if(index >= len) return;
						
						itm.data = _dataList[index];
						if(this.align == TileVariables.Align_Horizontal)
						{
							itm.x = c * this.columnWidth + p* columnWidth* column;
							itm.y = r * this.rowHeight;
						}else{
							itm.x = c * this.columnWidth 
							itm.y = r * this.rowHeight + p* rowHeight* row;;
						}
						
						itm.index = index;
						layer.addChild(itm);
					}
				}
			}
			
		}
		
		protected function getTile():Tile
		{
			if(!_tilesPool.length)
			{
				this._tilesPool.push( new renderClass);
			}
			
			return this._tilesPool.pop();
		}
		
		protected function returnTile(render:Tile):void
		{
			this._tilesPool.unshift(render);
		} 
		
		protected function returnAllTiles():void
		{
			var len:int = layer.numChildren-1;
			while(len>-1)
			{
				var tile:Tile = layer.removeChildAt(0)as Tile;
				returnTile(tile);
				len--;
			}
		}
		
		override public function clear():void
		{
			while(_tilesPool.length)
			{
				_tilesPool.pop().clear();
			}
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
		public function getTileByData(data:Object):Tile
		{
			var len:int = layer.numChildren-1;
			while(len>-1)
			{
				var tile:Tile = layer.getChildAt(0)as Tile;
				var _data:Object = tile.data;
				if(data.id == tile.data.id) return tile;
				len--;
			}
			return null;
		}
		
		
		
		
	}
	
}