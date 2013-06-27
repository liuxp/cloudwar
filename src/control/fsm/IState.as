package control.fsm
{
	public interface IState
	{
		 function Enter():void; // called on entering the state
	     function Exit():void; // called on leaving the state
	     function Update():void;
	                   // called every frame while in the state
	}
}