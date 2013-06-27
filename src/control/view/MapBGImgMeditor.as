package control.view
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	
	import utils.GameUtil;
	
	import view.scene.MapBGImg;
	
	public class MapBGImgMeditor extends ViewWatcherMeditorBase
	{
		private var _view : MapBGImg;
		private var _mapBG : String;
		private var _isDwn:Boolean;
		
		public function MapBGImgMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			super(viewUI, mod);
			_view = viewUI as MapBGImg;
			_model = mod;
			
		}
		override protected function addListenerCfg():void
		{
			if(GameUtil.isSupportTouch())
			{
				_view.addEventListener(TouchEvent.TOUCH_BEGIN, onClickHandler);
			}else{
				_view.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler);
			}
			_view.addEventListener(MouseEvent.MOUSE_MOVE, onClickHandler);
			_view.stage.addEventListener(MouseEvent.MOUSE_UP, onClickHandler);
		}
		
		protected function onClickHandler(event:Event):void
		{
			event.stopPropagation();
			if(!_view.stage) return;
			var p:Point = new Point(_view.stage.mouseX, _view.stage.mouseY);//new Point(event.stageX, event.stageY);
			var locP:Point = _view.parent.globalToLocal(p);
			
			var left:int = _ML.camera.x_left;
			var right:int = _ML.camera.x_right;
			var top:int = _ML.camera.y_top;
			var bottom:int = _ML.camera.y_bottom;
			
			if(locP.y < top) locP.y = top;
			else if(locP.y >bottom) locP.y = bottom;
			
			if(locP.x < left)
			{
				locP.x = left;
				GameUtil.deleteDelayFun(this.mid);
			}
			else if(locP.x > right)
			{
				locP.x = right;
				GameUtil.deleteDelayFun(this.mid);
			}
			
			switch(event.type)
			{
				case TouchEvent.TOUCH_BEGIN :
				case MouseEvent.MOUSE_DOWN :
					if(!this._isDwn)
					{
						this._isDwn = true;
						GameUtil.delayExecuteFun(100, getStageMousePos,0,this.mid);
					}
					
					break;
				case MouseEvent.MOUSE_MOVE :
					if(!this._isDwn) return;
					break;
				case MouseEvent.MOUSE_UP :
					locP = null;
					this._isDwn = false;
					GameUtil.deleteDelayFun(this.mid);
					break;
				default :
					break;
			}
 
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.MoveToTargetPos, locP));
		}
		
		private function getStageMousePos():void
		{
			if(_view.stage)
			{
				onClickHandler(new TouchEvent(TouchEvent.TOUCH_BEGIN));
			}else{
				GameUtil.deleteDelayFun(this.mid);
			}
		}
	}
}