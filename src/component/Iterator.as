package component
{
	/**
	 * 迭代器
	 * */
	public class Iterator
	{
		private var _index : int = -1;
		private var _list : Array;
		private var _count : int;
		private var _isloop:Boolean;
		
		public function Iterator(lis:Array, loop:Boolean=true)
		{
			_list = lis;
			_count = _list.length-1;
			_isloop = loop;
		}
		
		public function get items():Array
		{
			return _list;
		}
		
		public function reset():void
		{
			_index = -1;
		}
		
		public function getItm(index:int):Object
		{
			if(isHasItm(index)) return _list[index];
			return null;
		}
		
		public function setIndex(value:int):void
		{
			_index = value;
		}
		private function isHasItm(index:int):Boolean
		{
			return index < _list.length && index > -1;  
		}
		
		public function getPrevItm():Object
		{
			_isloop ? _index = _index-1 < -1 ? _count : _index-1
					: _index = _index-1 < 0 ? 0 : _index-1
					
			return _list[_index];
		}
		
		public function getNextItm():Object
		{
			_isloop ? _index = _index+1 > _count ? 0 : _index+1
					: _index = _index+1 > _count ? _count : _index+1;
					
			return _list[_index];
		}
		
		public function clear():void
		{
			_count = 0;
			_list = null;
			
		}
	}
}