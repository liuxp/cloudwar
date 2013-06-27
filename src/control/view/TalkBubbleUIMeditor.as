
package control.view
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	import component.SequenceCharacter;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	import view.dialog.TalkBubble;
	
	
	/**
	 * DialogUIMeditor.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-14 下午10:45:50
	 * @history 05/00/12,
	 */ 
	public class TalkBubbleUIMeditor extends ViewMeditorBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _dialog:Object;
		private var _txt:TextField;
		private var _talk:SequenceCharacter;
		private var _view:TalkBubble;
		private var _talkLis:Array;
		private var _dir:int=1;
		private var _ML:ModelLocator = ModelLocator.getInstance();
		
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function TalkBubbleUIMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			super(viewUI, model);
			
			_view = viewUI as TalkBubble;
			
			_txt = _view.txt;
			_talk = new SequenceCharacter(renderFun, finishFun);
			_talk.talkSpeed = 20;

		} 
		
		private function finishFun():void
		{
			
			if(_talkLis.length) GameUtil.delayExecuteFun(2000, setTalk, 1, this.mid, 'setTalk');
		}      
		
		private function renderFun(str:String):void
		{
			trace(str);
			
			_view.txt.text = str;
		}
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		/*override protected function init():void
		{
		
		}*/
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.Dialog_Show,showDialogHandler);
			this.addMeditorEventListener(MeditorEvent.Dialog_Hide,hideDialogHandler);  
		}
 
		private function showDialogHandler(e:MeditorEvent):void
		{
			if(_ML.dialogType != StaticConfig.Dialog_BattleIn) return;
			
			_talkLis = [];
			
			var data:Object = e.data;
			_dir = data.dir == 'left' ? 1 : -1;
			
			if(data.dialog as String) _talkLis.push(data.dialog);
			else _talkLis = _talkLis.concat(data.dialog);
			
			/*if(_dir <0) _view.x = - _view.width;
			else _view.x = 0;*/
			_view.setDir(_dir);
			setTalk();
			
			if(!this.hasMeditorEventListener(MeditorEvent.Dialog_Next))
			{
				this.addMeditorEventListener(MeditorEvent.Dialog_Next,nextDialogHandler);
			}
		}
		
		private function setTalk():void
		{
			if(_talkLis.length)
			{
				
				var msg:String = _talkLis.shift();
				_txt.visible = false;
				_view.setMsg(msg);
				_txt.text = '';
				_txt.visible = true;
				_talk.Data = msg;
				_talk.talk();
			}else{
				this.removeMeditorEventListener(MeditorEvent.Dialog_Next,nextDialogHandler);
				_view.removeFromParent();
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Dialog_Finish));
				trace('删除对话气泡')
			}
		}
		
		private function nextDialogHandler(e:MeditorEvent):void
		{
			GameUtil.deleteDelayFun(this.mid);
			
			if(_talk.isTalking())
			{
				_talk.talkDone();
			}else{
				this.setTalk();
			}
		}
		
		private function hideDialogHandler(e:MeditorEvent):void
		{
			_talk.talkDone();
			this.removeMeditorEventListener(MeditorEvent.Dialog_Next,nextDialogHandler);
			_view.removeFromParent();
		}
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}
