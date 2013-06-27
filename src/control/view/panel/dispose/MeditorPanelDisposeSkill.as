
package control.view.panel.dispose
{
	import component.ui.tiles.Tile;
	
	import control.view.SkillMeditor;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	import events.TileEvent;
	
	import flash.events.Event;
	
	import model.GeneralModel;
	import model.SkillModel;
	
	import utils.SearchUtil;
	
	import view.dispose.PanelArmyList;
	import view.dispose.PanelDisposeSkill;
	import view.dispose.PanelFriendList;
	import view.dispose.PanelTroops;
	
	
	/**
	 *
	 * MeditorPanelFriendList.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午3:34:34
	 */ 
	public class MeditorPanelDisposeSkill extends ViewWatcherMeditorBase
	{ 
		private var _view:PanelDisposeSkill;
		private var _vo:Array;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MeditorPanelDisposeSkill(viewUI:ViewBase, mod:ModelBase)
		{
			_view = viewUI as PanelDisposeSkill;
			_vo = mod.getVO() as Array;
			if(!_vo) _vo = [];
			super(viewUI, mod);
		} 
		
		override protected function init():void
		{
			super.init();
			showSkills();
		}
		override public function update(data:Object):void
		{
			showSkills();
		}
		
		private function showSkills():void
		{
			_view.showSkills(_vo);
			
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.Select_Skill,onSelSkillHandler);
			_view.listUI.addEventListener(TileEvent.Select_Item, onSelItmHandler);
		}
		
		protected function onSelSkillHandler(event:MeditorEvent):void
		{
			var data:SkillModel = event.data as SkillModel;
			if(SearchUtil.getItemByVOFromArr(data,_vo)) return;
			if(_vo.length <3) _vo.push(data);
			
			
			_model.setVO(_vo);
		}
		
		protected function onSelItmHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			var mod:SkillModel = tile.data as SkillModel;
			var index:int = SearchUtil.getItemIndexByVO('uid', mod, _vo);
			_vo.splice(index,1);
			
			_model.setVO(_vo);
		}
		
		override protected function removeListenerCfg():void
		{
			
		}
	}
	
}