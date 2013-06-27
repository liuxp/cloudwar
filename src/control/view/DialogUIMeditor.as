
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
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	import utils.TextFieldUtil;
	
	import view.dialog.DialogUI;
	
	
	/**
	 * DialogUIMeditor.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-14 下午10:45:50
	 * @history 05/00/12,
	 */ 
	public class DialogUIMeditor extends ViewMeditorBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _dialog:Object;
		private var _nameTxt:TextField;
		private var _infoTxt:TextField;
		private var _talk:SequenceCharacter;
		private var _view:DialogUI;
		private var _talkLis:Array;
		private var _txtfmt:TextFormat;
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
		public function DialogUIMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
			super(viewUI, model);
			
			_view = viewUI as DialogUI;
			var asset:Object = viewUI.asset;
			_nameTxt = asset.name_txt;
			_infoTxt = asset.info_txt;
			
			_txtfmt = new TextFormat();
			
			
			_talk = new SequenceCharacter(renderFun, finishFun);
			_talk.talkSpeed = 50;
			//_view.x = 80;
		} 
		
		private function finishFun():void
		{
			if(_talkLis.length) GameUtil.delayExecuteFun(1000, setTalk, 1, this.mid, 'setTalk');
		}      
		
		private function renderFun(str:String):void
		{
			trace(str);
			
			_infoTxt.text = str;
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
		
		
		
		protected function nextDialogHandler(event:MeditorEvent):void
		{
			
			GameUtil.deleteDelayFun(this.mid);
			
			if(_talk.isTalking()) _talk.talkDone();
			else this.setTalk();
		}
		
		private function showDialogHandler(e:MeditorEvent):void
		{
			var data:Object = e.data;
			if(data.hasOwnProperty('camera')) return;
			_talkLis = [];
			
			
			var hero:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, data.head);
			this._nameTxt.text = hero.UnitName;
			if(data.dialog as String) _talkLis.push(data.dialog);
			else _talkLis = _talkLis.concat(data.dialog);
			_view.setHeadIcon(data.head);
			setLayerOut(data.dir);
			setTalk();
				
			if(!this.hasMeditorEventListener(MeditorEvent.Dialog_Next))
			{
				this.addMeditorEventListener(MeditorEvent.Dialog_Next,nextDialogHandler);
			}
		}
		private function setLayerOut(dir:String):void
		{
			if(dir == 'left')
			{
				_view.icon.x = 24;
				
				this._nameTxt.x = this._infoTxt.x = 228;
				_txtfmt.align = TextAlign.LEFT;
				this._nameTxt.setTextFormat(_txtfmt);
				
			}else{
				
				_view.icon.x = 565;
				_txtfmt.align = TextAlign.RIGHT;
				this._nameTxt.x = this._infoTxt.x = 19;
				this._nameTxt.setTextFormat(_txtfmt);
			}
		}
		
		private function setTalk():void
		{
			if(_talkLis.length)
			{
				_infoTxt.text = '';
				_talk.Data = _talkLis.shift();
				_talk.talk();
			}else{
				this.removeMeditorEventListener(MeditorEvent.Dialog_Next,nextDialogHandler);
				_view.removeFromParent();
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Dialog_Finish));
				
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