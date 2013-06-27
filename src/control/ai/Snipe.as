package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	/**
	 *跟丫死磕 
	 * @author Administrator
	 * 
	 */	
	public class Snipe extends CharacterAI
	{
		private var _injuredNum:int;
		
		public function Snipe(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_vo.cd_atk = 20;
		}
		
		override public function move():void
		{
//			this.checkTarget();
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			
			_target = this.search();
			if(_target)
			{
				var dis:int = Math.abs(_target.x - character.x)
				if(dis <= _vo.range_guard)
				{
					_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
					_model.setVO(_vo);
					if(this._isCD) _act = wait;
					else _act = attack
					return;
				} 
			}
			
			_target = this.search();
			
			super.move();
			//this.character.x += _vo.speed;
			var _pos:Vector2D =new Vector2D(_target.x , character.y);
			
			_steeredVector.arrive(_pos);
			_steeredVector.update();
			character.x = _steeredVector.x;
			character.y = _steeredVector.y;	
			
			if(_act==null) _act = move
		}
		
		override public function search():CharacterBase
		{
			var wall:CharacterBase = _ML.master;
			return wall;
			
		
		}
		
		override public function wait():void
		{
			super.wait();
			
			if(_cd_wait ++ % _vo.cd_atk == 0)
			{
				if(_target)
				{
					var isDefault:Boolean = GameUtil.isDefaultDir(_vo.camp);
					_vo.dir = GameUtil.getCharacterDefaultDir(_vo.camp, isDefault);
					_model.setVO(_vo);
				}
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
				CommandManager.createBullet({atker:character, target:_target});
 
			}
			
			
			_target = this.search();
		}
		
		override public function injured():void
		{
			
			//character.x -=40;
			
			
			if(_vo.hp <=0)
			{
				_act = null;
				_actNext = die
				
			}else{
				super.injured();
				_act = null;
				if(this._isCD) _actNext = wait;
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