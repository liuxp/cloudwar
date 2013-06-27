package events
{
	import core.EventBase;

	public class GameEvent extends EventBase
	{
		public static const Game_Win : String = 'game_win';
		public static const Game_Reset : String = 'game_reset';
		public static const Game_Over : String = 'game_over';
		public static const Game_Start : String = 'game_start';
		public static const GAME_PAUSE : String = 'game_pause';

		public static const AddScore : String = 'addscore';
		public static const Show_View_Alert : String = 'show_view_alert';
 
		
		public function GameEvent(type:String, obj:Object=null, bubbles:Boolean=false)
		{
			super(type, obj, bubbles);
		}
		
	}
}