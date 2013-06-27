
package control.sound
{
	import events.LoadEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import model.config.GameCfg;
	
	/**
	 *
	 * SoundCollection.as class. 
	 * @author Administrator
	 * Created 2013-5-14 下午4:39:26
	 */ 
	public class SoundCollection extends EventDispatcher
	{ 
		private var _sound:Sound;
		private var _urlRq:URLRequest;
		private var _type : String; //素材类型标识
		public  var soundDict : Dictionary = new Dictionary;
		
		private var _loaList : Array = [
			
			'bg_no', 
			"bg_wind",
			'Shu_YX1_attack01','Shu_YX1_move','Shu_YX1_die',
			'Shu_QB_step1_attack01','Shu_QB_step1_die',
			'Shu_QB_step1_attack01','Shu_QB_step1_die',
			'Shu_GB_step1_attack01','Shu_GB_step1_die',
			'Shu_DB_step1_attack01','Shu_DB_step1_die','Shu_DB_step1_injured',
			
			'hit_up_Shu_YX1_attack01','hit_up_Shu_QB_step1_attack01',
			'hit_up_Shu_GB_step1_attack01','hit_up_Shu_DB_step1_attack01'
		];
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function SoundCollection()
		{
		} 
		
		public function loadSounds():void
		{
			if(_loaList.length)
			{
				var i:String = _loaList.shift();
				 
				loadSound(i);
			}else{
				
				this.dispatchEvent(new LoadEvent(LoadEvent.LoadSoundCmt));
			}
			 
			
		}
 
		private function loadSound(url:String, bl:Boolean=false):void 
		{
			_type = url.split('.')[0];
			var version : String = GameCfg.version ;
			var _urlRq :URLRequest = new URLRequest();
			_urlRq.url = GameCfg.url_sound + url + '.mp3?' + version;
			 
			_sound = new Sound();
			_sound.load(_urlRq);
			_sound.addEventListener(Event.COMPLETE, loaCompleteHandler);
		}
		
		private function loaCompleteHandler(e:Event):void
		{
			var sndName : String = _type
			if(!soundDict[sndName])
			{
				soundDict[sndName] = _sound
			}
			
			this.loadSounds();
			
			
		}
		 
	}
	
}