package control.view.popUI
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import flashx.textLayout.debug.assert;
	
	import manager.CommandManager;
	import manager.UIManager;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.config.UICfg;
	import model.vo.UserVO;
	
	import mx.core.SpriteAsset;
	
	public class WaveRwdUIMeditor extends PopUIMeditor
	{
		private var _continueBtn:SimpleButton;
		private var _waveTxt:TextField;
		
		public function WaveRwdUIMeditor(viewUI:ViewBase, model:ModelBase=null)
		{
 
			super(viewUI, model);
		}
		
		override protected function initAssets():void
		{
			super.initAssets();
			_waveTxt = _asset['wave_txt'];
			_continueBtn = _asset['continue_btn'];
			
			
		}
		
		override protected function addListenerCfg():void
		{
			super.addListenerCfg();
			_continueBtn.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			/*this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Get_NextWave));*/
			super.closeHandler(event);
			CommandManager.ChangeScene(StaticConfig.Scene_Mession);
		}
		
		override protected function removeListenerCfg():void
		{
			super.removeListenerCfg();
			_continueBtn.removeEventListener(MouseEvent.CLICK, closeHandler)
		}
 
		override public function clear():void
		{
			//UIManager.removeUI(AssetsCfg.UI_Rwd_Wave, UIManager.Type_Pop);
			
			super.clear();
			this._continueBtn = null;
			_waveTxt = null;
			
		}
 		
		override public function refresh():void
		{
			_waveTxt.text = _ML.wave.id;
		}
	}
}