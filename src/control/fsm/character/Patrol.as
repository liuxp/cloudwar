package control.fsm.character
{
	import control.ai.CharacterAI;
	import control.fsm.State;
	import control.view.CharacterMeditor;
	
	
	// patrolling the area
	public class Patrol extends State
	{
	    
	    private var _self:CharacterAI
	    
	    public function Patrol( s:CharacterAI)
	    {
			super();
			this._fsm = s.fsm;
			this._agent = s.agent;
			_self = s;
	       
			if(!_agent.patrol) _agent.patrol = this;
	    }
	    
	    override public function Enter():void
	    {
	        // check the gun is loaded
	       // guard.Reload();
	        
	    }
 
		override public function Update():void
	    {
			_self.move();
			if(_agent && !_agent.search) _agent.search = new FindEnemy(_self);
			if(_fsm) _fsm.SetNextState(_agent.search);
			
			
			
	    }
		
		override public function Exit():void
		{
			 
			//clear();
		}
		
		override public function clear():void
		{
			this._self = null;
			super.clear();
		}
	}
}