package control.fsm.character
{
	
	
	import control.ai.CharacterAI;
	import control.fsm.State;
	import control.view.CharacterMeditor;
	
	
	
	// wait for a given period of time then go to next state
	public class Wait extends State
	{
	   
	    private var _waitTime:int;
		private var self:CharacterAI;
		private var _cd:int;
		
	    public function Wait( s:CharacterAI, t:Number )
	    {
			super();
			this._fsm = s.fsm;
			this._agent = s.agent;
	        self = s;
			_waitTime = t;
			_cd = _waitTime;
			if(!_agent.wait) _agent.wait = this;
	    }
	    
	    
		public function set waitTime(value:int):void
		{
			_waitTime = value;
			_cd = _waitTime;
		}

	    override public function Update( ):void
	    {
			_cd --;
			if(_cd <=0)
			{
				if(!_agent.search) _agent.search = new FindEnemy(self);
				_fsm.SetNextState(_agent.search);
			}
			
	    }
		
		override public function Exit():void
		{
			_cd = this._waitTime;
			
			
		}
		
		override public function clear():void
		{
			super.clear();
			self = null;
		}
	}
}