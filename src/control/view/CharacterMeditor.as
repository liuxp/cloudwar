package control.view
{
	import component.Dict;
	
	import control.ai.AIFactory;
	import control.ai.CharacterAI;
	import control.view.sheet.SheetRender;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	import view.component.Zone;

	/**
	 *角色控制器 
	 * @author Administrator
	 * 
	 */	
	public class CharacterMeditor extends ViewWatcherMeditorBase 
								  
	{
		private var _view:CharacterBase;
		private var _vo:CharacterVO;
		private var _render:SheetRender;
		private var _delay:uint = 60;//延迟
		private var _initDelay:uint=_delay;
		private var _isRender:Boolean;
		private var _loop:Boolean;//循环播放
		public var ai:CharacterAI;
 
		private var _shift:Boolean;
		private var _zone:Zone;
		private var _debuff:Dict;
		private var _selected:Boolean;
		
		public function CharacterMeditor(viewUI:ViewBase, mod:ModelBase, zone:Zone=null)
		{
			_debuff = new Dict();
			_view = viewUI as CharacterBase;
			_vo = new CharacterVO;
			_zone = zone;
			
			_vo.delay = 60;
			
			_delay = _vo.delay;
			
			MeditorManager.addMeditor(viewUI.uid, this);
			
			
			
			super(viewUI, mod);
			
			
		}
 
		override public function get view():ViewBase
		{
			return _view;
		}
	
		
		override public function update(data:Object):void
		{
			
			var vo:CharacterVO  = data as CharacterVO;
			 GameUtil.setCharacterDirInfo(vo);
			
			 if(_view.bitmap.scaleX != vo.scaleX)
			 {
				 _view.bitmap.scaleX = vo.scaleX;
 
				 var srcBit:BitmapData = _view.bitmap.bitmapData;
				 if(srcBit)
				 {
					 
					 setBitPos(srcBit);
				 }
				 
			 }
	 
			
			
			if(!_render)
			{
				_render = new SheetRender(vo, _view.types);
				_render.running = true;
				
			}
			
			this.updateSheet(vo.state);
			
			_vo = vo;
			
			
			_loop = GameUtil.isSheetStateLoop(_vo.state);
			
			if(!_isRender)
			{
				_isRender = true;
				renderStart();
				
				ai = AIFactory.getAI(_vo, this as CharacterMeditor, _zone);
				
//				aiStart();
			}
			
//			changeHpBar();
			//当角色死亡则恢复播放速度
			if(this._shift && _vo.hp <=0)
			{
				_shift = false;
				resumeSpeed();
			}
		}
		
		public function aiStart():void
		{
			if(_vo.camp == ArmyConfig.Camp_Me) ai.wait();
			else ai.wait();
			this.ai.start();
		}
		
		private function changeHpBar():void
		{
			var w:int = Math.max(0,(_vo.hp / _vo.hp_max)*40);
			_view.setHp(w,40);
			//_view.barHp.x = - _view.barHp.width*0.5;
			_view.barHp.y = - _render.bitH;
			
		}
		
		public function updateSheet(state:String):void
		{
			_render.chageState(state, true, true);
			
			//攻击特效
			if(_vo.state !=ArmyConfig.State_Atk)
			{
				GlobalUtil.removeAllChild(_view.container_temp);
			}
			/*if(_vo.state == ArmyConfig.State_Atk)
			{
				var atkEft:SheetSprite = new SheetSprite(_vo.res);
				new EffectMeditor(atkEft, 0, false, this._delay);
				atkEft.scaleX = _vo.scaleX;
				_view.container_top.addChild(atkEft);
			}else{
				GlobalUtil.removeAllChild(_view.container_top);
			}*/
		}
		
		public function setFollowFun(renderFrame:uint, fun:Function, funParams:Array):void
		{
			_render.setFollowFun(renderFrame, fun, funParams);
		}
		
		 
		
		public function updateSheetBySkill(state:String):void
		{
			GlobalUtil.removeAllChild(_view.container_top);
		
			_render.chageState(state,false, true);
		}
		
		
		override protected function addListenerCfg():void
		{
			/**移除view对象 liuxp 2011/9/20*/
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
			this.addMeditorEventListener(MeditorEvent.Render_Resume, renderStart);
			this.addMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.addMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.addMeditorEventListener(MeditorEvent.Select_Hero, selectHeroHandler);
		}
		
		private function selectHeroHandler(e:MeditorEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		public function renderStart(e:MeditorEvent=null):void
		{
			if(e && e.type == MeditorEvent.Render_Resume)
			{
				if( e.data != this._vo.gid) return;
			}
			
			GameUtil.delayExecuteFun(_delay, Play, 0, 'play'+_mid, 'Play');
			if(ai) ai.start();
			
		}
		public function renderStop(e:MeditorEvent=null):void
		{
			GameUtil.deleteDelayFun('play'+_mid);
			if(ai) ai.stop();
		}
		
		protected function removeLisCfg():void
		{
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
			this.removeMeditorEventListener(MeditorEvent.Render_Resume, renderStart);
			this.removeMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.removeMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
		}
		
		private function onClick(e:MouseEvent):void
		{
			//_view.showZone();
			/*if(_vo.hp<=0 ) return;
			 */
		}
		/**位图渲染*/
		public function Play():void
		{
			if(!this._render) return; 
			
			var srcBit:BitmapData = _render.render();
			
			if(srcBit)
			{
				_view.bitmap.bitmapData = srcBit;
				setBitPos(srcBit);
				
			}
			
			if(this._render.isEnd())
			{
				ai.nextAction();
				if(_vo.state == ArmyConfig.State_Die) return;

				if(this._loop)
				{
					_render.reset();	
				}else{
					_render.reset();
					this.updateSheet(ArmyConfig.State_Wait);
					
					//this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Sheet_PlayEnd, this._mid));
				}
				
				
			}
 
		}
		
		private function setBitPos(bit:BitmapData):void
		{
			var offsetX:int ; 
			var offsetY:int ;
			
			if(_render.coords)
			{
				//offsetX = bit.width*0.5;
				offsetX = - _render.coords[0];
				offsetY =  _render.coords[1];
			}else{
				offsetX = bit.width*0.5;
				offsetY = - bit.height;
			}
			
			_view.bitmap.x = _vo.scaleX < 0 ?  offsetX : -offsetX;
			_view.bitmap.y = offsetY;
		}
		
		public function SetPlayRate(delay:int, count:int, type:String, arg:Object=null):void
		{
			
			
			if(! this._debuff.isHaveItem(type))
			{
				this._debuff.AddItem(type, arg?arg:type);
			}else{
				
				this._debuff.setItemValue(type, arg?arg:type);
			}
			
			
			
			switch(type)
			{
				case StaticConfig.Skill_Shift :
					_delay = delay;
					GameUtil.deleteDelayFun('play'+_mid);
					GameUtil.delayExecuteFun(delay, Play, count, type + _mid, 'Play', resumeSpeed);
					break;
				case StaticConfig.Skill_DOT :
					GameUtil.delayExecuteFun(delay, Dot, count, type + _mid, 'Dot', null,null, [arg.dmg]);
					break;
				case StaticConfig.Skill_Cease :
					_delay = delay;
					GameUtil.deleteDelayFun('play'+_mid);
					GameUtil.delayExecuteFun(delay, cease, count, type + _mid, 'Play', resumeSpeed);
					break;
				default :
					break;
			}
 			
			_shift = true;
		}
		
		private function cease():void
		{
			//停止状态
		}
		
		private function Dot(value:int):void
		{
			_vo.hp -=value;
			_model.setVO(_vo);
			ai.checkAlive();
		}
		
		private function resumeSpeed():void
		{
			_delay = this._initDelay;
			
			_vo.delay = _vo.init_delay;
			_vo.speed = _vo.init_speed;
			
			this.renderStart();
			
		}		
		
		public function resumeAtk():void
		{
			if(_vo.init_cd_atk) _vo.cd_atk = _vo.init_cd_atk;
			if(_vo.init_range_atk) _vo.range_atk = _vo.init_range_atk; 	
		}
		
		private function clearDebuff():void
		{
			if(!this._debuff) return;
			
			var dict:Dictionary = this._debuff.dict;
			for(var i : String in dict)
			{
				GameUtil.deleteDelayFun(i + _mid);
			}
			
			this._debuff.DeleteAllItms();
			this._debuff = null;
		}
		
		 
		//移除对象
		protected function onRemovedHandler(e:Event):void
		{
			this.clear();
			//renderStop();
		}
		
		override public function clear():void
		{
			if(!this._model) return;
			
			super.clear();
			
			renderStop();
			clearDebuff();
 
			MeditorManager.removeMeditor(_mid);
 
			if(ai) ai.clear();
			ai = null;
			if(_render) _render.clear();
			_render = null;
			

			
			
			_vo = null;
 			_view = null;
			
 			_zone = null;
			
			
		}
		
		private function checkNextWave():void
		{
			
			if(GameUtil.isPKWin())
			{
				CommandManager.getWaveRwd();
			}
		}
	}
}