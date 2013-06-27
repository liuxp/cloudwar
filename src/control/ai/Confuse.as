
package control.ai
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 *混乱，自相残杀
	 * Confuse.as class. 
	 * @author Administrator
	 * Created 2013-4-24 上午9:39:22
	 */ 
	public class Confuse extends Forward
	{ 
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function Confuse(meditor:CharacterMeditor)
		{
			super(meditor);
		} 
		
		override public function search():CharacterBase
		{
			
			var lis:Dict = GameUtil.getArmys(_vo.camp);
			
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
		
	}
	
}