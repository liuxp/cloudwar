

package control.view.scene
{
	
	import control.sound.SoundManager;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import manager.CommandManager;
	import manager.CutDownManager;
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	
	import utils.FormatUtil;
	
	import view.panel.PanelPKWin;
	import view.scene.SceneBase;
	
	
	
	
	public class PanelPKWinMeidtor extends ViewMeditorBase
	{
		private var _view : PanelPKWin;
		private var _asset:Object;
		private var _sceneState:String;
		private var _rwd:Object;
		private var _ML:ModelLocator = ModelLocator.getInstance();
		
		
		public function PanelPKWinMeidtor(viewUI:ViewBase, model:ModelBase=null)
		{
			_view = viewUI as PanelPKWin;
			_asset = _view.asset;
			_rwd = _ML.user.vo.mMession.NormalReward;
			
			super(viewUI, model);
			
			
		}
		
		override protected function init():void
		{
			super.init();
			
			var rwd :Object = _rwd[StaticConfig.Rwd_Gold];
			_asset.gold_txt.text = rwd.Amount;
			
			rwd = _rwd[StaticConfig.Rwd_Exp];
			_asset.exp_txt.text = rwd.Amount;
			
			var stuffs:Array = _rwd[StaticConfig.Rwd_Stuff];
			_view.showEquips(stuffs);
			
			var time:int = CutDownManager.getTime(CutDownManager.CD_PK);
			var starLv:int = this.getStarLvByTime(time);
			_view.showStar(starLv);
			
			var fmt_time:String = FormatUtil.TimeToStr(time*1000);
			_asset.time_txt.text = fmt_time;
		}
		
		private function getStarLvByTime(time:int):int
		{
			var cfg:Array = _ML.user.vo.mMession.Appraise;
			var lv:int;
			for(var i:int; i<cfg.length; i++)
			{
				var key:String = 'star_' + (i+1).toString();
				var cfg_time:int = cfg[i][key];
				if(time >= cfg_time){
					
					break;
				}
				
				lv = i;
			}
			
			return lv;
		}
		override protected function addListenerCfg():void
		{
			_view.addEventListener(MouseEvent.CLICK, onClick);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler)
		}
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler)
		}
		
		protected function removeHandler(event:Event):void
		{
			this.clear();
			CommandManager.ChangeScene(_sceneState);
			
			SoundManager.stopSound('bg_wind');
			SoundManager.playSound('bg_no',true);
		}
		
		
		
		private function onClick(e:MouseEvent):void
		{
			e.stopPropagation();
			
			_sceneState = StaticConfig.Scene_Mission;
					
			_view.remove(true); 
			
		}
		
		override public function clear():void
		{
			
			super.clear();
			this._view = null;
			this._asset = null;
			
			
		}
	}
}