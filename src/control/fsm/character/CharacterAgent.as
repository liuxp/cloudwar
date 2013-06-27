package control.fsm.character
{
	import view.character.CharacterBase;
	
	
	public class CharacterAgent
	{
		public var patrol : Patrol;
		public var wait : Wait;
		public var attack :Attack;
		public var search:FindEnemy;
		
		public function CharacterAgent()
		{
			
		}
		
		public function clear():void
		{
			if(patrol)patrol.clear();
			this.patrol = null;
			if(wait)wait.clear();
			this.wait = null;
			if(attack)attack.clear();
			this.attack = null;
			if(search)search.clear();
			this.search = null;
		}
	}
}