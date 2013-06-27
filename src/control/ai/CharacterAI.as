package control.ai
{
	import component.vector.SteeredVector;
	
	import control.fsm.StateMachine;
	import control.fsm.character.CharacterAgent;
	import control.fsm.character.Wait;
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	
	import core.meditor.MeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.SearchUtil;
	
	import view.character.CharacterBase;
	import view.character.ICharacter;
	
	public class CharacterAI extends MeditorBase implements ICharacter 
	{
		/*public var fsm:StateMachine;
		public var agent:CharacterAgent;*/
		
		public var _meditor :CharacterMeditor;
		public var _model:CharacterModel;
		public var _vo :CharacterVO;
		public var character :CharacterBase;
		protected var armyType:String;
		protected var _steeredVector:SteeredVector; //转向向量
		protected var _ML :ModelLocator = ModelLocator.getInstance();
		protected var _cd_wait:int = 0; //冷却时间
		protected var _cd_skill:int = 20;
		protected var _act:Function;//行为状态
		protected var _actNext:Function;//下一个行为状态
		protected var _actSkill:Function;
		public var _target:CharacterBase;//目标
		public var _isCD:Boolean;
		protected var _general:GeneralVO;
		protected var _delayId:String;
		protected var _skill:Object;
		private var _isSkill:Boolean;
		public var isAlive:Boolean=true;
		
		protected var _skillType:String;
		protected var _skillVO:SkillVO;
		protected var _isMagic:Boolean;
		
		public function CharacterAI(meditor:CharacterMeditor)
		{
			super();
			
			_meditor = meditor;
			_model = _meditor.model as CharacterModel;
			_vo = _model.getVO() as CharacterVO;
			
			character = _meditor.view as CharacterBase;
			
			//_general = GameUtil.getPKArmyData(_vo.camp, this.character.name);
			
			this.armyType = _vo.armyType;
			this._delayId = character.uid;
			_steeredVector = new SteeredVector();
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			_steeredVector.maxSpeed = _vo.speed  ;
			
			addListenerCfg();
		}
		
		
		protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.AI_Stop, onAIStopHandler)
			
		}
		
		protected function removeListenerCfg():void
		{
			this.removeMeditorEventListener(MeditorEvent.AI_Stop, onAIStopHandler);
		}
		
		private function onAIStopHandler(e:MeditorEvent):void
		{
			stop();
			
		}
		
		public function start():void
		{
			if(!_vo) return;
			_steeredVector.maxSpeed = _vo.speed  ;
			GameUtil.delayExecuteFun(_vo.delay, action, 0, 'ai' + _delayId, 'action'); 
		}
		
		public function stop():void
		{
			GameUtil.deleteDelayFun('ai' + _delayId);
		}
		
		public function setPlayRate(delay:uint, speed:Number):void
		{
			stop();
			_vo.speed = speed;
			_vo.delay = delay;
			
			start();
		}
		
		public function action():void
		{
			if(_act == null) return;
			
			if(this._isCD)
			{
				_cd_wait++;
				if(_cd_wait / _vo.cd_atk >=1)
				{
					_cd_wait = 0;
					this._isCD = false;
					
				}
			}
			
			if(_vo.cd_skill >0)
			{
				_vo.cd_skill--;
			} 
			
			if( _actSkill == null)
			{
				_act();
				
			}else{
				if(this.isAlive) _actSkill();
				
			}
			
		}
		
		public function nextAction():void
		{
			if(_actNext!=null)
			{
				_act = this._actNext;
			}
			_actNext = null;
		}
		
		public function cast():void
		{
			
			
			trace('释放技能！！！！！！！！！！！！！！！！！！！！！！！')
			CommandManager.SearchTargetForSkill(_skill);
			this._meditor.resumeAtk();
			_actSkill = null;	
			
			if(this._vo.hp <=0)
			{
				_act = die;
				
			}else{
				this._isCD = true;
				_act = null;
				_actNext = wait;
			}
			
			_skill = null;
			
		}
		
		
		public function releaseSkill(skill:Object):void
		{
			_skill = skill;
			_isSkill = true;
			
			this._meditor.updateSheetBySkill(_skill.skill.charState);
			_act = null;
			_actSkill = cast;
			_model.setVO(this._vo);
			
		}
		public function wait():void
		{
			
			_meditor.updateSheet(ArmyConfig.State_Wait);
			
			if(this._isCD)
			{
				_actNext = wait;
				
			}else{
				_act = move;
			}
			
			
		}
		
		public function move():void
		{
			playSound(this._vo.res, ArmyConfig.State_Mov, true);
			_meditor.updateSheet(ArmyConfig.State_Mov);
			_ML.isCharSort = true;
		}
		
		public function injured():void
		{
			playSound(this._vo.res, ArmyConfig.State_Injured);
			_meditor.updateSheet(ArmyConfig.State_Injured);
			
			
		}
		
		public function resume():void
		{
			refreshHeroHP();
		}
		
		public function refreshHeroHP():void
		{
			if((_vo.armyType == ArmyConfig.Type_General
				&& _vo.camp == ArmyConfig.Camp_Enemy)
				|| _vo.armyType == ArmyConfig.Type_Monarch)
			{
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Refresh_HeroHP, _vo));
			}
		}
		
		public function attack():void
		{
			playSound(this._vo.res, ArmyConfig.State_Atk);

			_meditor.updateSheet(ArmyConfig.State_Atk);
			this._isCD = true;
		}
		
		public function die():void
		{
			isAlive = false;
			
			//清掉缓存数据
			GameUtil.ClearArmy(_vo.camp, character.uid);
			GameUtil.ClearPKArmyData(_vo.camp, character.name);
			
			_meditor.updateSheet(ArmyConfig.State_Die);
 
			/*var sndName:String;
			switch(this.armyType)
			{
				case ArmyConfig.Type_Dancer :
					sndName = ArmyConfig.Type_Dancer;
					break;
				case ArmyConfig.Type_Catapult :
				case ArmyConfig.Type_Wall :
					sndName = ArmyConfig.Type_Catapult;
					break;
				default :
					sndName = ArmyConfig.Type_Walk;
					break;
			}*/
			playSound(this._vo.res, ArmyConfig.State_Die);
			
			
		}
		
		public function dieEffect():void
		{
			
			//隐藏血条
			//this.character.barHp.visible = false;
			//清除英雄
			if(_ML.master_atkTarget == this.character)
			{
				_ML.master_atkTarget = null;
			}
			/*var die:DieAway = new DieAway(character.dispose)
			die.target = this.character;
			die.render();
			die.clear();*/
			//			this.stop();
			//			this.character.removeFromParent();
			//			ModelLocator.getInstance().game.scene_PK.container_corpse.addChild(this.character);
			/*var mix:Matrix = new Matrix(1,0,0,1,
			this.character.x-this.character.bitmap.x*0.5, 
			character.y+this.character.bitmap.y);
			
			var _bit:BitmapData = new BitmapData(character.width, 
			character.height,
			true, 0x00000000);
			
			_bit.draw(this.character, new Matrix(1,0,0,1, 
			this.character.bitmap.x*0.5, 
			-this.character.bitmap.y));
			
			CommandManager.CreateBattleMap({bit:_bit, matrix: mix})*/
			
			if(_vo.camp == ArmyConfig.Camp_Enemy && GameUtil.isNpcGeneralsClear())
			{
				_ML.dialogType = StaticConfig.Dialog_BattleWin;
				CommandManager.CreateBattleStory(_ML.user.vo.seleced_mession);
				
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Wave_Clean));
				
				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.AI_Stop));
			}
			
			this.character.dispose();
			_act = null;
			_actNext = null;
			
			
			
		}
		public function search():CharacterBase
		{
			return null;
		}
		
		protected function checkTarget():void
		{
			var isSearch:Boolean;
			
			if(_target)
			{
				if(GameUtil.isArmyAlive(_vo.camp, _target.uid))
				{
					var p:Point = new Point(_target.x - this.character.x, _target.y - character.y);
					
					var dis:Number = p.length;
					
					if(dis > _vo.range_guard) isSearch = true;
					
				}else{
					isSearch = true;
				}
				
			}else{
				isSearch = true;
				
			}
			
			if(isSearch) _target = this.search();
		}
		
		public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			_target = target;
		}
		
		public function reborn():void
		{
			this._isCD = true;
			//CommandManager.rebornArmy({hero:this.character, camp:_vo.camp});
			
		}
 
		public function checkAlive():void
		{
			if(_vo.hp <=0)
			{
				_act = null;
				_actNext = die
				
			}
		}
		override public function clear():void
		{
			
			this.removeListenerCfg();
			
			this.stop();

			_meditor = null;
			_model = null;
			_vo = null;
			//			character = null;
			
			this._steeredVector.clear();
			this._steeredVector = null;
			character
			_ML = null;
			_target = null;
			_act = null;
			_actNext = null;
			_actSkill = null;
			this._general = null;
			_skill = null;
			_skillVO = null;
			
		}
		
		protected function playSound(state:String, type:String=null, isLock:Boolean=false):void
		{
			var sndName:String = type ? type : this.armyType;
			//if(Math.abs(this.character.x - _ML.master.x)>_ML.camera.x_marginL) return;
			SoundManager.playSound(state + '_' + type, false, isLock);
		}
		
	}
}