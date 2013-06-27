package model.vo
{
	public class EquipListVO
	{
		public var Weapon : Array;
		public var Armor : Array;
		public var Horse : Array;
		public var Treasure : Array;
		public var Extra : Array;
		 
		public function EquipListVO()
		{
			this.Weapon = new Array;
			this.Armor = new Array;
			this.Horse = new Array;
			this.Treasure = new Array;
			this.Extra = new Array;
		}
		
	}
}