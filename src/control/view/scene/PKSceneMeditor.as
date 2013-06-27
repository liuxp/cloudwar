package control.view.scene
{
	import business.BSLocUtil;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import manager.CommandManager;
	
	import model.vo.CameraVO;
	import model.vo.GeneralVO;
	import model.vo.MessionVO;
	import model.vo.UserVO;
	
	import view.component.Zone;
	import view.scene.PKScene;
	
	public class PKSceneMeditor extends ViewWatcherMeditorBase
	{
		private var _view:PKScene;
		private var _vo:UserVO;
		private var _zone:Zone;
		
		public function PKSceneMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI as PKScene;
			_vo = mod.getVO() as UserVO;
			super(viewUI, mod);
		}
		
		override protected function init():void
		{
			super.init();
			
			
		}
		
		override public function update(data:Object):void
		{
			_vo = data as UserVO;
			
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.FollowCamera, onFollowCameraHandler);
			this.addMeditorEventListener(MeditorEvent.Game_Mode_Dialog, onDialogModeHandler)
			this.addMeditorEventListener(MeditorEvent.Dialog_Hide,hideDialogHandler);
		}
		
		private function onFollowCameraHandler(e:MeditorEvent):void
		{
			
			var p:Point = e.data.pos;
			var speed:Number = e.data.speed;
			var glaP:Point = _view.container_character.localToGlobal(p);
			var camera:CameraVO = _ML.camera;
			var container:Sprite = _view.container;
			//if(_ML.game.scene_PK.scaleX!=1) return;
			
			//向右
			if(glaP.x >= camera.x_marginR )
			{
				if(container.x > camera.x_max 
					&& container.x <= 0
					&& speed >0)
				{
					//container.x -=speed;
					container.x = Math.max(camera.x_max, container.x-speed);
					
				}
				
				
			}else if(glaP.x < camera.x_marginL)//向左
			{
				if(container.x < 0 && speed<0)
				{
					//container.x -=speed;
					container.x = Math.min(0, container.x-speed);
				}
			}	
			
		}
		
		private function onDialogModeHandler(e:MeditorEvent):void
		{
			
			_view.container.mouseChildren = false;
			_view.container.mouseEnabled = true;
			
			_view.container_ui.mouseChildren = false;
			_view.container_ui.mouseEnabled = true;
			
			_view.skipStoryBtn.visible = true;
			
			if(!_view.skipStoryBtn.hasEventListener(MouseEvent.CLICK))
			{
				_view.skipStoryBtn.addEventListener(MouseEvent.CLICK, onClickHandler);
				_view.container.addEventListener(MouseEvent.CLICK, onClickHandler);
				_view.container_ui.addEventListener(MouseEvent.CLICK, onClickHandler);
				
			}
		}
		
		private function hideDialogHandler(e:MeditorEvent):void
		{
			_view.container.mouseChildren = true;
			_view.container.mouseEnabled = false;
			
			_view.container_ui.mouseChildren = true;
			_view.container.mouseEnabled = false;
			
			_view.skipStoryBtn.visible = false;
			
			_view.skipStoryBtn.removeEventListener(MouseEvent.CLICK, onClickHandler);
			_view.container.removeEventListener(MouseEvent.CLICK, onClickHandler);
			_view.container_ui.removeEventListener(MouseEvent.CLICK, onClickHandler);
 
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			e.stopPropagation();
			var target:DisplayObject = e.target as DisplayObject;
			if(target is SimpleButton)
			{
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.SkipStory));
			}else{
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Dialog_Next));
			}
			
		}
		 
	}
}