package control.fsm.character
{
	import control.ai.CharacterAI;
	import control.fsm.State;
	import control.view.CharacterMeditor;
	
	import view.character.CharacterBase;
	
	
	 // attacking an enemy
	public class Attack extends State
	{
	    private var self:CharacterAI;
	    private var enemy:CharacterAI;
	    private var _cd:int ;
		
	    public function Attack( s:CharacterAI, e:CharacterAI )
	    {
	        self = s;
	        enemy = e;
			super();
			this._fsm = s.fsm;
			this._agent = s.agent;
			
			if(!_agent.attack) _agent.attack = this;
			
			
	    }
	    
	    
	    
	    override public function Update():void
	    {
	    	
			if(self)self.attack();
			//if(enemy)enemy.injured();
			
			
		   if(!_agent.wait) _agent.wait = new Wait(self,10);
		   else _agent.wait.waitTime = 10;
		   _fsm.SetNextState(_agent.wait);
	    }
		
		override public function Exit():void
		{
			
			//clear();
		}
		
		override public function clear():void
		{
			this.self = null;
			this.enemy = null;
			super.clear();
		}
	}

	
}