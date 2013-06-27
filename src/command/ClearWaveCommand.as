package command
{
	import events.MeditorEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.CutDownManager;
	
	import model.config.ArmyConfig;
	import model.vo.MessionVO;
	
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	/**
	 *清除关卡 
	 * @author Administrator
	 * 
	 */
	public class ClearWaveCommand extends CommandBase
	{
		private var container_character :Sprite;
		private var container_wall :Sprite;
		
		
		public function ClearWaveCommand()
		{
			super();
			
			container_character = _ML.game.scene_PK.container_character;
			container_wall = _ML.game.scene_PK.container_corpse;
			
		}
		
		override public function execute(params:Object=null):void
		{
			CutDownManager.stopTime(CutDownManager.CD_PK);
			
			container_character.removeChildren();
			container_wall.removeChildren();
			
			_ML.enemies.DeleteAllItms();
			_ML.myArmies.DeleteAllItms();
			//_ML.pkHeros.setVO(null);
			_ML.pkNpcs.setVO(null);
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Wave_Clean))
		}
		
		override public function clear():void
		{
			super.clear();
			
			container_character = null;
			container_wall = null;
			
		}
		
		
	}
}