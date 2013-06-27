package command
{
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.CutDownManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.GameCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;

	/**
	 *战斗剧情 
	 * @author YC
	 * 
	 */	
	public class CreateBattleStoryCommand extends CommandBase
	{

		private var _storyCfg:Object;
		private var _storys:Array;
		private var _story:Object;//当前剧情
		
		private var _state:int; //0 镜头，1对话
		private var _delay:int = 100;
		private var _dialogType:String;
		private var _isDialog:Boolean;
		
		public function CreateBattleStoryCommand()
		{
			super();
			
			this.addListenerCfg();
		}
		
		private function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.Camera_Arrive, onCameraArriveHandler);
			this.addMeditorEventListener(MeditorEvent.Dialog_Finish, onDialogFinishHandler)
			this.addMeditorEventListener(MeditorEvent.PK_End, onPKEndHandler);
			this.addMeditorEventListener(MeditorEvent.SkipStory, onSKipStoryHandler);
		}
		
		private function removeListenerCfg():void
		{
			this.removeMeditorEventListener(MeditorEvent.Camera_Arrive, onCameraArriveHandler);
			this.removeMeditorEventListener(MeditorEvent.Dialog_Finish, onDialogFinishHandler)
			this.removeMeditorEventListener(MeditorEvent.PK_End, onPKEndHandler);
			this.removeMeditorEventListener(MeditorEvent.SkipStory, onSKipStoryHandler)
		}
		
		private function onSKipStoryHandler(e:MeditorEvent):void
		{
			_storys = null;
			_story = null;
			
			if(_ML.master)
			{
				CommandManager.MoveCamera({ pos:new Point(_ML.master.x,0), 
					ease:false}) 
			}
			
			if( _ML.dialogType != StaticConfig.Dialog_BattleWin
				&& _ML.dialogType != StaticConfig.Dialog_BattleFail)
			{
				_ML.dialogType = StaticConfig.Dialog_BattleIn;
			}
			
			this.entryStory();
		}		
		
		
		private function onDialogFinishHandler(e:MeditorEvent):void
		{
			if(_isDialog) GameUtil.delayExecuteFun(_delay, entryStory, 1, 'entryStory');
		}
		
		private function onCameraArriveHandler(e:MeditorEvent):void
		{
			makeDialogs();
		}
		
		private function makeDialogs():void
		{
			_isDialog = true;
			CommandManager.MakeDialogs([this._story, _ML.dialogType]);
		}
		
		override public function execute(params:Object=null):void
		{
			
			_storyCfg = GameUtil.getCfgByItmID(StaticConfig.Cfg_Story, params as String)
			setStorys();
			GameUtil.delayExecuteFun(_delay, entryStory, 1, 'entryStory');
		
		}
		
		public function setStorys():void
		{
			var lis:Array = _storyCfg[_ML.dialogType];
			_storys = lis.concat();

		}
		
		private function entryStory():void
		{
			if(_storys && _storys.length)
			{
				_isDialog = false;
				_story = _storys.shift();
				
				if(_ML.dialogType != StaticConfig.Dialog_BattleIn)
				{
					this.makeDialogs();
				}else{
					CommandManager.MoveCamera({ pos:new Point(_story.camera,0), 
												ease:_story.ease})
						
				}

			}else{
				
				if(_ML.dialogType == StaticConfig.Dialog_BattleBefore)//切换到人物对话模式
				{
					_ML.dialogType = StaticConfig.Dialog_BattleIn;
					this.setStorys();
					entryStory();
						
				}else{
					
					this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Dialog_Hide));
					
					if(_ML.dialogType == StaticConfig.Dialog_BattleIn)//对话完毕，开始战斗
					{
						var enemies:Array = _ML.enemies.toArray()
						makeCharacterAI(enemies);
						makeCharacterAI(_ML.myArmies.toArray());
						makeStorySkill(enemies);
 						//刷兵
						CommandManager.createWave(_ML.user.vo.mMession);
						this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.CoolDown_Start));
						//战斗计时
						CutDownManager.delTime(CutDownManager.CD_PK);
						CutDownManager.addTime(0, CutDownManager.CD_PK);
					}else{//战斗完毕
						
						trace('结束战斗');
						//战斗胜利
						if(_ML.dialogType == StaticConfig.Dialog_BattleWin)
						{
							CommandManager.SetGameState(StaticConfig.Scene_PK_Win);
						}else{
							CommandManager.SetGameState(StaticConfig.Scene_PK_Fail);
						}

						this.clear();
					}
 
					this.clear();
					removeListenerCfg();
				}
				
			}
			
			
			
		}
		
		private function makeStorySkill(lis:Array):void
		{
			for each(var i:CharacterBase in lis)
			{
				var meditor:CharacterMeditor =MeditorManager.getMeditor(i.uid) as CharacterMeditor;
				var vo:CharacterVO = meditor.ai._vo;
				if(vo.storySkillId){
					CommandManager.createStorySkill(
						{
							skillId:vo.storySkillId,
							target : i,
							targetAI: meditor.ai
						});
				}
			}
			
		}
		
 		private function delayFun():void
		{
			 
		}
		private function makeCharacterAI(lis:Array):void
		{
			for each(var i:CharacterBase in lis)
			{
				var meditor:CharacterMeditor =MeditorManager.getMeditor(i.uid) as CharacterMeditor;
				meditor.aiStart();
			}
		}
		
		private function onPKEndHandler(e:MeditorEvent):void
		{
			this.removeListenerCfg();
		}
		
		override public function clear():void
		{
			super.clear();
			this._storyCfg = null;
			this._storys = null;
			this._story = null;
		}
		
		
	}
}