
package events
{
	import core.EventBase;

	public class MeditorEvent extends EventBase
	{
		
		public static const Get_BSData :String = 'get_bsdata'; //服务端请求
		
		public static const Get_General :String = 'get_general';//得到武将
		
		public static const Render_Stop : String = 'render_stop';//停止渲染
		public static const Render_Start : String = 'render_start';//开始渲染
		
		public static const Render_Pause: String = 'render_pause';//暂停渲染
		public static const Render_Resume : String = 'render_resume';//恢复渲染
		
		public static const Sheet_PlayEnd : String = 'sheet_playend';//位图序列播放完毕
		
		public static const AI_Start : String = 'ai_start';//ai执行
		public static const AI_Stop : String = 'ai_stop';//ai暂停
		
		public static const MoveToTargetPos : String = 'movetotargetpos'; //
		public static const FollowCamera: String = 'followcamera'; //镜头跟随
		public static const Camera_Arrive: String = 'camera_arrive'; //镜头到达
		
		public static const Get_NextWave : String = 'get_nextwave';//下一波
		public static const Wave_Clean : String = 'wave_clean';//选择英雄
		
		public static const ChangeScene : String = 'change_scene';//换场景
		
		public static const SkillReady :String = 'skillready';//激活技能
		public static const CoolDown_Start :String = 'cooldown_start';//技能冷却
		
		public static const Select_Hero : String = 'sel_hero';//选择英雄
		public static const Select_Friend : String = 'sel_fri';//选择英雄
		public static const Select_Army : String = 'sel_army';//选择军队
		public static const Select_Skill : String = 'sel_skill';//选择军队
		
		public static const RebornHero : String = 'rebornhero';//复活
		
		public static const FlyTip : String = 'flytip';//复活
		
		public static const Refresh_HeroHP : String = 'refresh_hero_hp';//更新英雄血量
		
		public static const PK_Start : String = 'pk_start';//战斗开始
		public static const PK_End : String = 'pk_end';//战斗结束
		 
		public static const Dialog_Show: String = 'showdialog';//显示对话
		public static const Dialog_Finish: String = 'finishdialog';//结束对话
		public static const Dialog_Skip: String = 'hidedialog';//跳过
		public static const Dialog_Next: String = 'nextdialog';//继续对话
		public static const Dialog_Hide: String = 'hidedialog';//隐藏对话
		public static const SkipStory:String = 'skipstory';//跳过剧情
		
		public static const Game_Mode_Dialog:String = 'game_mode_dialog'; //对话模式
		
		public function MeditorEvent(type:String, obj:Object=null, bubbles:Boolean=false)
		{
			super(type, obj, bubbles);
		}
		
	}
}