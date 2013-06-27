package component.load
{
	public class XMLEditor
	{
		public function XMLEditor()
		{
		}
		//得到加载列表
		public static function getLoadCfgLis(xml:XML):Array
		{
			var loaInfo : Array = [];
			var len : int = xml.children().length();
			for(var i:int=0; i<len; i++)
			{
				
				var child : XML = xml.children()[i];
				var loaType : String = child.@name;
				var desc : String = child.@desc;
				var childrenLen : int = child.children().length();
				var loaLis : Array = [];
				for(var j:int=0; j<childrenLen; j++)
				{
					var children : XML =  child.children()[j];
					var symbol : String = children.@url;
					var fmt:String = children.@format;
					var _type:String = children.@type;
					loaLis.push({url:symbol, type:_type});
				}
				
				loaInfo.push({type:loaType, list:loaLis, desc:desc, format:fmt })

			}
			
			return loaInfo;
		}
		
		public static function getSymbolCfg(xml:XML):Object
		{
			var loaInfo : Object = {};
			var len : int = xml.children().length();
			for(var i:int; i<len; i++)
			{
				
				var child : XML = xml.children()[i];
				var loaType : String = child.@name;
				var childrenLen : int = child.children().length();
				var loaLis : Array = [];
				for(var j:int=0; j<childrenLen; j++)
				{
					var children : XML =  child.children()[j];
					var url : String = children.@url;
					loaInfo[url] = null;
				}
				
				

			}
			
			return loaInfo;
		}
		
		public static function getSymbolClassCfg(xml:XML):Object
		{
			var loaInfo : Object = {};
			var len : int = xml.children().length();
			for(var i:int=0; i<len; i++)
			{
				
				var child : XML = xml.children()[i];
				var loaType : String = child.@className;
				loaInfo[loaType] = null;

			}
			
			return loaInfo;
		}
		
		public static function getBmtCfg(xml:XML):Object
		{
			var loaInfo : Object = {};
			var len : int = xml.children().length();
			for(var i:int; i<len; i++)
			{
				
				var child : XML = xml.children()[i];
				var childrenLen : int = child.children().length();
				
				for(var j:int=0; j<childrenLen; j++)
				{
					var children : XML =  child.children()[j];
					var url : String = children.@name;
					loaInfo[url] = null;
				}
				
				

			}
			
			return loaInfo;
		}
		
		public static function getSheetLisByItemStr(str:String, xml:XML):Vector.<XML>
		{
			var lis:Vector.<XML> = new Vector.<XML>();
			var itms:XMLList = xml.children();
			for each(var i:XML in itms)
			{
				var index :int = String(i.@name).indexOf(str);
				if(index != -1) lis.push(i);
			}
			return lis;
		}
	}
}