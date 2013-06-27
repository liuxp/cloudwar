
package component.ui.tiles
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	/**
	 *
	 * ListUIBase.as class. 
	 * @author Administrator
	 * Created 2013-4-22 下午5:06:00
	 */ 
	public class ListUIBase extends Sprite
	{ 
		public var row:int=1;
		public var column:int=1;
		protected var _dataList:Array;
		private var _rowHeight:int;
		private var _columnWidth:int;
		public var pages:int;
		public var layer:Sprite;
		public var renderClass:Class;
		public var align:String = TileVariables.Align_Horizontal;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function ListUIBase()
		{
			init();
		} 
		
		public function get dataList():Array
		{
			return _dataList;
		}

		public function get columnWidth():int
		{
			return _columnWidth;
		}

		public function set columnWidth(value:int):void
		{
			_columnWidth = value;
		}

		public function get rowHeight():int
		{
			return _rowHeight;
		}

		public function set rowHeight(value:int):void
		{
			_rowHeight = value;
		}

		public function setScrollRect(w:int, h:int):void
		{
			this.scrollRect = new Rectangle(0,0,w,h);
		}
		
		public function dataProvider(list:Array):void
		{
			this._dataList = list;
			this.pages = getPages();
		}
		
		protected function init():void
		{
			
			layer = new Sprite();
			addChild(layer);
		}
		
		protected function getPages():int
		{
			if( !this.dataList || !this.dataList.length
				||!this.column || !this.row) return 0;
			
			return Math.ceil( this.dataList.length / (this.column * this.row));
		}
		
		public function getDatasByPage(page:int):Array
		{
			
			var len:int = this.row * this.column;
			var index:int = (page-1)* len
			var curLis:Array = dataList.slice(index, index+len);
			return curLis;
		}
		
		public function show():void
		{
			
		}
		
		public function clear():void
		{
			
		}
	}
	
}