
package control.view
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	import core.view.ViewWatchersMeditorBase;
	
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	import model.vo.EquipVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	
	import view.panel.PanelHeroAttr;
	
	
	/**
	 *
	 * HeroAttrMeditor.as class. 
	 * @author Administrator
	 * Created 2013-6-8 下午8:56:05
	 */ 
	public class HeroAttrMeditor extends ViewWatchersMeditorBase
	{ 
		private var _charVO:CharacterVO;
		private var _equVO:EquipVO;
		private var _view:PanelHeroAttr;
		private var _maxLvCharVO:CharacterVO;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function HeroAttrMeditor(viewUI:ViewBase, mods:Array)
		{
			_view = viewUI as PanelHeroAttr;
			_charVO = mods[0].getVO() as CharacterVO;
			_equVO = mods[1].getVO() as EquipVO;
			
			super(viewUI, mods);
		} 
		
		override protected function init():void
		{
			super.init();
			
			_maxLvCharVO =  GameUtil.createCharVO(ArmyConfig.MonarchID,100);
			resetAttr();
		}
		
		override public function update(data:Object):void
		{
			if(data as EquipVO)
			{
				var vo_equip:EquipVO = data as EquipVO;
				if(!vo_equip.isWear && _equVO.id != vo_equip.id)
				{
					_equVO = data as EquipVO;
					updateAttr();
				}else{
					resetAttr();
					_equVO = data as EquipVO;
				}
				
			}
			
		}
		private function updateAttr():void
		{
			
			_view.bar_atk.update(_charVO.atk + _equVO.atk, _maxLvCharVO.atk, _equVO.atk);
			_view.bar_def.update(_charVO.def + _equVO.def, _maxLvCharVO.def, _equVO.def);
			_view.bar_hp.update(_charVO.hp + _equVO.hp, _maxLvCharVO.hp, _equVO.hp);
			_view.bar_mov.update(_charVO.speed + _equVO.speed, _maxLvCharVO.speed, _equVO.speed);
			
		}
		private function resetAttr():void
		{
			_view.bar_atk.update(_charVO.atk, _maxLvCharVO.atk);
			_view.bar_def.update(_charVO.def, _maxLvCharVO.def);
			_view.bar_hp.update(_charVO.hp, _maxLvCharVO.hp);
			_view.bar_mov.update(_charVO.speed, _maxLvCharVO.speed);
			
		}
	}
	
}