package command
{
	import control.sound.SoundManager;
	import control.view.sheet.SheetSpriteMeditor;
	import control.view.SkillMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	
	import view.character.SheetSprite;

	/**
	 *生成英雄技能 
	 * @author Administrator
	 * 
	 */
	public class CreateHeroSkillCommand extends CommandBase
	{
		private var _container:Sprite;
		private var _hero:GeneralVO;
		
		public function CreateHeroSkillCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			_hero = params.hero;
			//if(!_hero.skill.length) return;
			
			var pos:Array = params.pos;
//			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Render_Stop));
 
			_container = _ML.game.scene_PK.container_skill;

			
			var skillCfg:Object// = GameUtil.getCfgByItmID(StaticConfig.Cfg_Skill, _hero.skill[0]);
			var type:String = skillCfg.effect[0]
			var skill:SheetSprite = new SheetSprite(type);
			var ctr:SheetSpriteMeditor = new SkillMeditor(skill, _hero, skillCfg);
			
			_container.addChild(skill);
			skill.x = pos[0];
			skill.y = pos[1];
			 
			this.clear();
			
			SoundManager.playSound(type);
		}
		
		override public function clear():void
		{
			this._container = null;
			_hero = null;
			super.clear();
		}
	}
}