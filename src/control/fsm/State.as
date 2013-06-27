package control.fsm
{
	import control.fsm.character.CharacterAgent;
	
	
	
	public class State implements IState
	{
		protected var _fsm : StateMachine;
		protected var _agent:CharacterAgent;
		
		
		public function State()
		{
			
			 
		}

		public function Enter():void
		{
		}
		
		public function Exit():void
		{
		}
		
		public function Update():void
		{
		}
		
		public function clear():void
		{
			
			_fsm = null;
			_agent = null;
			
		}
	}
}