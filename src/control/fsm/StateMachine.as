package control.fsm
{
	public class StateMachine
	{
	    private var currentState:IState;
	    private var previousState:IState;
	    private var nextState:IState;
	    
	    public function StateMachine()
	    {
	        
	    }
	    
	    // prepare a state for use after the current state
	    public function SetNextState( s:IState ):void
	    {
	        nextState = s;
	    }
	    
	    // Update the FSM. Parameter is the frametime for this frame.
	    public function Update():void
	    {
	        if( currentState )
	        {
	            currentState.Update();
	        }
	    }
	    
	    // Change to another state
	    public function ChangeState( s:IState ):void
	    {
	       if( currentState)
	       {
	       		currentState.Exit();
	        	previousState = currentState;
	       }
	        currentState = s;
	        currentState.Enter();
	    }
	    
	    // Change back to the previous state
	    public function GoToPreviousState():void
	    {
	        ChangeState( previousState );
	    }
	    
	    // Go to the next state
	    public function GoToNextState():void
	    {
	       if(this.nextState) ChangeState( nextState );
	    }
		
		public function clear():void
		{
			currentState = null;
			previousState = null;
			nextState = null;
		}
	}
	
}