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
	import model.vo.CharacterVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;
	
	/**
	 *恢复治疗
	 * @author Administrator
	 * 
	 */	
	public class Renew extends CharacterAI
	{
		private var _cd_reborn:int=1;
		
		public function Renew(meditor:CharacterMeditor)
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
		
		private function rush(coord:Vector2D):void
		{
			_steeredVector.arrive(coord);
			_steeredVector.update();
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;
		}
		
		override public function search():CharacterBase
		{
			var lis:Dict = GameUtil.getArmys(_vo.camp);
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
			
			if(!_skillVO)
			{
				_skillVO = _vo.skill_active[0];
				_vo.range_atk = _skillVO.range;
			}
		}
		
		override public function attack():void
		{
			
			playSound(this._vo.res, ArmyConfig.State_Atk);
			_meditor.updateSheet(ArmyConfig.State_Skill);
			
			_act = null;
			_actNext = wait;
			
			if(_target && _skillVO)
			{
				
				CommandManager.createSkill({ai:this, skill:_skillVO, 
					target:this._target}, 
					StaticConfig.SkillType_Active);
				_skillVO = null;
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
		
		
		
	}
}
