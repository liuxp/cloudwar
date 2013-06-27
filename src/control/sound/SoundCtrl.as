package control.sound
{
	import events.LoadEvent;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import model.config.GameCfg;
	
	/**
	 * ...
	 * @author liuxp
	 */
	public class SoundCtrl
	{
		private var _sound:Sound
		private var _sndChennel:SoundChannel;
		private var _len:int;//声音长度
		private var _pos:int;//声音当前位置
		private var _isplaying:Boolean;//是否正在播放
		private var _sndTrans:SoundTransform;
		private var _isRpt:Boolean;//是否重复
		private var _sndCmtFun:Function;
		private var _sndType:String;
		public var isLock:Boolean;
		private var _isPause:Boolean;
		 
		public function get isplaying():Boolean 
		{ 
			return _isplaying; 
		}
		public function get soundTransform():SoundTransform
		{
			return _sndTrans;
		}
		 
		public function SoundCtrl(snd:Sound, isRpt:Boolean=false, 
								  isLock:Boolean=false, sndType:String='',
								  sndCmtFun:Function=null) 
		{
			_sound = snd;
			_isRpt = isRpt;
			this.isLock = isLock;
			_sndType = sndType;
			_sndCmtFun = sndCmtFun;
			
			initSndChennel();
			initSndTrans();
		}
		
		private function initSndTrans():void
		{
			_sndTrans = new SoundTransform();
		}
		
		public function setVolume(value:Number):void
		{
			_sndTrans.volume = value;
			if(_sndChennel) _sndChennel.soundTransform = VolumeCtr.setVolume(value);
		}
		private function initSndChennel():void
		{
			_sndChennel = new SoundChannel();
			
		}
		
		private function replay():void
		{
			_isplaying = true;
			_sndChennel = _sound.play(0,0,_sndTrans);
			_sndChennel.addEventListener(Event.SOUND_COMPLETE,sndCompleteHandler)
		}
		private function sndCompleteHandler(e:Event):void 
		{
			_isplaying = false;
			if (_sndChennel) _sndChennel.removeEventListener(Event.SOUND_COMPLETE,sndCompleteHandler)
			if (_isRpt){//重复播放
				replay();
			}else{
				if(!this.isLock)//未锁定
				{
					if(_sndCmtFun == null)
					{
						this._sndChennel = null;
						this._sndTrans = null;
						this._sound = null;
						
					}else{
						_sndCmtFun.apply(null,[_sndType]);
					}
					
				}
				
			}
			//trace("sound replay")
		}
		
		public function soundPause():void
		{
			_isplaying = false;
			if(!_sndChennel) return;
			_pos = _sndChennel.position;
			_sndChennel.stop();
			_isPause = true;
		}
		
		public function soundResume():void
		{
			if(!_isPause) return;
			soundPlay();
		}
		
		public  function soundStop():void
		{
			_isplaying = false;
			if(_sndChennel)_sndChennel.stop();
			
			
		}
		public function soundPlay():void 
		{
			_isplaying = true;
			_sndChennel = _sound.play(_pos,0,_sndTrans);
			if(_sndChennel && !_sndChennel.hasEventListener(Event.SOUND_COMPLETE))
			_sndChennel.addEventListener(Event.SOUND_COMPLETE,sndCompleteHandler);
		}
		
		
	}

}