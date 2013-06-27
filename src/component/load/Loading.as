package component.load
{
	import events.LoadEvent;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	import manager.MaterialManager;
	
	//[Event(name="LoadMultiComplete", type="flash.events.Event")]
	
	/**loading加载
	 * 单行加载
	 * 
	 * */
	public class Loading extends EventDispatcher
	{
		
		
		private var _loaCfg : Array; //加载配置列表
		private var _loaLis : Array; //当前加载列表
		private var _loaTotalCount : int; //加载总长度
		private var _loaCount : int; //累计加载长度
		private var _loaDesc : String; //加载描述
		private var _format:String; //解析格式
		
		private var _url : String;
		
		private var _loaFile : LoadFile = LoadFile.getInstance();
		private var _symbolAll : MaterialManager = MaterialManager.getInstance();

		
		public static const SWFURL : String = 'assets/swf/';
		public static const TxtURL : String =  'assets/xml/';
		
		public function Loading()
		{
			
		}
		
		public function setLoadCfgXML(url:String):void
		{
			_url = url;
			 
		}
		
		public function setLoadCfg(cfg:Array):void
		{
			_loaCfg = cfg;
		}
		//开始加载，如果没有加载配置文件则先加载配置
		public function loadStart():void
		{
			if(!_loaCfg)
			{
				_loaFile.LoadRq(_url, getLoadCfg);
			}else{
				loadNext();
			}
			
		}
		private function loadProgress(e:ProgressEvent):void
		{
			var progressNum : Number = _loaCount/_loaTotalCount*100;
			
			this.dispatchEvent(new LoadEvent(LoadEvent.LoaFileComplete, 
											progressNum.toString() + '_'
											+ this._loaDesc));

		}
		//得到加载配置文件
		private function getLoadCfg(e:Event):void
		{
			var urlLoader : URLLoader = e.target as URLLoader;
			_loaFile.RemoveLoad();
			
			_loaCfg = XMLEditor.getLoadCfgLis(XML(urlLoader.data));
			
			_loaTotalCount = getLoaTotalCount(_loaCfg);
			
			loadNext();
			
			
			
		}
		private function getLoaTotalCount(loaCfg:Array):int
		{
			var count : int;
			for each(var i:Object in loaCfg)
			{
				count += i.list.length;
			}
			return count;
		}
		//开始按进度加载
		private function loadNext():void
		{
			if(!_loaCfg || !_loaCfg.length)
			{
				trace('loaCmt');
				_loaCfg = null;
				_loaTotalCount = 0;
				_loaFile.RemoveLoad();
				this.dispatchEvent(new LoadEvent(LoadEvent.LoaAllFileComplete));
				return;
			}
			var loaInfo : Object = _loaCfg.shift();
			_loaLis = loaInfo['list'];
			_loaDesc = loaInfo['desc'];
			_format = loaInfo['format'];
			var url : String =  _loaLis.shift();
			loadFile(url);
 						
		}
		//根据文件类型加载
		private function loadFile(url:String):void
		{
			var fileType : String = url.split('.')[1];
			var loaUrl : String;
			 
			if(fileType == 'swf')
			{
				loaUrl = Loading.SWFURL + url;
				LoadFile.getInstance().Load(loaUrl, loadProgress, getLoadingFile);
			}else{
				loaUrl = Loading.TxtURL + url;
				LoadFile.getInstance().LoadRq(loaUrl, getLoadingTxt, this._format);
				
			}
		}
		//检查加载进度，如果该组加载完则进入下一组
		private function checkLoaProgress():void
		{
			this._loaCount++;
			var progressNum : Number = _loaCount/_loaTotalCount*100;
			
			this.dispatchEvent(new LoadEvent(LoadEvent.LoaFileComplete, 
											progressNum.toString() + '_'
											+ this._loaDesc));
			
								
			if(_loaLis.length)
			{
				var url : String =  _loaLis.shift();
				loadFile(url);
			}else{
				loadNext();
			}
		}
		
		private function getLoadingFile(e:Event):void
		{
			var loa : LoaderInfo = e.currentTarget as LoaderInfo;
			loa.removeEventListener(Event.COMPLETE, getLoadingFile);
			var fileUrl : String = loa.url.split('.')[0];
			var fileNameIndex : int = fileUrl.lastIndexOf('/');
			var fileName : String = fileUrl.substr(fileNameIndex+1);
			var symbolCfg : Object = _symbolAll.symbolCfg[fileName];
			if(symbolCfg)
			{
				var mc : Sprite = loa.content as Sprite;
				
					//得到元件配置
					for(var i:String in symbolCfg)
					{
						var classInstance : Class = 
							mc.loaderInfo.applicationDomain.getDefinition(i) as Class;
											
						if(!symbolCfg[i]) symbolCfg[i] = classInstance;					
					}		
				
					
				
			}
			
			
			checkLoaProgress();							

		}
		
		private function getLoadingTxt(e:Event):void
		{
			var urlLoader : URLLoader = e.target as URLLoader;
			_loaFile.RemoveLoad();
			if(urlLoader.dataFormat == URLLoaderDataFormat.TEXT)
			{
				var xml : XML = XML(urlLoader.data);
				var key : String = xml.@fileName;
				var type : String = xml.@type;
				
			}else{
				
				var bt : ByteArray = urlLoader.data;
				bt.uncompress();
				bt.position = 0;
			}
			
			var cfg : Object;
			switch(type)
			{
				case 'symbol' :
					cfg = XMLEditor.getSymbolClassCfg(xml);
					_symbolAll.symbolCfg[key] = cfg;
					break;

			}
			
			
			
			checkLoaProgress();
		}
	}
}