package control.view
{

	
	import business.BSUtil;
	
	import command.CreateMessionCommand;
	
	import component.Dict;
	
	import control.sound.SoundManager;
	
	import core.ModelBase;
	import core.UID;
	import core.meditor.Meditor;
	import core.meditor.MeditorBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.UserModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.config.UICfg;
	import model.vo.CharacterVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.Game;
	import view.character.CharacterBase;
	import view.character.SheetSprite;
 

	public class GameMainUIMeditor extends ViewWatcherMeditorBase
	{
		private var _view : Game;
		private var _vo:UserVO;
		private var _state:Boolean;
		
		
		public function GameMainUIMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			super(viewUI, mod);
			
			_view = viewUI as Game;
			_model = mod as UserModel;
			_vo = _model.getVO() as UserVO;
			
		}
		
		override protected function init():void
		{
			super.init();
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			var info : String = Multitouch.supportsTouchEvents ? '支持触摸': '不支持触摸';
			
			_view.setPanelScene();
			
		}
		
		
		
		override protected function addListenerCfg():void
		{
			_view.stage.addEventListener(Event.DEACTIVATE,onDeactiveteHandler);
			_view.stage.addEventListener(Event.ACTIVATE,onDeactiveteHandler);
		}
		
		
		
		protected function onDeactiveteHandler(event:Event):void
		{
			switch(event.type)
			{
				case Event.DEACTIVATE :
					if(_ML.master)
					{
						CommandManager.GameSetting(StaticConfig.Game_Setting_Pause);
					}else{
						SoundManager.pauseAllSounds();
					}
					break;
				default :
					if(_ML.master)
					{
						CommandManager.GameSetting(StaticConfig.Game_Setting_Resume);
					}else{
						SoundManager.resumeAllSounds();
					}
					
					break;
			}
			
		}
		
		override protected function removeListenerCfg():void
		{
			/*_view.btn_test.removeEventListener(MouseEvent.CLICK, onClickHandler);
			_view.btn_clear.removeEventListener(MouseEvent.CLICK, onClickHandler);*/

			
		}
		
		private function onGetHandler(e:MeditorEvent):void
		{
			trace('test');
		}
		private function onTouchDownHandler(e:TouchEvent):void
		{
			switch(e.type)
			{
				case TouchEvent.TOUCH_BEGIN :
					// _view.btn.startDrag(true);
					 break;
				case TouchEvent.TOUCH_END :
					//_view.btn.stopDrag();
					break;
				default :
					break;
			}
			
			
		}
		
		/*override public function update(data:Object):void
		{
			_vo = data as UserVO;
			
		}*/
		
		private function onClickHandler(e:MouseEvent):void
		{
			/*switch(e.currentTarget)
			{
				case _view.btn_clear :
					this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Get_NextWave));
					break;
				case _view.btn_test :
					GameUtil.delayExecuteFun(200, createMession,1,UID.createUID());
					break;
				default:
					 break;
			}*/
			 
			/*var isSup:Boolean = Vibration.isSupported;
			
			_view.info.text += isSup? '支持震动' : '不支持震动';
			
			if(Vibration.isSupported)
			{
				var vb:Vibration = new Vibration();
				vb.vibrate(1000);
			}*/
			
		}
 
		override public function clear():void
		{
			super.clear();
			//_view.removeControl(this);
			_view = null;
			_vo = null;
			
			
		}
	}
}