package component
{
	import flash.utils.Dictionary;
	/**
	 * 字典表
	 * 便于查找，添加和修改里面的元素
	 * leo*/
	public class Dict
	{
		private var _dict : Dictionary;
		
		public function Dict(weakKeys:Boolean=true)
		{
			_dict = new Dictionary(weakKeys);
		}
		
		public function get dict():Dictionary
		{
			return _dict;
		}
		public function toArray():Array
		{
			var arr : Array = [];
			for(var i:* in _dict)
			{
				arr.push(_dict[i]);
			}
			return arr;
		}
		/**添加元素*/
		public function AddItem(key:String, itm : *):void
		{
			if(_dict[key]==null)
			{
				_dict[key]= itm;
			}else {
				throw new Error('key:' + key + ' has already added')
			} 
		}
		/**删除元素*/
		public function DeleteItem(key:String):void
		{
			if(_dict[key]!=null)
			{
				_dict[key]= null;
				delete _dict[key];
			}else{
				throw new Error('key:' + key + 'has not added')
			} 
		}
		/**查找元素*/
		public function getItem(key:String):*
		{
			if(_dict[key]== null)
			{
				throw new Error('key: ' + key + ' has not added');
				
			}
			return _dict[key]
			 
		}
		/**是否含有指定元素*/
		public function isHaveItem(key:String):Boolean
		{
			return _dict[key] != null;
		}
		/**修改指定元素*/
		public function setItemValue(key:String,value:*):void
		{
			if(_dict[key]== null)
			{
				throw new Error('key:' + key + 'has not added');
				
			}
			_dict[key]= value;
		}
		/**删除所有元素*/
		public function DeleteAllItms():void
		{
			for(var i:String in this._dict)
			{
				DeleteItem(i);
			}
		}
		
		public function isEmpty():Boolean
		{
			for(var key:String in this._dict)
			{
				if(_dict[key]) return false;
			}
			
			return true;
		}
	}
}