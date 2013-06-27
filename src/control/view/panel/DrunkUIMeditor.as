
package control.view.panel
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import manager.ModelLocator;
	
	import model.config.UICfg;
	
	import view.panel.PanelDrunk;
	
	
	/**
	 * DrunkUIMeditor.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-6 下午8:29:45
	 * @history 05/00/12,
	 */ 
	public class DrunkUIMeditor extends ViewMeditorBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _view:PanelDrunk;
		private var mcLis:Dictionary = new Dictionary;
		private var count:int;
		private var count_txt:TextField;
		private var arrow_mc:MovieClip;
		private var _ML:ModelLocator = ModelLocator.getInstance();
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function DrunkUIMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as PanelDrunk;
			//_view.initUI();
			
			
			
			super(viewUI, model);
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function clear():void
		{
			super.clear();
			
			_view = null;
			mcLis = null;
			 
			count_txt = null;
			 arrow_mc.stop();
			 arrow_mc = null;
			_ML = null;
		}
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function init():void
		{
			_view.initUI();
			
			super.init();
			
			for(var i:int=1; i<=4; i++)
			{
				
				mcLis['touch'+i+'_mc'] = true;
			}
			
			var asset:Object = _view.asset;
			count_txt = asset.count_txt;
			arrow_mc = asset.arrow_mc;
		}
		override protected function addListenerCfg():void
		{
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onReMoveHandler);
			_view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			_view.addEventListener(MouseEvent.CLICK,  onClickHandler);
		}
		
		protected function onClickHandler(_event:MouseEvent):void
		{
			_event.stopPropagation();
			if (_event.target is SimpleButton) {
				var _btn:SimpleButton = _event.target as SimpleButton;
				if (_btn.name == this._view.mBtn_back.name) {
					_ML.game.mPanelScene.gotoNextPanelClip(UICfg.PANEL_HERO);
				}
			}
		}
		
		protected function onMouseMoveHandler(e:MouseEvent):void
		{
			e.stopPropagation();
			var p:Point = new Point(e.stageX, e.stageY);
			var arr:Array = _view.getObjectsUnderPoint(p);
			//trace(arr.length, arr);
			for each(var i:* in arr)
			{
				var key:String = i.parent.name
				if((mcLis[key])){
					mcLis[key]=false;
				};
			}
			checkTouchPoint();
		}
		
		
		private function checkTouchPoint():void{
			var num:int;
			for(var i:String in mcLis){
				if(!mcLis[i]) num++;
				
			}
			if(num>3){
				//trace('eat!!!!!!!!!!!!!!!!!!!!')
				this.count_txt.text = (++this.count).toString();
				for(var j:String in mcLis){
					if(!mcLis[j]) mcLis[j] = true;
					
				}
				_ML.game.mPanelPopTips.showOut('干了一杯！');
			}	 
			
		}
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onReMoveHandler);
			_view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler)
		}
		
		
		protected function onReMoveHandler(event:Event):void
		{
			this.clear();
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}