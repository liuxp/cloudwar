package control.fsm.character
{
	import control.ai.CharacterAI;
	import control.fsm.State;
	import control.view.CharacterMeditor;
	
	import manager.MeditorManager;
	
	import view.character.CharacterBase;
	
	public class FindEnemy extends State
	{
		
		private var _self : CharacterAI;
		
		
		public function FindEnemy(s:CharacterAI)
		{
  			super();
			this._fsm = s.fsm;
			this._agent = s.agent;
			_self = s;
			
			if(!_agent.search) _agent.search = this;
		}

		override public function Update():void
		{
			if(!_agent || !_fsm) return;
			
			var target:CharacterBase = _self.search();
			 if(target)
			 {
				 var enemy:CharacterMeditor = MeditorManager.getMeditor(target.uid) as CharacterMeditor;
				 if(Math.abs(target.x - _self.character.x)<10)
				 {
					 if(!_agent.attack) _agent.attack = new Attack(_self, enemy.ai);
					 _fsm.SetNextState(_agent.attack);
					 
					 return;
				 }
				
			 }
			 
			 if(!_agent.patrol) _agent.patrol = new Patrol(_self);
			 _fsm.ChangeState(_agent.patrol);
			 
			 
			 
		}
		
		override public function Exit():void
		{
			
			//clear();
		}
		
		override public function clear():void
		{
			super.clear();
			_self = null;
			
		}
	}
}