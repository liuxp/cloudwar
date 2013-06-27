package utils
{
	/**列表元素查找、删除、排序
	 * */
	 
	
	public class SearchUtil
	{
		/**在model列表中，通过model的某一个属性来找到model liuxp 2010/7/23*/
		static public function getItemByVOFromList(key:* , value:*, list:*):Object
		{
			if(!key || value==null || !list || list.length<1) return null;
			for each(var i:* in list)
			{
				if(i==null ) continue;
				if(key is String)
				{
					if(i[key] == value) return i;
				}else if(key is Array)
				{
					
					var b:Boolean = true;
					for(var k:uint=0; k<key.length; k++)
					{
						if(i[key[k]] != value[k])
						{
							b = false;
							break;
						} 
					}
					if(b)
					{
						return i;
					}
				}
				
			}
			return null;
		}
		/**在model列表中，通过model的某一个属性来找到model在列表中的索引 liuxp 2010/7/23*/
		static public  function getItemIndexByVO(key:String, value:*, list:*):int
		{
			var index : int = -1;
			for(var i:uint,len:uint=list.length; i<len; i++)
			{
				var itm : Object = list[i];
				if(itm[key] == value)
				{
					index = i;
					break;
				} 
			}
			return index;
		}	
		static public function getItemByVOFromArr(value : *, arr : Array):*
		{
			if(value==null || !arr || arr.length<1) return null;
			for each(var i:* in arr)
			{
				if(i==null ) continue;
				if(i == value) return i;
			}
			return null;
		}
		/**在model列表中，通过子model的某一个属性来找到匹配的元素 
		 * @param key1  父model的键值
		 * @param key2  子model的键值
		 * @param value 匹配key2的值
		 * @param list 
		 * @ return 
		 * liuxp 2011/2/23*/
		static public function getItemByChildKeyFromList(key1:String, key2: *, value:*, list :*):Object
		{
			if(!key1 || !key2 || value ==null || !list || list.length<1) return null;
			for each(var i:Object in list)
			{
				if(key1 in i)
				{
					var j:Object = i[key1];
					if(key2 is String)
					{
						if(j[key2] == value) return i;
					}else if(key2 is Array)
					{
						var b:Boolean = true;
						for(var k:uint=0; k<key2.length; k++)
						{
							if(j[key2[k]] != value[k])
							{
								b = false;
								break;
							} 
						}
						if(b)
						{
							return i;
						}
					}
					
				} 
			}
			return null;
		}
		/**在model列表中，通过子model的某一个属性来找到匹配的列表 
		 * @param key1  父model的键值
		 * @param key2  子model的键值
		 * @param value 匹配key2的值
		 * @param list 
		 * @ return 
		 * liuxp 2011/2/23*/
		static public function getItemListByChildKeyFromList(key1:String, key2:*, value:*, list:*):*
		{
			if(!key1 || !key2 || value ==null || !list || list.length<1) return null;
			var tmpList : Array = [];
			for each(var i:Object in list)
			{
				if(key1 in i)
				{
					var j:Object = i[key1];
					if(key2 is String)
					{
						if(j[key2] == value){		 
							tmpList.push(i);
						}
					}else if(key2 is Array)
					{
						var b:Boolean = true;
						for(var k:uint=0; k<key2.length; k++)
						{
							if(j[key2[k]] != value[k])
							{
								b = false;
								break;
							} 
						}
						if(b)
						{
							tmpList.push(i);
						}
					}
					
				} 
			}
			return tmpList;
		}
		/**在model列表中，通过model的某一个属性来找到匹配的列表 liuxp 2010/7/30*/
		static public function getItemListByVOFromList(key:String , value:*, list:*):*
		{
			if(!key ||  value ==null || !list || list.length<1) return null;
			var tmpList : Array = [];	
			for each(var i:Object in list)
			{
				if(i[key] == value) 
				{
					tmpList.push(i);
				}
			}
			return tmpList;
		}
		/**在含有model某一属性值的列表中，通过model的对应属性来找到匹配的列表 
		 * @param key 键值
		 * @param valueList 属性值列表
		 * @param itemList 匹配key和value的对象列表
		 * @return
		 * liuxp 2011/10/31*/
		
		static public function getItemListByVOFromValueList(key:String, valueList : Array, itemList:Array):Array
		{
			var list : Array  = [];
			for each(var i:String in valueList)
			{ 
				var itm : Object = SearchUtil.getItemByVOFromList(
									key , i, itemList);
				if(itm)
				{
					list.push(itm);
				}					
			}
			return list;
		}
		/**
		 *通过键值列表得到所有匹配的元素列表 
		 * @param keys
		 * @param values
		 * @param list
		 * @return 
		 * 
		 */		
		static public function getItemListByKeysFromList(keys:Array,values:Array,list:Array):Array
		{
			var arr:Array = [];
			for each(var itm:Object in list)
			{
				var isMatch:Boolean = true;
				
				for(var i:int=0; i<keys.length; i++)
				{
					
					var key:String = keys[i];
					
					var value :* = values[i];
					
					if(itm[key] != value)
					{
						isMatch = false;
						break;
					}
				}
				
				if(isMatch) arr.push(itm);
			}
			return arr;
		}
		/**在所匹配的列表中，通过属性得到属性值列表
		 * @param key1 列表中要匹配元素的属性
		 * @param key2 所得到的匹配列表中再次匹配的属性
		 * @param value 匹配元素的属性值
		 * @param itemList 元素列表
		 * @return
		 * */
		static public function getItemValueListByVOFromList(key1:String, key2:String, 
															value:*, itemList:Array):Array
		{
			var list : Array = [];
			var tmpList : Array = SearchUtil.getItemListByVOFromList(
									key1 , value, itemList);
				for each(var itm : Object in tmpList)
				{
					list.push(itm[key2]);
				}					
			
			return list;
		}
		/**删除列表元素 
		 * @param item 列表元素
		 * @param lis  
		 * liuxp 2011/10/31*/
		static public function delItemFromList(item:*, lis:*):*
		{
			if(!item || !lis || !lis.length) return lis;
			for (var i:uint, len:uint = lis.length; i<len; i++)
			{
				
				if(item == lis[i])
				{
					 
					lis.splice(i,1);
					 
					break;
				}
			}
			return lis;
		}
		static public function delItemByVOFromList(key:String, value:*, list:*):*
		{
			if(!key || !value || !list) return null;
			var itm : Object = SearchUtil.getItemByVOFromList(key, value, list);
			if(!itm) return null;
			return SearchUtil.delItemFromList(itm, list);
		} 
		
		static public function ObjToArray(obj:Object, id:String=null):Array
		{
			var arr : Array = [];
			for(var key : String in obj)
			{
				var itm : Object = obj[key];
				if(id) itm[id] = key;
				arr.push(itm);
			}
			return arr;
		}
		 			
	}
}