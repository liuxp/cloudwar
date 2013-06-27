package model.vo
{
	public class GeneralVO extends VOBase
	{
		public var lv:int;
		public var cost:int; 
		public var limit:int = 5;
		public var name:String;
		public var cd_create :int;
		
		
		public var cd_food:int;
		public var cd_energy:int;
		
		public var food:Number;
		public var energy:Number = 0;
		public var energy_max:int=100;
		public var food_max:int = 100;

		public var skillId_active: Array;
		public var exp:int;
		public var exp_max:int;
		
		public function GeneralVO()
		{
			
		}
	}
}