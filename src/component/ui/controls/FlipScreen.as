
package component.ui.controls
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import component.ui.tiles.ListUIBase;
	import component.ui.tiles.TileList;
	import component.ui.tiles.TileVariables;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
	public class FlipScreen
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _target:Sprite;
		private var _columnWidth : int;
		private var _column : int;
		private var _drag:Boolean;
		private var _press:Boolean;
		private var _tileList:TileList;
		private var _localX:int;
		private var _globalX:int;
		private var _lockX:int;//点击后锁定的坐标
		private var _dragMin:int;//
		private var _dragMax:int;
		private var _page:int;
		private var _pages:int;
		private var _dir:int;
		private var global_delta:Number;
		private var local_delta:Number;
		private var _margin_x:int;
		private var _margin_delta:int =3;
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
		public function FlipScreen(target:TileList)
		{
			_tileList = target as TileList;
			this._target = target.layer;
			this._pages = _tileList.pages;
			
			if(_tileList.align == TileVariables.Align_Horizontal)
			{
				this._column = target.column;
				this._columnWidth = target.columnWidth;
				this._margin_x = this._column * this._columnWidth >>1;

			}else{
				this._column = target.row;
				this._columnWidth = target.rowHeight;
				this._margin_x = this._column * this._columnWidth >>1;
				
			}
			
			_dragMin = 0;
			_dragMax = _column * _columnWidth * (_pages-1);
			
			_target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveHandler)
			_target.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			_target.addEventListener(MouseEvent.MOUSE_UP, mouseHandler, true);
			_target.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			_target.stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			
			
		} 
		
		protected function onRemoveHandler(event:Event):void
		{
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveHandler)
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			_target.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			_target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			_target.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			
			clear();
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
					var p:Point = new Point(event.stageX, event.stageY);
					
					if(_tileList.align == TileVariables.Align_Horizontal)
					{
						_globalX = p.x;
						_localX = event.localX;
						_lockX = _target.x;
					}else{
						_globalX = p.y;
						_localX = event.localY;
						_lockX = _target.y;
					}
					
					trace('_globalX:', _globalX)
					TweenLite.killTweensOf(_target);
					break;
				case MouseEvent.MOUSE_UP :	
					if(this._drag)
					{
						event.stopImmediatePropagation();
						this._drag = false;
						var pos:int;
						
						if(_tileList.align == TileVariables.Align_Horizontal)
						{
							if(_target.x >= this._dragMin)
							{
								pos = this._dragMin;
								
							}else if(_target.x <= -this._dragMax){
								
								pos = -this._dragMax;
								
							}else{
 
								pos = getMovPos();
								
							}
							
							TweenLite.to(_target, 1, {x:pos, ease:Strong.easeOut});
						}else{
							if(_target.y >= this._dragMin)
							{
								pos = this._dragMin;
								
							}else if(_target.y <= -this._dragMax){
								
								pos = -this._dragMax;
								
							}else{
								
								pos = getMovPos();
								
							}
							
							TweenLite.to(_target, 1, {y:pos, ease:Strong.easeOut});
						}
						
					}
					this._press = false;
					break;
				case MouseEvent.MOUSE_MOVE :
					if(this._press)
					{
						this._drag = true;
						p = new Point(event.stageX, event.stageY);
						
						if(_tileList.align == TileVariables.Align_Horizontal)
						{
							global_delta = p.x - _globalX;
							local_delta = event.localX - _localX;
							this._target.x = this._lockX + global_delta
						}else{
							global_delta = p.y - _globalX;
							local_delta = event.localY - _localX;
							this._target.y = this._lockX + global_delta
						}
						
						trace("globalDelta:", global_delta)
					}
					break;
			}
		}
		
		private function getMovPos():int
		{
			if(local_delta > _margin_delta || global_delta > _margin_x) _dir = -1;
			else if(local_delta < - _margin_delta || global_delta < - _margin_x) _dir = 1;
			else _dir = 0;
			
			if(_dir ==1) _page = Math.min(_pages, _page+1);
			else if(_dir == -1) _page = Math.max(0, _page-1);
			
			return - _page * _column * _columnWidth;
		}
		
		public function moveByPage(_page:int):void
		{
			_page = Math.min(_pages, _page);
			_page = Math.max(0, _page);
			var pos:int = - _page * _column * _columnWidth;
			TweenLite.to(_target, 1, {x:pos, ease:Strong.easeOut});
		}
		
		public function clear():void
		{
			_tileList = null;
			_target = null;
		}
	}
	
}
