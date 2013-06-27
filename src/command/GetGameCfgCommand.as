package command
{
	import business.BSLocUtil;
	
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	
	import component.load.LoadFile;
	import component.load.XMLEditor;
	
	import core.ModelBase;
	
	import events.GameEvent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	import manager.EventManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.config.GameCfg;
	import model.config.StaticConfig;
	import model.config.sheet.GameMaterial;
	import model.config.sheet.XMLCfg;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.ObjToModelUtil;
	import utils.SearchUtil;

	public class GetGameCfgCommand extends CommandBase
	{
		private var _data : Object;
		private var _loaLis : Array;
		private var _loaObj : Object;
		private var _sec : Number = 0;
		private var _configs : Array;
		private var _loaInfo:Object; //小加载元素信息
		
		public function GetGameCfgCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			/*var url : String = 'gamecfg.xml';
			
			LoadFile.getInstance().LoadRq(GameCfg.url_xml + url , 
				getLoaCfg);*/
			getLoaCfg();
		}
		
		private function getLoaCfg():void
		{
//			LoadFile.getInstance().RemoveLoad();
//			var urlLoa:URLLoader = e.target as URLLoader;
			var xml:XML = XML(new XMLCfg.GamecfgXML);
			_loaLis = XMLEditor.getLoadCfgLis(xml);
			
			loadNext();
		}
		
		private function loadNext():void
		{
			if(_loaObj && !_loaObj.list.length && !_loaLis.length)
			{
				
				finish();
				return;
			} 
			
			if(!_loaObj || !_loaObj.list.length)
			{
				_loaObj = _loaLis.shift();
			}
			
			var list:Array = _loaObj.list;
			this._loaInfo = list.shift();
			var url:String = 'configs/' + _loaInfo.url;
			
			LoadFile.getInstance().LoadRq(GameCfg.url_xml + url + '.txt' , 
											onLoadHandler, 
											URLLoaderDataFormat.BINARY);
			//onLoadHandler(url);
			
		}
		
		private function onLoadHandler(e:Event):void
		{
			LoadFile.getInstance().RemoveLoad();
			var urlLoa : URLLoader = e.target as URLLoader;
			var bt : ByteArray = urlLoa.data;
			
			_sec = flash.utils.getTimer();
			/*var bt:ByteArray = new GameMaterial[str]();*/
			try{bt.uncompress()}catch(e:Error){trace('数据解压出错')}
			bt.position = 0;
			var sec : Number = flash.utils.getTimer();
			var str : String = bt.readUTFBytes(bt.length);
			_data = com.adobe.serialization.json.JSON.decode(str);
			
			trace('对象转换耗时: ', flash.utils.getTimer() - _sec , 'ms');
			
			checkCfg();
			
			
			
		}	
		
		private function checkCfg():void
		{
			/*for(var key:String in _data)
			{
				getCfgByType(key);
			}*/
			
			getCfgByType(this._loaInfo.type);
			
			loadNext();
		}
		
		private function getCfgByType(type:String):void
		{
			var cfg : Object = _data;//[type];
			
			if(!cfg) return;
			
			_ML.gameCfg.config[type] = cfg;
			
			
			if(type != 'user') getCfg(_ML.gameCfg.config[type]); 
			
			
		}
		 
		private function finish():void
		{
			
			BSLocUtil.GetUser();
			
			EventManager.getInstance().gameDispatch.dispatchEvent(
										new GameEvent(GameEvent.Game_Start));
			
		}
		
		/**转换配置数据通用方法*/
		private function getCfg(cfg:Object, objToModelFun:Function=null ):void
		{
			for (var s : String in cfg)
			{
				//if(cfg[s] as Array) continue;
				if(!cfg[s].id ) cfg[s].id = s; 
				
				
			}
 
		}	
	}
}