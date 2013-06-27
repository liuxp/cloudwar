package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.component.Zone;
	import view.character.CharacterBase;

	/**
	 *环绕AI 
	 * @author Administrator
	 * 
	 */	
	public class Surround extends CharacterAI
	{
		protected var _pos:Point;

		private var _cd_reborn:int=1;
		
		private var _injuredNum:int;
		
		public function Surround(meditor:CharacterMeditor, zone:Zone=null)
		{
			
			super(meditor);
			
			_vo.cd_atk = 20;
			_pos = new Point(character.x, character.y);
		}
		
		override public function move():void
		{
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			
			//			this.checkTarget();
			_target = this.search();
			
			var coord:Vector2D;
			if(_target)
			{
				_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
				_model.setVO(_vo);
				
				var point:Point = new Point(_target.x-character.x,_target.y-character.y);
				var dis:Number = point.length;
				if(dis <= _vo.range_atk && dis >=0)
				{
					if(this._isCD) _act = wait;
					else _act = attack;
					return;	
				}else{
					
					coord = new Vector2D(_target.x , _target.y);
					super.move();
					rush(coord);
				}
				
			}else{
				
				dis = GlobalUtil.getDistance(character.x, character.y, _pos.x, _pos.y)
				if(dis < 2)
				{
					_act = wait;
					
				}else{
					coord = new Vector2D(_pos.x , _pos.y);
					_vo.dir = GameUtil.getCharacterDirByPoint(character,new Point(_pos.x, _pos.y));
					_model.setVO(_vo);
					super.move();
					rush(coord);
				}
				
				
			}
			
			
		}
		
		private function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
		}
		
		override public function search():CharacterBase
		{
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			
			var list:Array = []; 
			
			for each(var i:CharacterBase in lis.dict)
			{
				var point:Point = new Point(i.x - character.x, i.y - character.y);
				var dis:Number = point.length;
				if( dis <= _vo.range_guard )
				{
					return i;
				}
				
			}
			
			return null;
		}
		
		override public function wait():void
		{
			super.wait();
			if(_cd_wait ++ % _vo.cd_atk == 0)
			{
				this._isCD = false;
				_act = move;
			}else{
				this._isCD = true;
				_act = wait;
			}
		}
		
		override public function attack():void
		{
			super.attack();
			
			_act = null;
			_actNext = wait;
			
			if(_target)
			{
				//生成子弹
				//CommandManager.createBullet({atker:character, target:_target});
				CommandManager.createSkill({ai:this, skill:_vo.skill_normal, target:this._target},
											StaticConfig.SkillType_Normal);
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
			this.refreshHeroHP();
		}
		
		override public function die():void
		{
			super.die();
			_act = null;
			_actNext = dieEffect
			
			
		}
		
		/*override public function dieEffect():void
		{
			var die:DieAway = new DieAway(character.dispose)
			die.target = this.character;
			die.render();
			die.clear();
			this.character.dispose();
			this.stop();
			_act = null;
			_actNext = null;
			
		}*/
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
		override public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			//改变目标
			_target = target;	
		}
		override public function clear():void
		{
			super.clear();
			this._pos = null;
			this._target = null;
		}
	}
}