package command
{
	import events.MeditorEvent;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.ObjToModelUtil;

	public class StartPKCommand extends CommandBase
	{
		public function StartPKCommand()
		{
			super();
		}
		override public function execute(params:Object=null):void
		{
						
			
			_ML.game.panelStageToGame();
			
			//初始战斗数据
			var monarch_vo:GeneralVO = _ML.monarch_general.getVO() as GeneralVO;
			monarch_vo.food = 0;
			monarch_vo.energy = 0;
			
			var pkHeros:Array = _ML.pkHeros.getVO() as Array;
			_ML.pkHeros.setVO(pkHeros);
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.PK_Start));
				
			CommandManager.createMession();
			
			
		}
	}
}