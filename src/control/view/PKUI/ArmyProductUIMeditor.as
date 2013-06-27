package control.view.PKUI
{
	import control.view.CharacterMeditor;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import mx.core.SpriteAsset;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	import utils.SearchUtil;
	
	import view.character.CharacterBase;
	
	public class ArmyProductUIMeditor extends ViewWatcherMeditorBase
	{
		private var _view:ViewBase;

		private var _vo:Array;
		private var _heroSkills:Vector.<ViewBase>;
		private var _hero:GeneralVO;
		private var _character:CharacterBase;
		private var _charVO:CharacterVO;
		private var _container:Sprite;
		private var _active:Boolean;
		private var _friLis:Array;
		
		public function ArmyProductUIMeditor(viewUI:ViewBase, mod:ModelBase)
		{
			var asset:Object = viewUI.asset;
			_vo = mod.getVO() as Array;
			_view = viewUI;
			_container = new Sprite;
			_view.addChild(_container);
			super(viewUI, mod);
		}
		
		override protected function init():void
		{
			super.init();
			
			//initFriends();
			
		}
		 
		
		
		private function initFriends():void
		{
			GlobalUtil.removeAllChild(_container);
			
			var friLis:Array = _vo

			for(var i:int=0; i<friLis.length; i++)
			{
				
				var mod:GeneralModel = friLis[i];
				
				var hero:ViewBase = new ViewBase(_MM.getViewMaterial(AssetsCfg.ArmyProduct));

				var ctr:ArmyProductMeditor = new ArmyProductMeditor(hero, [mod, _ML.monarch_general]);
				_container.addChild(hero);

				hero.x = 8 + i * (hero.width+16);
				hero.y = 8;
				
				
			}

		}
		
		override public function update(data:Object):void
		{
			if(!data) return;
			var heros:Array= data as Array;
			_vo = heros;
			
			initFriends();
		}
		
		override protected function addListenerCfg():void
		{
			//heroSkill_btn.addEventListener(MouseEvent.CLICK, onClickHandler);
			this.addMeditorEventListener(MeditorEvent.Get_General, getGeneralHandler);
			this.addMeditorEventListener(MeditorEvent.SkillReady,skillReadyHandler);
			this.addMeditorEventListener(MeditorEvent.Wave_Clean, waveCleanHandler);
		}
		
		private function skillReadyHandler(e:MeditorEvent):void
		{
			var id : String = e.data as String;
			if(!this._hero || id != this._hero.id) return;
			_active = true;
			
			//heroSkill_btn.visible = true;
		}
		
		private function getGeneralHandler(e:MeditorEvent):void
		{
			_hero = SearchUtil.getItemByVOFromList('id', e.data, this._vo) as GeneralVO;
			_character = GameUtil.getCharacterById(_hero.id);
			this._charVO = GameUtil.getCharVOByViewId(_character.uid);
		}
		
		private function waveCleanHandler(e:MeditorEvent):void
		{
			_active = false;
			//heroSkill_btn.visible = false;
		}
		
		override protected function removeListenerCfg():void
		{
			//heroSkill_btn.removeEventListener(MouseEvent.CLICK, onClickHandler);
			this.removeMeditorEventListener(MeditorEvent.Get_General, getGeneralHandler);
			this.removeMeditorEventListener(MeditorEvent.SkillReady,skillReadyHandler);
			this.removeMeditorEventListener(MeditorEvent.Wave_Clean, waveCleanHandler);
		}
		
		/*private function onClickHandler(e:MouseEvent):void
		{
			
		}*/
 
	}
}