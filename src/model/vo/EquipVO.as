
package model.vo
{
	
	/**
	 *
	 * EquipVO.as class. 
	 * @author Administrator
	 * Created 2013-5-25 下午5:10:03
	 */ 
	public class EquipVO extends VOBase
	{ 
		public var Res:String;
		public var Detail:String;
		public var Type:String;
		public var Quality:String;
		public var Name:String;
		public var armyLv:int;
		public var lv:int;
		public var atk:int;
		public var def:int;
		public var hp:int;
		public var speed:Number;
		
		public var energy:int;
		public var food:Number;
		
		public var speed_hp:Number;
		public var upgrade_attr:String;
		public var upgrade_step:int;
		
		public var isWear:Boolean;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function EquipVO()
		{
			super();
		} 
		
		
		
	}
	
}