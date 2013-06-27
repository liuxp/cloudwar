
package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	import control.view.bullet.BulletMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.BulletVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	/**
	 *至死不移 
	 * @author Administrator
	 * 
	 */	
	public class Defend extends CharacterAI
	{
		
		private var _cd_reborn:int=1;

		private var _injuredNum:int;
		private var _waitMov:int = 40;
		private var _waitMovCount:int;
		private var _state:int=0;//0移动，1，攻击
		
		public function Defend(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_vo.cd_atk = 20;
		}
		
		override public function move():void
		{
//			this.checkTarget();
			_target = this.search();			
			
			
			if(_target)
			{
				var dir:String = GameUtil.getCharacterDirByPos(character, _target);
				if(_vo.dir != dir)
				{
					_vo.dir = dir;
					_model.setVO(_vo);
				}
 
				if(this._isCD) _act = wait
				else{
					//组装
					if(!_state)
					{
						trace('组装中!!!!!!!!!!!!!!!')
						if(_waitMovCount++ % _waitMov == 0) _state = 1;
					}else{
						_act = this.attack;
					}
					
				}
				
				
			}else{
				//组装
				if(_state)
				{	trace('组装中!!!!!!!!!!!!!!!')
					if(_waitMovCount++ % _waitMov == 0) _state = 0;
					return;
				}
				super.move();
				
				if( this.character.x - _ML.master.x >400 
					|| this.character.x - _ML.master.x <-400)
				{
					var lr:int = this.character.x > _ML.master.x ? -1 : 1;
					this.character.x += _vo.speed * lr;
				}else{
					_act = this.wait;
				}
				
			}
			
		}
		
		
		override public function search():CharacterBase
		{
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			var targets:Dictionary = lis.dict;
			var min_dis:int;
			var _target:CharacterBase;
			
			for(var i:String in targets)
			{
				var target:CharacterBase = targets[i];
				
				var p:Point = new Point(target.x - this.character.x, target.y - character.y);
				
				var dis:Number = p.length;
				
				if(dis <= _vo.range_guard)
				{
					_target = target;
					break;
				}
				
				/*if(dis < _vo.range_guard)
				{
					if(!_target)
					{
						_target = target;
						min_dis = dis;
					}else{
						if(dis < min_dis)
						{
							_target = target;
							min_dis = dis;
						}
					}
				}*/
			}
			
			if(_target)
			{
				return _target;
			}else{
				
				return null;
			}
			
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
				/*var def_skill:Object =  GameUtil.getCfgByItmID(StaticConfig.Cfg_DefSkill, 
																_vo.skill[1]);
				var bullet :String = def_skill.effect[0];*/
				//生成子弹
				CommandManager.createBullet({atker:character, 
											 target:_target/*, 
											 bullet:bullet, 
											 track:def_skill.track,
											 effect:def_skill.effect[1]*/
				});
						 
				
			}
			
			
			
			
		}
		override public function injured():void
		{
 
			if(_vo.hp <=0)
			{
				_act = null;
				_actNext = die
				
			}else{
				super.injured();
				_act = null;
				
				if(this._isCD)_actNext = wait
				else _actNext = move
			}
			
		}
		
		override public function die():void
		{
			super.die();
			_act = null;
			_actNext = dieEffect
			
			
		}
		
		
 
		override public function clear():void
		{
			super.clear();
			_target = null;
		}
		
	}
}
