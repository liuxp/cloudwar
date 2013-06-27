package control.ai
{
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	
	import model.config.ArmyConfig;
	
	import utils.GameUtil;
	
	public class Peace extends Forward
	{
		public function Peace(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_vo.cd_atk = 20;
		}
		
		override public function move():void
		{
			
			this.checkTarget();
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			if(!_target) _target = this.search(); 
			
			if(_target)
			{
				_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
				_model.setVO(_vo);
				
				
				var dis:Number;
				var targetType:String = _target.armyType;
				var range_atk:int;
				var p:Point;
				
				p  = new Point(_target.x-character.x, _target.y-character.y);
				
				range_atk = _vo.range_atk;
				
				dis = p.length;
				if(dis <= range_atk && dis >=0)
				{
					if(this._isCD) _act = wait;
//					else _act = attack;
				}else{
					
					super.move();
					var _pos:Vector2D = targetType == ArmyConfig.Type_Wall
						? new Vector2D(_target.x , character.y)
						: new Vector2D(_target.x , _target.y);
					
					_steeredVector.arrive(_pos);
					_steeredVector.update();
					character.x = _steeredVector.x;
					character.y = _steeredVector.y;
					
					
				}
				
			}else{
				
				_act = wait
				
			}
			
			
		}
		
		
	}
}