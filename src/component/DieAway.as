package component
{
	import core.UID;
	
	import flash.display.DisplayObject;
	
	import manager.TimeLoopManager;

	/**
	 * 死亡的消失特效
	 * leo
	 * */
	public class DieAway
	{
		public var target : DisplayObject;
		private var _fun:Function;
		private var id:String;
		public function DieAway(effCmtFun:Function)
		{
			id  = UID.createUID();
			_fun = effCmtFun;
		}
		
		public function render():void
		{
			
			var delay : uint = 50;
			var loop1 : TimeLoop = new TimeLoop(delay,   1, hide);
			var loop2 : TimeLoop = new TimeLoop(delay*2, 1, show);
			var loop3 : TimeLoop = new TimeLoop(delay*3, 1, hide);
			var loop4 : TimeLoop = new TimeLoop(delay*4, 1, show);
			var loop5 : TimeLoop = new TimeLoop(delay*5, 1, hide);
			var loop6 : TimeLoop = new TimeLoop(delay*6, 1, show);
			var loop7 : TimeLoop = new TimeLoop(delay*9, 1, _fun);
			
			TimeLoopManager.getInstance().addTimeLoop(loop1,'die1'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop2,'die2'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop3,'die3'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop4,'die4'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop5,'die5'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop6,'die6'+ id);
			TimeLoopManager.getInstance().addTimeLoop(loop7,'die7'+ id);
		}
		
		public function clear():void
		{
			id = null;
			this._fun = null;
		}
		private function show():void
		{
			this.target.visible = true;
		}
		private function hide():void
		{
			this.target.visible = false;
		}
	}
}