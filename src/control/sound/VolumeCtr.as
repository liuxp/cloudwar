package control.sound
{
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	public class VolumeCtr
	{
		private static var _sndTrans:SoundTransform = new SoundTransform;
		public function VolumeCtr()
		{
		}
		public static function setVolume(value:Number):SoundTransform
		{
			_sndTrans.volume = value;
			return _sndTrans;
		}
		 
	}
}