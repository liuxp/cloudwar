
package view.component
{
	import flash.display.DisplayObject;
	
	import utils.GameUtil;
	
	/**
	 *上下跳动的移动效果
	 * UpDownME.as class. 
	 * @author Administrator
	 * Created 2013-6-18 下午5:28:00
	 */ 
	public class UpDownME
	{ 
		private var _view:DisplayObject;
		private var _offY:Number = 0;
		private var _speed:Number = 1;
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function UpDownME(view:DisplayObject)
		{
			_view = view;
			_offY = _view.y;
		} 
		
		public function render():void
		{
			GameUtil.delayExecuteFun(20, move, 0, 'updown');
		}
		
		private function move():void
		{
			_speed+=1.5;
			var num:Number = Math.sin(_speed);
			//trace(_speed, '////', num);
			_view.y = _offY + num;
			
		}
		
		public function clear():void
		{
			GameUtil.deleteDelayFun('updown');
			_view = null;
		}
	}
	
}