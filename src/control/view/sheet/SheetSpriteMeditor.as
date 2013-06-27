package control.view.sheet
{

	import component.Dict;
	
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import manager.MaterialManager;
	import manager.UIManager;
	
	import model.vo.SheetVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.SheetSprite;

	public class SheetSpriteMeditor extends ViewMeditorBase
	{
		protected var _view : SheetSprite;
		protected var _vo:SheetVO;
		
		 
		protected var _delay:uint = 30;//延迟
		protected var _render:SheetRender; 
		
		
		public function SheetSpriteMeditor(view:ViewBase)
		{
			_view = view as SheetSprite;
			
			super(view);
		}
		
		
		override protected function init():void
		{
			initData();
			
			initBitList();
			 
			GameUtil.delayExecuteFun(_delay, Play, 0, _mid);
 			
			super.init();			
		}
		
		protected function initData():void
		{
			_vo = new SheetVO;
			_vo.state = _view.types;
			_render = new SheetRender(_vo, _view.types);
			
		}
		//初始序列图列表
		protected function initBitList():void
		{
			_render.running = true;
			var isCharacter:Boolean = _vo.state.indexOf('lv')!=-1;
			if(isCharacter)
			{
				_vo.state = 'attack_effect';
			}
			_render.chageState(_vo.state, isCharacter);
		}
		
		 
		override protected function addListenerCfg():void
		{
			/**移除view对象 liuxp 2011/9/20*/
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
			this.addMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.addMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.addMeditorEventListener(MeditorEvent.Render_Pause, renderStop);
			this.addMeditorEventListener(MeditorEvent.Render_Resume, renderStart) 
		}
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
			this.removeMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.removeMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.removeMeditorEventListener(MeditorEvent.Render_Pause, renderStop);
			this.removeMeditorEventListener(MeditorEvent.Render_Resume, renderStart) 
		}
 
		public function renderStart(e:MeditorEvent=null):void
		{
			
			GameUtil.delayExecuteFun(_delay, Play, 0, _mid);
			
		}
		public function renderStop(e:MeditorEvent=null):void
		{
			GameUtil.deleteDelayFun(_mid);
			
		}
		/**位图渲染*/
		public function Play():void
		{
			if(!this._render) return;
			
			if(this._render.isEnd())
			{
				_render.reset();
			}
			var srcBit:BitmapData = _render.render();
			_view.bitmap.bitmapData = srcBit;
			
			
			
			
		   	//trace('play')
			
		}
		
		/*public function Stop():void
		{
			GameUtil.deleteDelayFun(_mid);
		}*/
		
		 
			
		public function SetPlayRate(delay:Number, count:int=0):void
		{
			_delay = delay;
			GameUtil.deleteDelayFun(_mid);
			GameUtil.delayExecuteFun(_delay, Play, count, _mid);
		}
		
		 
		 
		//移除对象
		protected function onRemovedHandler(e:Event):void
		{
			this.clear();
 
			 
		}
		
		override public function clear():void
		{
			GameUtil.deleteDelayFun(_mid);
			super.clear();
			
			_render.clear();
			_render = null;
			_vo = null;
			_view.bitmap.bitmapData = null;
			_view.bitmap = null;
			_view = null;
		}
	}
}