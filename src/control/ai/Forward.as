package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	/**
	 *谁惹我就干谁
	 * @author Administrator
	 * 
	 */	
	public class Forward extends CharacterAI
	{
		
		
		public function Forward(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_isMagic = GameUtil.isMagicAtkOnly(_vo.armyType);
		}
		
		override public function move():void
		{
			
			this.checkTarget();
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			if(!_target) _target = this.search(); 
			
			if(_target)
			{
				var dir:String = GameUtil.getCharacterDirByPos(character, _target);
				if(_vo.dir != dir)
				{
					_vo.dir = dir;
					_model.setVO(_vo);
				}
 
				var dis:Number;
				var targetType:String = _target.armyType;
				var range_atk:int;
				var p:Point;
				if(targetType == ArmyConfig.Type_Wall)
				{
					p = new Point(_target.x - character.x, 0);
					range_atk = _vo.range_atk + 30;
				}else{
					p  = new Point(_target.x-character.x, _target.y-character.y);
					
					range_atk = _vo.range_atk;
				}
				dis = p.length;
				if(dis <= range_atk && dis >=0)
				{
					if(this._isCD) _act = wait;
					else _act = attack;
				}else{
					
					super.move();
					var _pos:Vector2D = targetType == ArmyConfig.Type_Wall
						? new Vector2D(_target.x , character.y)
						: new Vector2D(_target.x , _target.y);
					
					rush(_pos);
					
					
				}

			}else{
				var isDefault:Boolean = GameUtil.isDefaultDir(_vo.camp);
				dir = GameUtil.getCharacterDefaultDir(_vo.camp, isDefault);
				_vo.dir = dir;
				_model.setVO(_vo);					
				super.move();
				this.character.x += _vo.speed* _vo.scaleX;
				
				if(this.character.x > _ML.game.scene_PK.map.width-this.character.width)
				{
					this.wait();
				}
				
			}
			
			if(_act==null) _act = move
		}
		
		protected function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();

			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
			
			
		}
		
		override protected function checkTarget():void
		{
			if(_target)
			{
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(_target.uid) 
					as CharacterMeditor;
				if(!meditor_target.model)
				{
					_target = null;
				}else{
					var vo:CharacterVO = meditor_target.model.getVO() as CharacterVO;
					if(!GameUtil.isArmyAlive(vo.camp, _target.uid))
					{
						_target = null;
					}
				}
				
			}
				
			
		}
		
		override public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			//改变目标
			/*if(isLock)
			{
				_target = target;
				return;
			}
			//优先打城墙
			if(target != _target)
			{
				if(!_target) _target = target;
				else{
					var type:String = _target.armyType;
					if(type == ArmyConfig.Type_Wall)_target = target;
				}
				
			}*/
			_target = target;	
		}
		override public function search():CharacterBase
		{
			
			/*var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			if(!lis) return null;
			
			var list:Array = []; 
			
			for each(var i:CharacterBase in lis.dict)
			{
				var p:Point = new Point(i.x - this.character.x, i.y - character.y);
				
				var dis:Number = p.length;
				if( dis <= _vo.range_guard )
				{
					return i;
				}
				
			}

			return null;*/
			if(_vo.armyType != ArmyConfig.Type_Dancer)
			{
				return AISearch.searchNearbyArmy(this._vo, this.character);
			}else{
				return AISearch.searchTreateArmy(this._vo, this.character);
			}
 
		}
		
		
		override public function attack():void
		{
			playSound(this._vo.res, ArmyConfig.State_Atk);
			var state:String =  _skillType == StaticConfig.SkillType_Active 
								? ArmyConfig.State_Skill 
								: ArmyConfig.State_Atk;
			
//			_meditor.updateSheet(state);
			this._isCD = true;
			
			_act = null;
			_actNext = wait;
			
			if(_target)
			{
				//生成子弹
				//CommandManager.createBullet({atker:character, target:_target});
				setSkill();
				CommandManager.createSkill({ai:this, 
											skill:this._skillVO, 
											target:this._target},
											this._skillType);
			}
			
			
		}
		
		override public function injured():void
		{
 
			if(_vo.hp <=0)
			{
				_vo.hp = 0;
				_act = die;
				
			}else{
				if(_vo.state.indexOf(ArmyConfig.State_Atk)== -1)
				{
					super.injured();
					
				} 
				 
				_act = null;
				if(this._isCD) _actNext = wait;
				else _actNext = move
			}
			
			this.refreshHeroHP();
		}
		
		override public function die():void
		{
			super.die();
			_act = null;
			_actNext = dieEffect
			
			
		}
		
		override public function wait():void
		{
			super.wait();
			
			if(!_skillVO) setSkill();
			
		}
		
		private function setSkill():void
		{
			
			if(this._isMagic)
			{
				_skillVO = _vo.skill_active[0];
				_skillType =  StaticConfig.SkillType_Active;
				_vo.cd_atk = _skillVO.cd * 1000 / _vo.delay;

			}else{
				
				if(_vo.skill_active.length 
					&& Math.random()>0 
					&& _vo.cd_skill<=0 
					&& _vo.camp ==2)
				{
					_skillType =  StaticConfig.SkillType_Active;
					_skillVO = _vo.skill_active[0];
				}else{
					_skillType =  StaticConfig.SkillType_Normal;
					_skillVO = _vo.skill_normal;
					
					_vo.init_range_atk = _skillVO.range;
				}
				
				
				
			}
			
			_vo.range_atk = _skillVO.range;
			
		}
 

	}
}