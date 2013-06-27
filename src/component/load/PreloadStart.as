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
	
	import model.config.sheet.XMLCfg;
	
	import utils.GlobalUtil;
	import utils.ScreenUtil;
	
	public class PreloadStart extends Sprite
	{
		private var _clip : Sprite;
		private var _MM : MaterialManager = MaterialManager.getInstance();
		private var _symbolAll : MaterialManager = MaterialManager.getInstance();
		private var _modules:Array;
		private var _module:Object;
		/*Xml解析器*/
		private var _prasetor:PraseXML;
		
		public function PreloadStart()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);

			//开始游戏
			EventManager.getInstance().gameDispatch.addEventListener(
				GameEvent.Game_Start, onLoaDone);
			
			initGame();
		}
		
		private function initGame():void
		{
			var symbol :Class = XMLCfg.ModuleXML;
			var fristxml:XML = XML(new symbol);
			_modules = XMLEditor.getLoadCfgLis(fristxml);
			
			_prasetor = new PraseXML();
			
			_prasetor.addEventListener(LoadEvent.LoaAllFileComplete, onLoaCmtHandler);
			
			exectuePrase();
			
			
		}
		/*执行解析xml文件*/
		private function exectuePrase():void
		{
			if(_modules && _modules.length)
			{
				_module = _modules.shift();
				
				if(_module.list.length)
				{
					var symbolStr:Object = _module.list.shift();
					_prasetor.setXmlSymbol(symbolStr.url);
					_prasetor.exectue();
				}
			}else{
				//onLoaDone();
			}
		}
		//模块加载完毕
		private function onLoaCmtHandler(e:LoadEvent):void
		{
			switch(_module.type)
			{
				case 'preloader' :
//					preloaderDone();
					break;
				case 'loadcfg' :
					CommandManager.GetGameCfg();
					break;
				default :
					break;
				
			}
			
			exectuePrase();
		}
		
		//动画加载完毕
		/*private function preloaderDone():void
		{
			
			var mcClass : Class = _MM.symbolCfg.preloader.Loading;
			trace(new mcClass());
			trace(new mcClass() is Sprite);
			trace(new mcClass() is MovieClip);
			_clip = new mcClass();
			this.addChild(_clip);
			_clip.loadBar.gotoAndStop(1); 
			
			_prasetor.addEventListener(LoadEvent.LoaFileProgress, onLoaProgress);
			_prasetor.addEventListener(LoadEvent.LoaFileComplete, onLoaProgress);
			/*_loading.setLoadCfgXML(Loading.TxtURL + 'LoadConfig.xml');
			_loading.loadStart();
		}*/
		
		/*private function onLoaProgress(e:LoadEvent):void
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
			
		}*/
		
		private function onLoaDone(e:GameEvent=null):void
		{
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
//			_clip.stop();
//			GlobalUtil.stopAllMc(_clip);
			this._prasetor = null;
			this._MM = null;
//			this.removeChild(_clip);
			
			this._module = null;
			this._modules = null;
		}
		
	}
}
