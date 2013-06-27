package command
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import core.view.ViewBase;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	
	import view.dialog.TalkBubble;
	import view.character.CharacterBase;
	import view.scene.PKScene;
	
	
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * MoveCameraCommand.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-14 下午8:32:10
	 * @history 05/00/12,
	 */ 
	public class MakeDialogsCommand extends CommandBase
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MakeDialogsCommand()
		{
			super();
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function execute(params:Object=null):void
		{
			var story:Object = params[0];
			var type:String = params[1];
			if(!story) return;
			var dialogUI:ViewBase;
			
			if(type != StaticConfig.Dialog_BattleIn)//剧情对话
			{
				dialogUI = _ML.game.scene_PK.dialogUI;
				_ML.game.scene_PK.container_ui.addChild(dialogUI);
				
			}else{//人物对话
				
				var gid:String = story.head;
				var char:CharacterBase = GameUtil.getCharacterById(gid);
				dialogUI  = _ML.game.scene_PK.talkBubble;
				char.container_bottom.addChild(dialogUI);
				dialogUI.y = - char.bitmap.height +30;
				if(story.dir == 'right'){
					dialogUI.x = -dialogUI.width - char.bitmap.width*0.5;
				}else{
					dialogUI.x = char.bitmap.width>>2;
				}
			}
			
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Game_Mode_Dialog));
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Dialog_Show, story));
			
		}
		
		
		
	}
	
}