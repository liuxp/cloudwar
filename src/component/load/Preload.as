
package component.load
{
	import events.GameEvent;
	import events.LoadEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.text.TextField;
	
	import manager.CommandManager;
	import manager.EventManager;
	import manager.MaterialManager;
	
	import utils.GlobalUtil;
	import utils.ScreenUtil;
	
	public class Preload extends Sprite
	{
		private var _loading : Loading;
		private var _clip : MovieClip;
		private var _MM : MaterialManager = MaterialManager.getInstance();
		private var _modules:Array;
		private var _module:Object;
		
		public function Preload()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			
		}
		
		private function addToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			LoadFile.getInstance().LoadRq(Loading.TxtURL + "module.xml", initLoading);
			
			//开始游戏
			EventManager.getInstance().gameDispatch.addEventListener(
											GameEvent.Game_Start,onLoaDone);
			
		}
		private function initLoading(e:Event):void
		{
			LoadFile.getInstance().RemoveLoad();
			var urlLoader :URLLoader = e.target as URLLoader;
			var xml:XML = XML(urlLoader.data);
			this._modules = XMLEditor.getLoadCfgLis(xml);
			
			_loading = new Loading();
			
			_loading.addEventListener(LoadEvent.LoaAllFileComplete, onLoaCmtHandler);
			
			loadModule();
			
		}
		//开始加载模块		
		private function loadModule():void
		{
			if(_modules && _modules.length)
			{
				_module = _modules.shift();
				
				if(_module.list.length)
				{
					var url:String = _module.list.shift();
					_loading.setLoadCfgXML(Loading.TxtURL + url);
					_loading.loadStart();
				}
			}
			
		}
		//模块加载完毕
		private function onLoaCmtHandler(e:LoadEvent):void
		{
			switch(_module.type)
			{
				case 'preloader' :
					preloaderDone();
					break;
				case 'loadcfg' :
					CommandManager.getGameCfg();
//					onLoaDone();
					break;
				default :
					break;
					
			}
			
			this.loadModule();
		}
		
		//动画加载完毕
		private function preloaderDone():void
		{
			
			var mcClass : Class = _MM.symbolCfg.preloader.Loading;
			_clip = new mcClass();
			this.addChild(_clip);
			_clip.loadBar.gotoAndStop(1); 
			
			//_loading.addEventListener(LoadEvent.LoaAllFileComplete, onLoaDone);
			_loading.addEventListener(LoadEvent.LoaFileProgress, onLoaProgress);
			_loading.addEventListener(LoadEvent.LoaFileComplete, onLoaProgress);
			/*_loading.setLoadCfgXML(Loading.TxtURL + 'LoadConfig.xml');
			_loading.loadStart();*/
		}
		
		private function onLoaProgress(e:LoadEvent):void
		{
			var mc:MovieClip = _clip.loadBar;
			var txt : TextField = _clip.loadTxt;
			
			var loaInfoLis : Array = e.data.split('_');
			var progressNum : int = loaInfoLis[0];
			var desc : String = loaInfoLis[1];
			mc.gotoAndStop(progressNum);
			
			if(desc!= txt.text)
			{
				txt.text = desc;
			}

		}
		
		private function onLoaDone(e:GameEvent=null):void
		{
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
			_clip.stop();
			GlobalUtil.stopAllMc(_clip);
			this._loading = null;
			this._MM = null;
			this.removeChild(_clip);
			
			this._module = null;
			this._modules = null;
		}
		
	}
}
