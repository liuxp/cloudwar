package command
{
	import component.Dict;
	import component.DieAway;
	
	import control.view.CharacterMeditor;
	
	import flash.display.Sprite;
	
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;

	/**
	 *复活 
	 * @author Administrator
	 * 
	 */
	public class RebornArmyCommand extends CommandBase
	{
		private var container_character :Sprite;
		private var _viewId:String;
		private var _camp:int;
		private var _character:CharacterBase;
		
		public function RebornArmyCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			if(!params) return;
			_character = params.hero;
			_viewId = _character.uid;
			_camp = params.camp;
			/*container_character = _ML.game.scene_PK.container_character;
			_character= container_character.getChildByName(_viewId) as CharacterBase;*/
			if(!_character) return;
			GameUtil.AddArmy(_camp, _character);
			var meditor:CharacterMeditor = MeditorManager.getMeditor(_viewId)as CharacterMeditor;
			var mod:CharacterModel = meditor.model as CharacterModel;
			var vo:CharacterVO = mod.getVO() as CharacterVO;
			vo.hp = vo.hp_max;
			mod.setVO(vo);
			meditor.ai.start();
			meditor.ai.wait();
			
			var eff:DieAway = new DieAway(show);
			eff.target = _character;
			eff.render();
			eff.clear();
			eff = null;
		}
		
		private function show():void
		{
			_character.visible = true;
		}
		
		override public function clear():void
		{
			this.container_character = null;
			this._character = null;
			
			this.clear();
		}
	}
}