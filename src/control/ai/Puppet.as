
package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.component.Zone;
	import view.character.CharacterBase;
	
	/**
	 *可操控 
	 * @author Administrator
	 * 
	 */	
	public class Puppet extends CharacterAI
	{
		private var _cd_reborn:int=1;
		
		private var _isAtked:Boolean;
		
		private var _ispeace:Boolean;
		private var _tarPos:Point;
		private var _isCombo:Boolean;
		private var comboNum:int;
		private var comboMax:int = 3;
		
		public function Puppet(meditor:CharacterMeditor)
		{
			
			super(meditor);
			
			//			_vo.cd_atk = 1000;
			/*_vo.atk = 50;
			_vo.hp_max = _vo.hp = 100000;
			_vo.cd_atk = 10;
			_vo.range_guard = 100;*/
			//_vo.speed = 0.4;
			
		}
		
		override protected function addListenerCfg():void
		{
			super.addListenerCfg();
			this.addMeditorEventListener(MeditorEvent.MoveToTargetPos, onMoveToTargetPosHandler)
			
		}
		
		private function onMoveToTargetPosHandler(e:MeditorEvent):void
		{
			_tarPos = e.data as Point;
			
			 
			if(!_tarPos)
			{
				_isCombo = false;
				comboNum = 0;
				
				_ispeace = false;
				this._act = wait;
				return;
			}
			
			_ispeace = true;
			this._act = move;
			
			_vo.dir = GameUtil.getCharacterDirByPoint(this.character, _tarPos);
			_model.setVO(_vo);
		}
		
		override protected function removeListenerCfg():void
		{
			this.removeMeditorEventListener(MeditorEvent.MoveToTargetPos, onMoveToTargetPosHandler)
			
		}
		
		override public function move():void
		{
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			
			if(_ispeace && _vo.hp)
			{
				dis = GlobalUtil.getDistance(character.x, character.y, _tarPos.x, _tarPos.y)
				if(dis < 2)
				{
					_ispeace = false;
					_act = wait;	
					
				}else{
					coord = new Vector2D(_tarPos.x , _tarPos.y);
					super.move();
					rush(coord);
					
				}
				
				return;
			}
			_target = this.search();
			
			var coord:Vector2D;
			if(_target)
			{
				_ML.master_atkTarget = _target;
				_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
				_model.setVO(_vo);
				
				var point:Point = new Point(_target.x-character.x,_target.y-character.y);
				var dis:Number = point.length;
				if(dis <= _vo.range_atk && dis >=0)
				{
					if(this._isCD) _act = wait;
					else _act = attack;
					
				}/*else{
				
				coord = new Vector2D(_target.x+30 , _target.y);
				super.move();
				rush(coord);
				}*/
				
			}else{
				_ML.master_atkTarget = null;
				_actNext = wait;
			}
			
			
		}
		
		override public function action():void
		{
			super.action();
			if(_ML && _ML.isCharSort)
			{
				GlobalUtil.SortContainerChildren(character.parent);
				_ML.isCharSort = false;
			}
			
		}
		
		private function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();
			var movSpeed:Number = _steeredVector.x - character.x
			
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.FollowCamera,
				{pos:new Point(this.character.x, this.character.y), 
					speed:movSpeed}));
		}
		
		override public function search():CharacterBase
		{
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			
			var dict:Dictionary = lis.dict;
			var disLis:Array = [];
			for each(var i:CharacterBase in dict)
			{
				var point:Point = new Point(i.x-character.x,i.y-character.y);
				var dis:Number = point.length;
				if( dis <= _vo.range_guard )
				{
					disLis.push({itm:i, num:dis});
				}
				
			}
			disLis.sortOn('num', Array.NUMERIC);
			var target:CharacterBase = disLis.length? disLis[0].itm : null;
			return target;
		}
		
		
		
		override public function attack():void
		{
			playSound(this._vo.gid , ArmyConfig.State_Atk);
			var state:String;
			if(_isCombo)
			{
				comboNum = comboNum < comboMax ? comboNum+1 : 1;
				state = _vo.gid + '_attack0' + comboNum;
				
			}else{
				_meditor.updateSheet(ArmyConfig.State_Atk);
				comboNum = Math.min(comboNum+1, comboMax);
			}
			_isCombo = true;
			this._isAtked = true;
			_act = null;
			_actNext = wait;
			
			if(_target)
			{
				
				CommandManager.createSkill({ai:this, skill:_vo.skill_normal, 
					target:this._target, charState:state},
					StaticConfig.SkillType_Normal);
			}
			/*if(_target && _skillVO)
			{
			
			CommandManager.createSkill({ai:this, skill:_skillVO, 
			target:this._target}, 
			StaticConfig.SkillType_Active);
			_skillVO = null;
			}*/
			
		}
		
		override public function wait():void
		{
			super.wait();
			if(_isAtked)
			{
				this._isAtked = false;
				this._isCD = true;
			}else{
				_actNext = wait;
			}
			
		}
		override public function injured():void
		{
			
			
			if(_vo.hp <=0)
			{
				_vo.hp = 0;
				_act = null;
				this.die();
			}else{
				if(_vo.state.indexOf(ArmyConfig.State_Atk)== -1)
				{
					super.injured();
					
				} 
				_actNext = move;
				
			}
			
			this.refreshHeroHP();
		}
		
		override public function die():void
		{
			trace('赵云挂了！！！！！！！！！！！！！！！！！！！！')
			super.die();
			_act = null;
			_actNext = dieEffect
			
			_ML.dialogType = StaticConfig.Dialog_BattleFail;
			CommandManager.CreateBattleStory(_ML.user.vo.seleced_mession);
			
			/*GameUtil.delayExecuteFun(1000, CommandManager.CreateBattleStory, 
									 1, 'PKFail'+this.mid,null,null,null,
									 [_ML.user.vo.seleced_mession]);*/
		}
		
		private function PKFail():void
		{
			
			//CommandManager.CreateBattleStory();
			
		}
		
		override public function dieEffect():void
		{
			super.dieEffect();
				
		}
		/*override public function reborn():void
		{
		if(_cd_reborn++ * _vo.delay >= _vo.cd_reborn )
		{
		this._isCD = false;
		super.reborn();
		_cd_reborn = 0;
		
		}else{
		this._isCD = true;
		}
		
		}*/
		
		override public function clear():void
		{
			super.clear();
			this._target = null;
		}
	}
}