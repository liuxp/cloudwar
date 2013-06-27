package control.view.PKUI 
{
	import control.view.popUI.WaveRwdUIMeditor;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	import manager.TimeLoopManager;
	import manager.UIManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	/**
	 * ...
	 * @author Elvis liuhaitao
	 */
	public class PKMessionUIMeditor extends ViewWatcherMeditorBase 
	{
		private var _asset:Object;
		private var mVo:UserVO;
		
		private var _masterBar : Sprite;
		private var _masterName:TextField;
		private var _masterHP:TextField;
		private var _masterHead:Bitmap;
		
		private var _enemyBar : Sprite;
		private var _enemyName:TextField;
		private var _enemyHP:TextField;
		private var _enemyHead:Bitmap;
		
		private var _pause:Boolean;
		
		private var _masterId:String;
		private var _enimyId:String;
		
		private var _barMaxWidth:int = 296;
		
		public function PKMessionUIMeditor(_viewUI:ViewBase, _mod:ModelBase) 
		{

			this._asset = _viewUI.asset ;
			
			_masterBar= _asset.master_bar;
			_masterName = _asset.master_name;
			_masterHP = _asset.master_hp;
			_masterHead = getHead(_asset.master_head)
			
			_enemyBar= _asset.enemy_bar;
			_enemyName = _asset.enemy_name;
			_enemyHP = _asset.enemy_hp;
			_enemyHead = getHead(_asset.enemy_head);
			
			this.mVo = _mod.getVO() as UserVO;
			super(_viewUI, _mod);		
		}
		override protected function init():void
		{
			super.init();
			initUI();
		}
		private function getHead(container:Sprite):Bitmap
		{
			GlobalUtil.removeAllChild(container);
			var bm:Bitmap = new Bitmap();
			container.addChild(bm);
			return bm;
		}
		private function initUI():void {
			/*var chapter:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Chapter,
														this.mVo.seleced_chapter);
			var mession:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Mession,
														this.mVo.seleced_mession);
			GlobalUtil.setTxt(this._asset, 'chapter_txt', chapter.name);
			GlobalUtil.setTxt(this._asset, 'mession_txt', mession.name);*/
			
			/*var bmt:BitmapData = this.getIcon(AssetsCfg.N_hero, _ML.master);
			_icon.bitmapData = bmt;*/
			
		}
		override public function update(data:Object):void
		{
            this.mVo = data as UserVO
			initUI();
		}
		
		private function getIcon(type:String, res:String):BitmapData
		{
			
			var _resXML:Vector.<XML> = _MM.getSheetMaterialInfos(type, res);
			var srcBit:BitmapData = _MM.getSheetMaterial(type);
			return GameUtil.getSheetBitBySheetXML(srcBit, _resXML[0]);
			
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.Refresh_HeroHP, onRefresh_HeroHPHandler) 
			this._asset.addEventListener(MouseEvent.CLICK, onClick) 
			
		}
		
		private function onRefresh_HeroHPHandler(e:MeditorEvent):void
		{
			var vo:CharacterVO = e.data as CharacterVO;
			var tmp_bar:Sprite ;
			var tmp_hp:TextField;
			var tmp_name:TextField;
			var tmp_head:Bitmap;
			
			if(vo.camp != ArmyConfig.Camp_Enemy)
			{
				tmp_bar = this._masterBar;
				tmp_hp = this._masterHP;
				tmp_name = this._masterName;
				tmp_head = this._masterHead;
				
			}else{
				
				tmp_bar = this._enemyBar;
				tmp_hp = this._enemyHP;
				tmp_name = this._enemyName;
				tmp_head = this._enemyHead;
			}
			
			tmp_bar.width = vo.hp / vo.hp_max * this._barMaxWidth;
			tmp_hp.text = vo.hp.toString() + '/' + vo.hp_max.toString();
			tmp_name.text = vo.name;
			
			if(tmp_head.name != vo.gid){
				var bmt:BitmapData = this.getIcon(AssetsCfg.S_hero, vo.gid);
				tmp_head.bitmapData = bmt;
				tmp_head.name = vo.gid;
			}
		}
		
		protected function onClick(_event:MouseEvent):void
		{
			//this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Get_NextWave));
			_event.stopPropagation();
			if (_event.target is SimpleButton) {
				var _btn:SimpleButton = _event.target as SimpleButton;
				if (_btn.name == 'sys_btn') {//暂停
					
					var state:String = !this._pause ? StaticConfig.Game_Setting_Pause
						: StaticConfig.Game_Setting_PKBreak;
					CommandManager.GameSetting(state);
				}
			}else if(_event.target is Sprite){
				var sp:Sprite = _event.target as Sprite;
				if(sp.name == 'speed_mc')
				{
					CommandManager.GameSetting(StaticConfig.Game_Setting_SpeedUp);
					
				}else if(sp.name == 'scale_mc'){
					var scale:Number = _ML.game.scene_PK.scaleX;
					scale = scale == 1? 0.5:1;
					_ML.game.scene_PK.scaleX = _ML.game.scaleY = scale;
				}
			}

			
			

		}
		

		
		protected function onRemovedHandler(event:Event):void
		{
			this.clear();
		}
		
		override public function clear():void
		{
			super.clear();
			this._asset = null;
			this.mVo = null;
			this._masterBar = null;
		}
		
	
        
	}

}