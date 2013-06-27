package control.view.PKUI
{
	
	import control.view.ViewColorCtrl;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewMeditorBase;
	import core.view.ViewWatcherMeditorBase;
	import core.view.ViewWatchersMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	import manager.ModelLocator;
	
	import model.UserModel;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.SearchUtil;
	
	import view.character.CharacterBase;
	import view.component.GameIcon;
	
	public class ArmyProductMeditor extends ViewWatchersMeditorBase
	{
		private var _view:ViewBase;
		private var _asset:Object;
		private var _vo:GeneralVO;
		private var _charVO:CharacterVO;
		
		private var _character:CharacterBase;
		
		private var _cd_skill:int;

		private var _count:int;
		private var _ready:Boolean;//cd完毕
		private var _active:Boolean;//技能释放
		private var _isGray:Boolean;
		private var _skill:SkillVO;
		private var _skillParams:Object;
		private var _mask:MovieClip;
		private var _icon:GameIcon;
		private var _colorCtrl:ViewColorCtrl;
		private var _iconContainer:MovieClip;//
		private var _monarchVO:GeneralVO;
		
		private var _food:int ;
		private var _delay:int=100;
		
		private var _foodTxt:TextField;
		private var _limitTxt:TextField;
		
		public function ArmyProductMeditor(viewUI:ViewBase, mods:Array)
		{
			_view = viewUI;
			_asset = viewUI.asset;
			
			_mask = _asset.mask_mc;
			_foodTxt = _asset.food_txt;
			_limitTxt = _asset.limit_txt;
			
			_iconContainer = _asset.icon_mc;

			
			
			super(viewUI, mods);
			
		}
		
		override protected function initModels(models:Array):void
		{
			super.initModels(models);
			var mission:Object = _ML.user.vo.mMession;
			var posX:int = mission.BaseSet.OurBornX;
			
			for each(var i:ModelBase in models)
			{
				if(i != _ML.monarch_general)
				{
					_vo = i.getVO() as GeneralVO;
					
					if(_vo){
						_count = _vo.cd_create*1000 / _delay;
						_food = _vo.cost;
						_foodTxt.text = _food.toString();
						//召唤技能
						_skill = new SkillVO();
						_skill.skillType = 'Summon';
						this._skillParams = {};
						_skillParams.heros = [];
						_skillParams.heros.push( _vo.id);
						_skillParams.pos = new Point(posX, 200+Math.random()*150);
					}
					
				}else{
					_monarchVO = i.getVO() as GeneralVO;
				}
			}
			
			
		}
		 
		override protected function init():void
		{
			super.init();
			
			_icon = new GameIcon();
			this._iconContainer.addChild(_icon);
			
			setHeroIcon();
			_colorCtrl.setGray();
			//skillStartCD();
			
		}
		
		override public function update(data:Object):void
		{
			if(data != this._monarchVO)
			{
				_vo = data as GeneralVO;
				this._limitTxt.text = _vo.limit.toString();
			}else{
				_active = this._monarchVO.food >= _food;
				
				if(_active)
				{
					if(_isGray)
					{
						_colorCtrl.resume();
						_isGray = false;
					}
				}else{
					if(!_isGray)
					{
						_colorCtrl.setGray();
						_isGray = true;
					}
				}
			}
		}
		
		private function setHeroIcon():void
		{
			_icon.show(AssetsCfg.S_hero, _vo.id);
			_colorCtrl = new ViewColorCtrl(_icon, _icon.bitmapData);
		}
		
		private function skillStartCD():void
		{
			
			GameUtil.delayExecuteFun(_delay, productReady, 0, this.mid, 'productReady');
		}
		
		private function productReady():void
		{
			_cd_skill +=1;
			_mask.scaleY = 1- _cd_skill / _count;
			
			if(_cd_skill >= _count)
			{
				trace(_vo.name + '生产激活');
				_ready = true;
				GameUtil.deleteDelayFun(this.mid);
				
			}
			
			
			
		}
		
		override protected function addListenerCfg():void
		{
			_view.addEventListener(MouseEvent.CLICK, onClickHandler);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler)
			this.addMeditorEventListener(MeditorEvent.Wave_Clean, waveCleanHandler);
			this.addMeditorEventListener(MeditorEvent.CoolDown_Start, onCDStartHandler)
		}
		
		private function onCDStartHandler(e:MeditorEvent):void
		{
			skillStartCD();
		}		
		
		protected function onRemovedHandler(event:Event):void
		{
			this.clear();
		}
		
		private function waveCleanHandler(e:MeditorEvent=null):void
		{
			this._ready = false;
			GameUtil.deleteDelayFun(this.mid);
			_cd_skill = 0;
			
		}
		
	
		
		override protected function removeListenerCfg():void
		{
			_view.removeEventListener(MouseEvent.CLICK, onClickHandler);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler)
			this.removeMeditorEventListener(MeditorEvent.Wave_Clean, waveCleanHandler);
			this.removeMeditorEventListener(MeditorEvent.CoolDown_Start, onCDStartHandler);

		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			
			event.stopPropagation();

			if(this._ready)
			{
				if(_monarchVO.food < _food || _vo.limit<1) return;
				else{
					_monarchVO.food -= _food;
					_ML.monarch_general.setVO(_monarchVO);
				}
				
				_vo.limit --;
				this._limitTxt.text = _vo.limit.toString();
				
				CommandManager.SearchTargetForSkill({
					params:this._skillParams,
					skill : _skill});
 
				this._active=  false;
				this.setHeroIcon();
				
				this._ready = false;
				_cd_skill = 0;
				skillStartCD();
				
				
			}

		}
		
		override public function clear():void
		{
			super.clear();
			this._asset = null;
			this._view = null;
			this._vo = null;
			this._character = null;
			this._skill = null;
			this._mask = null;
			this._icon = null;
			this._iconContainer = null;
			this._MM = null;
			this._charVO = null;
			this._monarchVO = null;
			this._skillParams = null;
			this._foodTxt = null;
			this._limitTxt = null;
		}
		 
	}
}