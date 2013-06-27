package control.ai
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;

	/**
	 *植物人 
	 * @author Administrator
	 * 
	 */	
	public class Static extends Forward
	{
		private var _injuredNum:int;
		
		public function Static(meditor:CharacterMeditor)
		{
			super(meditor);
		}
		
		override public function move():void
		{

			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			_target = this.search(); 
			
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
				var p:Point = new Point(_target.x-character.x, _target.y-character.y);
					
				range_atk = _vo.range_atk;
				dis = p.length;
				if(dis <= range_atk && dis >=0)
				{
					if(this._isCD) _act = wait;
					else _act = attack;
				} 
				
			}else{
				
				 
				this.wait();
				
				
			}
			
			
		}
		
		override public function search():CharacterBase
		{
			if(_vo.armyType != ArmyConfig.Type_Dancer)
			{
				return AISearch.searchNearbyArmy(this._vo, this.character);
			}else{
				return AISearch.searchTreateArmy(this._vo, this.character);
			}
		}
		
	}
}