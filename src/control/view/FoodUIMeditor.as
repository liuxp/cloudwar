
package control.view
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import model.GeneralModel;
	import model.UserModel;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	
	
	/**
	 * FoodUIMeditor.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-5 下午4:06:55
	 * @history 05/00/12,
	 */ 
	public class FoodUIMeditor extends ViewWatcherMeditorBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _name_txt:TextField;
		private var _pro_txt:TextField;
		private var _bar:Sprite;
		private var _vo:GeneralVO;
		private var _delay:int = 100;
		private var _cdNum:Number;
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
		public function FoodUIMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			super(viewUI, mod);
			
			var assets:Object = viewUI.asset;
			this._pro_txt = assets.pro_txt;
			this._bar = assets.bar_mc;
			
			_vo = mod.getVO() as GeneralVO;
			
			_cdNum = _delay/1000 * _vo.cd_food;
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function update(data:Object):void
		{
			
			_vo = data as GeneralVO;
			
			var percent:Number = _vo.food / _vo.food_max; 
			_bar.scaleX = percent;
			this._pro_txt.text = int(_vo.food).toString() + '/' + _vo.food_max.toString();
		}
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function init():void
		{
			super.init();
			
			
		}
		
		private function addFood():void
		{
			var ger:GeneralVO = _ML.monarch_general.getVO() as GeneralVO;
			ger.food = Math.min(ger.food_max, ger.food + _cdNum);
			_ML.monarch_general.setVO(ger);
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.CoolDown_Start, onCDStartHandler);
			this.addMeditorEventListener(MeditorEvent.PK_End, onPKEndHandler)
		}
		
		private function onPKEndHandler(e:MeditorEvent):void
		{
			GameUtil.deleteDelayFun(this.mid);
			_vo.food = 0;
			_ML.monarch_general.setVO(_vo);
		}
		
		private function onCDStartHandler(e:MeditorEvent):void
		{
			GameUtil.delayExecuteFun(_delay, addFood, 0, this.mid, 'addFood');
		}		
		
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		 
	}
	
}