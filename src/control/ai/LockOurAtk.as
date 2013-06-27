
package control.ai
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	import component.Dict;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 * LockOurAtk.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-11 上午7:04:58
	 * @history 05/00/12,
	 */ 
	public class LockOurAtk extends CharacterAI
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function LockOurAtk(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_vo.cd_atk = 20;
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function move():void
		{
			//			this.checkTarget();
			_target = this.search();			
			
			
			if(_target)
			{
				_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
				_model.setVO(_vo);
				
				
				if(this._isCD) _act = wait
				else _act = this.attack;
				
				
			}else{
				//向主角靠近
				var dis:int = GlobalUtil.getDistance(character.x, character.y, 
					_ML.master.x, _ML.master.y)
				if(dis < 100)
				{
					_act = wait;
					
				}else{
					var coord:Vector2D = new Vector2D(_ML.master.x+20 , _ML.master.y);
					super.move();
					rush(coord);
				}
				
			}
			
		}
		
		
		
		override public function search():CharacterBase
		{
			
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			var targets:Dictionary = lis.dict;
			var min_dis:int;
			var _target:CharacterBase;
			var _charVO:CharacterVO;
			
			
			for(var i:String in targets)
			{
				
				var target:CharacterBase = targets[i];
				
				
				
				var p:Point = new Point(target.x - this.character.x, target.y - character.y);
				
				var dis:Number = p.length;
				var arr:Array = [];
				if(dis <= _vo.range_guard)
				{
					if(target == _ML.master_atkTarget)
					{
						return target;
					}
					var vo:CharacterVO = GameUtil.getCharVOByViewId(target.uid);
					if(vo.hp < vo.hp_max)
					{
						if(!_charVO)
						{
							_charVO = vo;
							_target = target;
						}else{
							if(vo.hp < _charVO.hp)
							{
								_charVO = vo;
								_target = target;
							}
						}
					}
				}
				
			}
			
			return _target;
			
			
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
			playSound(this._vo.res, ArmyConfig.State_Atk);

			_meditor.updateSheet(ArmyConfig.State_Skill);
			
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
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		private function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
		}
		
		override public function die():void
		{
			super.die();
			_act = null;
			_actNext = dieEffect
			
			
		}
		
		
	}
	
}