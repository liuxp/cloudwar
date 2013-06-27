package model.vo
{
	import control.ai.CharacterAI;
	
	import view.character.CharacterBase;

	public class BulletVO
	{
		public var range:int=50;
		public var g:Number = 0.9;
		public var speed:int;
		public var tx:int;
		public var ty:int;
		
		public var cd:int=40; //
		public var atk:CharacterBase;
		public var injured:CharacterBase;
		public var Res:String;
		public var type:String;
		
		public function BulletVO()
		{
			
		}
		
	}
}