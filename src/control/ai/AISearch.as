
package control.ai
{
	import component.Dict;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *
	 * AISearch.as class. 
	 * @author Administrator
	 * Created 2013-5-12 下午4:23:22
	 */ 
	public class AISearch
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function AISearch()
		{
		} 
		/**
		 *找到治疗目标 
		 * @param _vo
		 * @param character
		 * @return 
		 * 
		 */		
		public static function searchTreateArmy(_vo:CharacterVO, character:CharacterBase):CharacterBase
		{
			var lis:Dict = GameUtil.getArmys(_vo.camp);
			var targets:Dictionary = lis.dict;
			var min_dis:int;
			var _target:CharacterBase;
			var _charVO:CharacterVO;
			
			
			for(var i:String in targets)
			{
				var target:CharacterBase = targets[i];
				
				var p:Point = new Point(target.x -  character.x, target.y - character.y);
				
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
		
		public static function searchNearbyArmy(_vo:CharacterVO, character:CharacterBase):CharacterBase
		{
			var lis:Dict =  GameUtil.getSearchTargets(_vo.camp);
			
			var dict:Dictionary = lis.dict;
			var disLis:Array = [];
			for each(var i:CharacterBase in dict)
			{
				var point:Point = new Point(i.x-character.x,i.y-character.y);
				var dis:Number = point.length;
				if( dis <= _vo.range_guard )
				{
					disLis.push({itm:i, num:dis});
				}
				
			}
			disLis.sortOn('num', Array.NUMERIC);
			var target:CharacterBase = disLis.length? disLis[0].itm : null;
			return target;
		}
		
	}
	
}