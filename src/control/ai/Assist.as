package control.ai
{
	import component.Dict;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import model.config.ArmyConfig;
	import model.config.GameCfg;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;

	/**
	 *辅助 
	 * @author Administrator
	 * 
	 */	
	public class Assist extends Forward
	{
		private var _cd_die:int;
		
		public function Assist(meditor:CharacterMeditor)
		{
			super(meditor);
		}
		
		/*override public function move():void
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
					else _act = attack;
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
				
				
				if(this.character.x < GameCfg.stageWidth)
				{
					super.move();
					_pos = new Vector2D(character.x +_vo.speed, character.y)
					_steeredVector.arrive(_pos);
					_steeredVector.update();
					character.x = _steeredVector.x;
					character.y = _steeredVector.y;
				}else{
					_act = wait;
				}
				
				
			}
			
			
		}*/
		
		override public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			
		}
		override public function action():void
		{
			super.action();
			
			/*_cd_die += this._vo.delay;
			if(_cd_die >= 10000)
			{
				this.dieEffect();
			}*/
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
				if( dis > 400 ) continue;
				disLis.push({itm:i, num:dis});
				
			}
			disLis.sortOn('num', Array.NUMERIC);
			var target:CharacterBase = disLis.length? disLis[0].itm : null;
			return target;
		}
		
		 
	}
	
	
}