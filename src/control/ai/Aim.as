
package control.ai
{
	import component.Dict;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 *水平瞄准
	 * Aim.as class. 
	 * @author Administrator
	 * Created 2013-5-4 下午2:36:12
	 */ 
	public class Aim extends CharacterAI
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function Aim(meditor:CharacterMeditor)
		{
			super(meditor);
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
				
				p  = new Point(_target.x-character.x, _target.y-character.y);
				dis = p.length;
				
				range_atk = _vo.range_atk;

				var _pos:Vector2D ;
				
				if(dis <= range_atk)
				{
					if(Math.abs(character.y-_target.y)>10)
					{
						_pos = new Vector2D(character.x , _target.y);
						super.move();
						rush(_pos);
					}else{
						if(this._isCD) _act = wait;
						else _act = attack;
					}
					
					
				}else{
					
					_pos  = new Vector2D(_target.x , _target.y);
					super.move();
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
					//this.die();
				}
				
			}
			
			if(_act==null) _act = move
		}
		
		override public function attack():void
		{
			playSound(this._vo.res, ArmyConfig.State_Atk);
			var state:String =  _skillType == StaticConfig.SkillType_Active 
				? ArmyConfig.State_Skill 
				: ArmyConfig.State_Atk;
			

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
				super.injured();
				_act = null;
				if(this._isCD) _actNext = wait;
				else _actNext = move
			}
			
		}
		
		
		protected function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();
			
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
			
			
		}
		
		override public function search():CharacterBase
		{
			
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
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
			
			//if(_ML.master) return _ML.master;
			return null;
			
			
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
			}else{
				
				if(Math.random()>0 && _vo.cd_skill<=0 && _vo.camp!=1)
				{
					_skillType =  StaticConfig.SkillType_Active;
					_skillVO = _vo.skill_active[0];
				}else{
					_skillType =  StaticConfig.SkillType_Normal;
					_skillVO = _vo.skill_normal;
				}
				
				
				
			}
			
			_vo.range_atk = _skillVO.range;
			_vo.init_range_atk = _skillVO.range;
		}
		
		
		
	}
	
}