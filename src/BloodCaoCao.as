package
{
	//import com.demonsters.debugger.MonsterDebugger;
	
	import component.Monitor;
	import component.load.Preload;
	import component.load.PreloadStart;
	
	import control.sound.SoundManager;
	import control.view.GameMainUIMeditor;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.events.TouchEvent;
	import flash.events.TouchEventIntent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import manager.MeditorManager;
	import manager.ModelLocator;
	
	import model.config.GameCfg;
	
	import net.SendAndSelect;
	import net.SendServiceAMFFun;
	
	import utils.GlobalUtil;
	import utils.ScreenUtil;
	
	import view.Game;
	import view.Test;
	
	[SWF(backgroundColor="#000000", frameRate="30", width="800", height="480")]
	
	public class BloodCaoCao extends Sprite
	{
		private var _ML:ModelLocator = ModelLocator.getInstance();
		
		/*[Embed(source='assets/img/map/asset.jpg')]
		private var map:Class;*/
		
		public function BloodCaoCao()
		{
			super();  
			if(this.stage){
				this.init();
			}
			else {
				this.addEventListener(Event.ADDED_TO_STAGE,this.init);
			}
			
//			MonsterDebugger.initialize(this);
		}
		
		private function init(_event:Event = null):void {
			
			this.initStart();
			
			/*_event == null?_event = null:GlobalUtil.deleteEventFun(_event.currentTarget, Event.ADDED_TO_STAGE, this.init);
			this.stage.addEventListener(Event.RESIZE, this.onCHANGE);*/
			
		}
		private function onCHANGE(_event:Event):void {
			//            var _os:String = Capabilities.os;
			trace('場景 翻轉到 需要的 方向後 正式開始遊戲',this.stage.stageWidth,this.stage.stageHeight,this.stage.width);
			//            if ((_os.indexOf('iPhone') > -1) || (_os.indexOf('Windows') > -1)) {
			if(this.stage.stageWidth>this.stage.stageHeight){
				GlobalUtil.deleteEventFun(_event.currentTarget, Event.RESIZE,this.onCHANGE);
				this.initStart();
			}
			//            }
			//            else {
			//                this.initStart();
			//            }            
		}
		private function initStart():void{
			// 支持 autoOrient
//			stage.align = StageAlign.TOP_LEFT;
//			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
			//一直处于激活状态
//			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			ScreenUtil.fullScreen(stage);
			//触摸状态
			Multitouch.inputMode = MultitouchInputMode.NONE;
//			SendAndSelect.setConnectNet('http://kingdowin.3322.org:8089/gateway/', 'http_api');
			//			SendServiceAMFFun.sendService_regist( { });
			//预加载
			preload();              
		}
		//预加载
		private function preload():void
		{
			//			var loading : Preload = new Preload;
			//			this.addChild(loading);
			//			loading.addEventListener(Event.COMPLETE, onLoadCmtHander);
			var pr : PreloadStart = new PreloadStart();
			pr.addEventListener(Event.COMPLETE, onLoadCmtHander);
			this.addChild(pr);
		}
		
		private function onLoadCmtHander(e:Event):void
		{
			//			var loading : Preload = e.target as Preload;
			//			
			//			this.removeChild(loading);
			//			loading.removeEventListener(Event.COMPLETE, onLoadCmtHander);
			var loading : PreloadStart = e.target as PreloadStart;
			this.removeChild(loading);
			loading.removeEventListener(Event.COMPLETE, onLoadCmtHander);
			
			//初始游戏
			initGame();
			
//			test();
		}
		
		/*private function test():void
		{
			var test:Test = new Test();
			addChild(test);
			
		}*/
		
		private function initGame():void
		{
			//this.stage.frameRate = 40;
			_ML.stage = this.stage;//全局stage
			var app:Game = new Game;
			_ML.game = app;
			app.scrollRect = new Rectangle(0,0, 800, 480);
			MeditorManager.addMeditor(app.uid, new GameMainUIMeditor(app, _ML.user));
			addChild(app);
			
			
			//app.x = (this.stage.stageWidth - this.stage.width)>>1;
			//app.y = (this.stage.stageHeight - this.stage.height)>>1
			/*var stat:Monitor = new Monitor();
			addChild(stat);
			
			stat.x = stage.stageHeight - 70;*/
			
			SoundManager.loadSounds();

			//SoundManager.muteBGSound();
		}
		
	}
}