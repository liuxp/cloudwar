package component.load
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class LoadFile
	{
		private static var _instance : LoadFile;
		
		private var _loader : Loader;
		private var _urlLoader : URLLoader;
		private var _urlRq : URLRequest;
		private var _completeFun : Function;
 		private var _progressFun : Function;
		private var _actDispatcher : EventDispatcher;
		
		public function LoadFile(singleTon : SingleTon)
		{
			if(!singleTon) throw new Error('singleTon');
			
			_urlRq = new URLRequest();
			_loader = new Loader();  
			_urlLoader = new URLLoader();
		}
		
		public static function getInstance():LoadFile
		{
			if(! _instance) _instance = new LoadFile(new SingleTon);
			return _instance;
		}
		
		public function Load(url:String, 
							progressFun : Function = null,
							completeFun:Function = null):void
		{
			_urlRq.url = url;
			
			_progressFun = progressFun;
			_completeFun = completeFun;
			
			_actDispatcher = _loader.contentLoaderInfo;
			
			addListenerCfg();

			_loader.load(_urlRq);
		}
		
		public function LoadRq(url:String, 
								completeFun:Function = null,
								format:String='text'):void
		{
			_urlRq.url = url+'?'+Math.random();
			_urlRq.method = URLRequestMethod.POST;
			_urlLoader.dataFormat = format ? format : URLLoaderDataFormat.TEXT;
			
			_completeFun = completeFun;
			
			_actDispatcher = _urlLoader;
			
			addListenerCfg();
			
			_urlLoader.load(_urlRq);
		}
		
		public function RemoveLoad():void
		{
			if(!_actDispatcher) return;
			removeListenerCfg();
			if(_actDispatcher is LoaderInfo)
			{
				_loader.unload();
			}else{
				_urlLoader.close();
			}
			_actDispatcher = null;
			_progressFun = null;
			_completeFun = null;
		}
		private function onErrorHandler(e:IOErrorEvent):void
		{
			trace(e.text);
			removeListenerCfg();
		}
		
		private function addListenerCfg():void
		{
			if(!_actDispatcher) return;
			
			if(_progressFun!=null) _actDispatcher.addEventListener(ProgressEvent.PROGRESS, _progressFun);
			if(_completeFun!=null) _actDispatcher.addEventListener(Event.COMPLETE, _completeFun);
			_actDispatcher.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
		}
		
		private function removeListenerCfg():void
		{
			if(!_actDispatcher) return;
			
			if(_progressFun!=null) _actDispatcher.removeEventListener(ProgressEvent.PROGRESS, _progressFun);
			if(_completeFun!=null) _actDispatcher.removeEventListener(Event.COMPLETE, _completeFun);
			_actDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
		}
	}
}
class SingleTon {};