package control.sound
{
	import events.LoadEvent;
	
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	
	
 
	
	public class SoundManager
	{
		private static var _instance : SoundManager;
		private static var _soundDict : Dictionary ;
		private static var _sndChennelDict:Dictionary = new Dictionary;
		private static var _sndNumDict:Dictionary = new Dictionary;
		
		private static var _sounds : SoundCollection = new SoundCollection ;
		private static var isMute : Boolean;
		private static var isBGMute : Boolean;
		
		private static const bgSndName : String = 'bg_no';
		private static const Volume : Number = 0.4; 
		 
		public static var defaultSoundName : String;
		 
		public function SoundManager()
		{
			throw Error('不能实例化！');
			
		}
		 
		public static function loadSounds():void
		{
			_sounds.addEventListener(LoadEvent.LoadSoundCmt, soundLoaCmtHandler);
			_sounds.loadSounds();
		}
		private static function soundLoaCmtHandler(e:LoadEvent):void
		{
			_soundDict = _sounds.soundDict;
			
			 if(defaultSoundName)
			 {
			 	if(defaultSoundName)
				 {
				 	playSound(defaultSoundName, true);
				 } 
			 	
			 }else{
				 playSound(SoundManager.bgSndName, true);
			 }
			 
 			 
		}

		/**
		 * 播放声音
		 * @param name
		 * @param isRpt 是否可重复
		 * @param overlay 是否叠加
		 * 
		 */		
		public static function playSound(name : String, isRpt:Boolean=false, isLock:Boolean=false):void
		{
			var ctr : SoundCtrl;
			//缓存可重复的声音
			if(isRpt || isLock)
			{
				if(!_sndChennelDict[name])
				{
					
					ctr = getSndCtrl(name, isRpt, isLock);
					_sndChennelDict[name] = ctr;
					
				}else{
					ctr = _sndChennelDict[name];
				}
			}else{
				//缓存声音个数
				if(!_sndNumDict[name]) _sndNumDict[name] = 0;
				if(_sndNumDict[name]+1<2)
				{
					_sndNumDict[name] = _sndNumDict[name]+1;
					ctr = getSndCtrl(name, isRpt, isLock, sndComplete);
				}
				
			}
			//缓存锁定的声音
			if(!ctr ||(isLock && ctr.isplaying)) return;
 			 
			ctr.setVolume(SoundManager.Volume);
			 
			if(isBGMute && isBGSound(name))
			{
				ctr.setVolume(0);
			}
			
			if(isMute && !isBGSound(name))
			{
				ctr.setVolume(0);
			}
			
			ctr.soundPlay();
		}
		
		private static function sndComplete(sndType:String):void
		{
			if(_sndNumDict[sndType])
			{
				var num:int = _sndNumDict[sndType];
				_sndNumDict[sndType] = Math.max(0, num-1);
			}
		}
		
		private static function getSndCtrl(name : String, isRpt:Boolean=false, 
										   isLock:Boolean=false, 
										   sndCmtFun:Function=null):SoundCtrl
		{
			if(!_soundDict) return null;
			var snd:Sound = _soundDict[name];
			return  snd ? new SoundCtrl(snd, isRpt, isLock, name, sndCmtFun) : null;
		}
		
		//停止声音
		 public static function stopSound(name : String):void
		{
			var ctr : SoundCtrl = _sndChennelDict[name];
			if(!ctr) return;
			ctr.soundStop();
			
		} 
		//静音
		public static function muteBGSound():void
		{
			SoundManager.isBGMute = true;
			
			for(var i : String in SoundManager._soundDict)
			{
				if(!isBGSound(i)) continue;
				var ctr : SoundCtrl = SoundManager._soundDict[i];
				ctr.setVolume(0);
				
			}
			
			
		}
		
		//恢复背景声音音量
		public static function resumeBGSound():void
		{
			SoundManager.isBGMute = false;
			
			for(var i : String in SoundManager._soundDict)
			{
				if(!isBGSound(i)) continue;
				var ctr : SoundCtrl = SoundManager._soundDict[i];
				ctr.setVolume(SoundManager.Volume);
				
			}
		}
		
		public static function isBGSound(sndName:String):Boolean
		{
			var type : String = sndName.split('_')[0];
			return( type == 'bg');
		}
		
		//恢复音效音量
		public static function resumeSound():void
		{
			for(var i : String in SoundManager._soundDict)
			{
				var ctr : SoundCtrl = SoundManager._soundDict [i];
				if(isBGSound(i)) continue; 
				ctr.setVolume(SoundManager.Volume);
				
			}
			SoundManager.isMute = false;
		}
		
		public static function muteSound():void
		{
			for(var i : String in SoundManager._soundDict)
			{
				var ctr : SoundCtrl = SoundManager._soundDict [i];
				if(isBGSound(i)) continue;
				ctr.setVolume(0);
				
			}
			
			SoundManager.isMute = true;
		} 
		/**
		 *停止一切声音 
		 * 
		 */		
		public static function pauseAllSounds():void
		{
			for(var i : String in SoundManager._sndChennelDict)
			{
				var ctr : SoundCtrl = SoundManager._sndChennelDict [i];
				if(!ctr || !ctr.isplaying) continue;
				ctr.soundPause();
				
			}
		}
		/**
		 *恢复一切声音 
		 * 
		 */		
		public static function resumeAllSounds():void
		{
			for(var i : String in SoundManager._sndChennelDict)
			{
				var ctr : SoundCtrl = SoundManager._sndChennelDict[i];
				ctr && ctr.soundResume();
				
			}
		}
	}
}
