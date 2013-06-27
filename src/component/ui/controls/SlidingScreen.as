
package component.ui.controls
{
	import component.ui.tiles.ListUIBase;
	import component.ui.tiles.TileList;
	import component.ui.tiles.TileVariables;
	
	import events.TileEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * SlidingScreen.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-18 下午10:16:02
	 * @history 05/00/12,
	 */ 
	public class SlidingScreen
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _target:Sprite;
		
		private var _drag:Boolean;
		private var _press:Boolean;
		private var _tileList:ListUIBase;
		private var _dragRect:Rectangle;
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
		public function SlidingScreen(target:ListUIBase)
		{
			_tileList = target;
			this._target = target.layer;
			
			
			
			_target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveHandler)
			_target.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			_target.addEventListener(MouseEvent.MOUSE_UP, mouseHandler, true);
			_target.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			
		} 
 
		public function setDragRect():void
		{
			this._dragRect = this.getRect();
		}
		private function getRect():Rectangle
		{
			
			var mask:Rectangle = _tileList.scrollRect;
			var rect:Rectangle = _target.getBounds(_tileList);
			if(this._tileList.align == TileVariables.Align_Horizontal)
			return new Rectangle(mask.width-rect.width,0,rect.width-mask.width,0);
			return new Rectangle(0,mask.height-rect.height,0,rect.height-mask.height);
		}
		protected function onRemoveHandler(event:Event):void
		{
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveHandler)
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			_target.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler, true);
			_target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
		}
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		private function mouseHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_DOWN :
					this._press = true;
					
					if(this._dragRect) _target.startDrag(false, this._dragRect);
					
					break;
				case MouseEvent.MOUSE_UP :	
					if(this._drag)
					{
						event.stopImmediatePropagation();
						this._drag = false;	
					}else{
						this._tileList.dispatchEvent(new TileEvent(TileEvent.Select_Item, event.target));
					}
					this._press = false;
					_target.stopDrag();
					break;
				case MouseEvent.MOUSE_MOVE :
					if(this._press) this._drag = true;
					break;
			}
		}
	}
	
}