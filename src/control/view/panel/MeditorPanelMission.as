package control.view.panel
{
	import business.BSLocUtil;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import component.Iterator;
	import component.ui.tiles.Tile;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.TileEvent;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.SearchUtil;
	
	import view.panel.PanelCamp;
	import view.panel.PanelEntry;
	import view.panel.PanelHeroSkill;
	import view.panel.PanelMission;
	import view.scene.SceneBase;
	import view.tile.MissionTile;
	
	public class MeditorPanelMission extends ViewWatcherMeditorBase
	{
		private var _view:PanelMission;
		private var _sceneState:String;
		private var _vo:UserVO;
		private var _chapItor:Iterator;
		
		public function MeditorPanelMission(viewUI:ViewBase, mod:ModelBase)
		{
			_vo = mod.getVO() as UserVO;
			_view = viewUI as PanelMission;
			super(viewUI, mod);
		}
		
		override protected function init():void
		{
			super.init();
			
			var cfg_chapters:Array = GameUtil.getCfgByItmID(
										StaticConfig.Cfg_Chapter,null)as Array;
			_chapItor = new Iterator(cfg_chapters,false); 
			var index_chap:int = SearchUtil.getItemIndexByVO(
								 'id',_vo.seleced_chapter, _chapItor.items);
			_chapItor.setIndex(index_chap);
			
			_vo.mChapter = _chapItor.getItm(index_chap);
			
			updateUserdata();
			updateView();
			
			_view.showMissions(_vo.mChapter.mission);
			
			var tile:Tile = _view.missionTiles.getTileByData(_vo.mMession);
			_view.showSelBg(tile as MissionTile);
		}
		
		override public function update(data:Object):void
		{
			_vo = data as UserVO;
			updateUserdata();
			updateView();
 
		}
		
		private function updateUserdata():void
		{
			var cfg_mession : Object = GameUtil.getCfgByItmID(
				StaticConfig.Cfg_Mession, _vo.seleced_mession);
			
			_vo.mMession = cfg_mession;
			
		}
		
		private function updateView():void
		{
			_view.showAssetIcon(_vo.seleced_chapter, _view.chapterIcon);
			
			if(_vo.mMession)
			{
				_view.showAssetIcon(_vo.mMession.BaseSet.PKMode, _view.missionModIcon);
				_view.showSheetIcon(_vo.mMession.BaseSet.Boss, _view.missionIntroIcon);
				_view.showMissInfo(_vo.mMession);
				_view.showStars(this.getLvStar());
				
			}
			
		}
		
		private function getLvStar():int
		{
			var chapter:Object = _vo.progress[_vo.seleced_chapter];
			if(chapter)
			{
				if(chapter.hasOwnProperty(_vo.seleced_mession))
				{
					return chapter[_vo.seleced_mession];
				}
			}
			
			return 0;
		}
		
		override protected function addListenerCfg():void
		{
			_view.addEventListener(MouseEvent.CLICK, onClick);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			_view.missionTiles.addEventListener(TileEvent.Select_Item, tileSelectHandler)
		}
		
		protected function tileSelectHandler(event:TileEvent):void
		{
			var tile:Tile = event.data as Tile;
			var missId:String = tile.data.id;
			
			_view.showSelBg(tile as MissionTile);
			
			_vo.seleced_mession = missId;
			_model.setVO(_vo);
		
			var posX:int = tile.index;
			var minX:int = 5;
			var maxX:int = _view.missionTiles.dataList.length-6;
			posX = Math.min(Math.max(posX,minX), maxX);
			trace('mission_index:', tile.index);
			var marginX:int = posX - minX;
			var layer:Sprite = _view.missionTiles.layer;
			if(!TweenMax.isTweening(layer))
			{
				TweenMax.to( layer, 1, 
					{x: -(marginX * _view.missionTiles.columnWidth), 
						ease:Strong.easeOut});
			}
				
			
 
		}
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(MouseEvent.CLICK, onClick);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			_view.missionTiles.removeEventListener(TileEvent.Select_Item, tileSelectHandler)
		}
		
		protected function removeHandler(event:Event):void
		{
			
			this.clear();
			
			CommandManager.ChangeScene(_sceneState);
			 
		}
		
		protected function onClick(_event:MouseEvent):void
		{
			_event.stopPropagation();

			var btn:SimpleButton =  _event.target as SimpleButton
 
			if(btn as SimpleButton)
			{
				switch(btn.name)
				{
					case 'start_btn' :
						_sceneState = StaticConfig.Scene_Dispose;
//						_sceneState = StaticConfig.Scene_PK_Win
						_view.remove(true); 
						break;
					case 'back_btn' :
						_sceneState = StaticConfig.Scene_Camp;
						_view.remove(true); 
						break; 
					case 'chapLeft_btn' :
						checkChapter(this._chapItor.getPrevItm());
						break;
					case 'chapRight_btn' :
						_sceneState = StaticConfig.Scene_Camp;
						checkChapter(this._chapItor.getNextItm());
						break;
					default :
						break;
					
				}
			} 
 
			
		}
		
		private function checkChapter(chapter:Object):void
		{
			if(chapter.id != _vo.seleced_chapter)
			{
				_vo.seleced_chapter = chapter.id;
				_vo.mChapter = chapter;
				_model.setVO(_vo);
				
				_view.showMissions(_vo.mChapter.mission);
			}
 
		}
		
		override public function clear():void
		{
			super.clear();
			this._view = null;
			this._vo = null;
			this._chapItor = null;

			

		}
	}
}