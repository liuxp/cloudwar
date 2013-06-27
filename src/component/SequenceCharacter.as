package component
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * 对话框说话字体逐步显示效果
	 * <component:SequenceCharacter id="talker" talkSpeed="20" />
	 * */
	 
	public class SequenceCharacter
	{
		private var data:String='';
		private var _timer:Timer;
		private var _talkdata:String;
		private var _talkSpeed : uint;
		
		private  var _renderFun : Function;
		private var _finishFun : Function;
		
		public function SequenceCharacter(renderFun:Function, 
										  finishFun:Function=null):void{
			this._renderFun = renderFun;
			this._finishFun = finishFun;
		}
		
		/**
		 * 设置说话速度
		 * */
		public function set talkSpeed(value:uint):void
		{
			_talkSpeed = value;
		}
		/**
		 * 设置说话内容
		 * */
		public function set Data(value:String):void
		{ 
			_talkdata = value; 
			data = '';
		}
		/**
		 * 开始说话
		 * */
		public function talk():void
		{
			if(!_timer)
			{
				_timer = new Timer(_talkSpeed);
			}else{
				_timer.delay = _talkSpeed;
				_timer.reset(); 
			}
			if(!_timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
			}
			_timer.start();
		}
		/**
		 * 是否正在说话
		 * */
		public function isTalking():Boolean
		{
			return _timer && _timer.running;
		}
		
		public function talkDone():void
		{
			stopTalk();
			
			data = _talkdata;
			
			this._renderFun(data);
			
		}
		
		private function onTimerHandler(e:TimerEvent):void
		{
			data += getTalkStr();
			
			this._renderFun(data);
			
			if(data.length >= _talkdata.length)
			{
				stopTalk();
			}
		}
		
		private function getTalkStr():String
		{
			var str : String = _talkdata.substr(_timer.currentCount-1,1);
			return str;
		}
		
		private function stopTalk():void
		{

			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,onTimerHandler);
			if(this._finishFun!=null) this._finishFun();
		}
	}
}