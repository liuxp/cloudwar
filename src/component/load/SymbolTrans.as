package component.load
{
	import model.config.load.type.LoadSymbolConfig;
	import model.config.symbol.SymbolConfig;
	import model.config.symbol.SymbolHairConfig;
	
	/**
	 * 加载swf内的元件赋值
	 * leo
	 * */
	public class SymbolTrans extends BitTrans
	{
		public function SymbolTrans(data:Object)
		{
			super(data);
		}
		
		override public function getTansData():void
		{
			var symbolInfo : Array = _name.split('_');
			var symbolList:Array;
			
			/**找到库链接名列表*/
			switch(symbolInfo[symbolInfo.length-1])
			{
				case 'head' :
				case 'body' :
					symbolList = SymbolConfig[_name];
					break;
				case 'hair' :
					symbolList = SymbolHairConfig[_name];
					break;
				default :
					symbolList = SymbolConfig[_name];
					break;		
			}
   		 	
   		 	
   		 	for each(var className:String in symbolList)
   		 	{
   		 		var key : String = _name.split('_')[0];
   		 		
   		 		var instanceClass : Class = _content.loaderInfo.applicationDomain.getDefinition(className)as Class;
   		 		//trace(instanceClass+"..................");
   		 		//trace(_SymbolAll[key]);
   		 		
   		 		_SymbolAll[key][className] = instanceClass;
   		 	} 
   		 	
   		 	 
   		 	
		}
	}
}