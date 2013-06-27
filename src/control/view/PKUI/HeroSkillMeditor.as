package control.view.PKUI
{
	import control.view.ViewColorCtrl;
	import control.view.CharacterMeditor;
	
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
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.SkillModel;
	import model.UserModel;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	import model.vo.UserVO;
	
	import utils.ColorTransUtil;
	import utils.GameUtil;
	import utils.MatrixUtil;
	
	import view.character.CharacterBase;
	import view.component.GameIcon;
	
	public class HeroSkillMeditor extends ViewWatchersMeditorBase
	{
		private var _view:ViewBase;
		private var _asset:Object;

		private var _vo:GeneralVO;
		private var _character:CharacterBase;
		private var _charMeditor:CharacterMeditor;
		private var _delay:int=100;
		private var _cd_skill:int;
		private var _cd_reborn:int;
		private var _count:int;
		private var _ready:Boolean;//cd完毕
		private var _active:Boolean;//技能释放
		private var _skill:SkillVO;
		private var _mask:Sprite;
		private var _colorCtrl:ViewColorCtrl;
		private var _icon:GameIcon;
		private var _iconContainer:Sprite;//
		private var _isGray:Boolean;
		private var _energy:int = 20;
		
		private var _energyTxt:TextField;
		
		public function HeroSkillMeditor(viewUI:ViewBase, models:Array)
		{
			_view = viewUI;
			_asset = viewUI.asset;
			
		
			_mask = _asset.mask_mc;
			_iconContainer = _asset.icon_mc;
			_energyTxt = _asset.energy_txt;
			
			
			super(viewUI, models);
		}
		
		override protected function initModels(models:Array):void
		{
			super.initModels(models);
			for each(var i:ModelBase in models)
			{
				if(i as SkillModel)
				{
					_skill = i.getVO() as SkillVO;
					if(_skill)
					{
						_count = _skill.cd*1000  / _delay;
						_energy = _skill.mp;
						_energyTxt.text = _energy.toString();
						
					}
					
					
				}else if( i as GeneralModel){
					_vo = i.getVO() as GeneralVO;
				}
			}
			
			
		}
		
		override public function update(data:Object):void
		{
			if(data as GeneralVO)
			{
				_vo = data as GeneralVO;
				_active = _vo.energy >= _energy;
				
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
				
			}else{
				if(!_count) _count = _skill.cd*1000  / _delay;
				if(!_energyTxt.text)
				{
					_energy = _skill.mp;
					_energyTxt.text = _energy.toString();
				}
			}
		}
		 
		override protected function init():void
		{
			super.init();
			
			_icon = new GameIcon();
			this._iconContainer.addChild(_icon);
 
			getSkillIcon();
			
			_colorCtrl.setGray();
			
			//skillStartCD();

			

		}
		
		private function getSkillIcon():void
		{
			_icon.show(AssetsCfg.SkillIcon, _skill.id);
			_colorCtrl = new ViewColorCtrl(this._icon, _icon.bitmapData);
		}
		
		 
		
		 
		
		private function skillStartCD():void
		{
			
			GameUtil.delayExecuteFun(_delay, skillReady, 0, this.mid, 'skillready');
		}
		
		private function skillReady():void
		{
			_cd_skill +=1;
			_mask.scaleY = 1- _cd_skill / _count;
			
			if(_cd_skill >= _count)
			{
				if(_vo) trace(_vo.name + '技能激活');
				_ready = true;
				
				GameUtil.deleteDelayFun(this.mid);
				 
			} 
		}
		 
		override protected function addListenerCfg():void
		{
			if(GameUtil.isSupportTouch())
			{
				_view.addEventListener(TouchEvent.TOUCH_BEGIN, onClickHandler);
			}else{
				_view.addEventListener(MouseEvent.CLICK, onClickHandler);
			}
			
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler)
			this.addMeditorEventListener(MeditorEvent.Wave_Clean, waveCleanHandler);
			this.addMeditorEventListener(MeditorEvent.CoolDown_Start, onCDStartHandler);
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
		
		protected function onClickHandler(event:Event):void
		{
			
			event.stopPropagation();

			
			if(this._ready && this._active)
			{
				if(!_character)
				{
					_character = _ML.master;
					_charMeditor = GameUtil.getCharMeditorByViewId(_character.uid);
					
				}
				if(!_charMeditor.ai.isAlive) return;
				
				CommandManager.createSkill({ai:_charMeditor.ai, 
											skill:_skill, 
											target:null},
					StaticConfig.SkillType_Active);
				
				this._active=  false;
				this._ready = false;
				_cd_skill = 0;
				skillStartCD();
				
				_vo.energy = Math.max(0, _vo.energy - _energy);
				
			}
 
		}
		 
		override public function clear():void
		{
			super.clear();
			this.waveCleanHandler();
			this._asset = null;
			this._view = null;
			this._vo = null;
			this._skill = null;
			this._mask = null;
			this._colorCtrl.clear();
			this._colorCtrl = null;
			this._icon = null;

			this._iconContainer = null;
			this._character = null;
			this._charMeditor = null;
			
			_energyTxt = null;
		}
		
 
	}
}