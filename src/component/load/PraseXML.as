package component.load
{
	import events.LoadEvent;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display3D.IndexBuffer3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	import manager.MaterialManager;
	
	import model.config.sheet.GameMaterial;
	import model.config.sheet.XMLCfg;
	
	//[Event(name="LoadMultiComplete", type="flash.events.Event")]
	
	/**loading加载
	 * 单行加载
	 * 
	 * */
	public class PraseXML extends EventDispatcher
	{
		
		
		private var _xmlCfg : Array; //加载配置列表
		private var _xmlLis : Array; //当前加载列表
		private var _totalCount : int; //加载总长度
		private var _Count : int; //累计加载长度
		private var _Desc : String; //加载描述
		private var _format:String; //解析格式
		private var _key:String;
		private var _symbol : String;
		
		private var _symbolAll : MaterialManager = MaterialManager.getInstance();
		
		
		public static const SWFURL : String = 'assets/swf/';
		public static const TxtURL : String =  'assets/xml/';
		
		public function PraseXML()
		{
		}
		
		public function setXmlSymbol(symbol:String):void
		{
			_symbol = symbol;
		}
		
		public function setXmlCfg(cfg:Array):void
		{
			_xmlCfg = cfg;
		}
		//开始执行，如果没有xml配置文件则先获得xml配置文件
		public function exectue():void
		{
			if(!_xmlCfg)
			{
				var classXml : Class = XMLCfg[_symbol];
				var xml:XML = XML(new classXml());
				_xmlCfg = XMLEditor.getLoadCfgLis(xml);
				
				_totalCount = getLoaTotalCount(_xmlCfg);
			}
			getNextXML();
		}
		/*private function loadProgress(e:ProgressEvent):void
		{
			var progressNum : Number = _loaCount/_loaTotalCount*100;
			
			this.dispatchEvent(new LoadEvent(LoadEvent.LoaFileComplete, 
				progressNum.toString() + '_'
				+ this._loaDesc));
			
		}*/
		
		private function getLoaTotalCount(loaCfg:Array):int
		{
			var count : int;
			for each(var i:Object in loaCfg)
			{
				count += i.list.length;
			}
			return count;
		}
		//得到下一个xml文件
		private function getNextXML():void
		{
			if(!_xmlCfg || !_xmlCfg.length)
			{
				trace('loaCmt');
				_xmlCfg = null;
				_xmlLis = null;
				_Count = 0;
				_totalCount = 0;
				this.dispatchEvent(new LoadEvent(LoadEvent.LoaAllFileComplete));
				return;
			}
			var loaInfo : Object = _xmlCfg.shift();
			_xmlLis = loaInfo['list'];
			_Desc = loaInfo['desc'];
			_format = loaInfo['format'];
			_key = loaInfo['type'];
			var symbol:Object = _xmlLis.shift();
			var symbolStr : String =  symbol.url;
			
			loadFile(symbolStr);
		}
		//根据文件类型加载
		private function loadFile(str:String):void
		{
			if(str.lastIndexOf('XML')==-1)
			{
				getSWFFile();
			}else{
				getXMLFile(str);
			}
			
			checkLoaProgress();
		}
		
		private function getXMLFile(str:String):void
		{
			var symbol:Class = XMLCfg[str];
			var xml:XML = XML(new symbol());
			var cfg : Object;
			cfg = XMLEditor.getSymbolClassCfg(xml);
			_symbolAll.symbolCfg[_key] = cfg;
			
		}
		
		private function getSWFFile():void
		{
			var symbolCfg : Object = _symbolAll.symbolCfg[_key];
			for(var str:String in symbolCfg)
			{
				
				var symbol:Class = GameMaterial[str];
				
//				var mc:Sprite = new symbol() as Sprite;
				
				if(!symbolCfg[str]) symbolCfg[str] = symbol;	
			}
			
			
		}
		
		//检查加载进度，如果该组加载完则进入下一组
		private function checkLoaProgress():void
		{
			this._Count++;
			var progressNum : Number = _Count/_totalCount*100;
			
			this.dispatchEvent(new LoadEvent(LoadEvent.LoaFileComplete, 
				progressNum.toString() + '_'
				+ this._Desc));
			
			
			if(_xmlLis.length)
			{
				var url : String =  _xmlLis.shift();
				loadFile(url);
			}else{
				getNextXML();
			}
		}
	}
}