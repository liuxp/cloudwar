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
	
	import model.UserModel;
	import model.vo.GeneralVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	
	
	/**
	 * FoodUIMeditor.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-19 下午4:06:55
	 * @history 05/00/12,
	 */ 
	public class EnergyUIMeditor extends ViewWatcherMeditorBase
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
		public function EnergyUIMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			super(viewUI, mod);
			
			var assets:Object = viewUI.asset;
			this._pro_txt = assets.pro_txt;
			this._bar = assets.bar_mc;
			
			_vo = mod.getVO() as GeneralVO;
			
			_cdNum = _delay/1000 * _vo.cd_energy;
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function update(data:Object):void
		{
			
			_vo = data as GeneralVO;
			
			var percent:Number = _vo.energy / _vo.energy_max; 
			_bar.scaleX = percent;
			this._pro_txt.text = int(_vo.energy).toString() + '/' + _vo.energy_max.toString();
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
		
		private function addEnergy():void
		{
			var vo:GeneralVO = _ML.monarch_general.getVO() as GeneralVO;
			vo.energy = Math.min(vo.energy_max, vo.energy+ _cdNum);
			_ML.monarch_general.setVO(vo);
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.CoolDown_Start, onCDStartHandler)
			this.addMeditorEventListener(MeditorEvent.PK_End, onPKEndHandler)
		}
		
		private function onCDStartHandler(e:MeditorEvent):void
		{
			GameUtil.delayExecuteFun(_delay, addEnergy, 0, this.mid, 'addEnergy');
		}		
		private function onPKEndHandler(e:MeditorEvent):void
		{
			GameUtil.deleteDelayFun(this.mid);
			_vo.energy = 0;
			_ML.monarch_general.setVO(_vo);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
	}
	
}