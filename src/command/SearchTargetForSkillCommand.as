package command
{
	import component.Dict;
	
	import control.ai.Static;
	import control.skill.*;
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	public class SearchTargetForSkillCommand extends CommandBase
	{
 
		
		public function SearchTargetForSkillCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			var _skill:SkillVO = params.skill;
 			var _params:Object = params;
			var skillClass:Class;
			if(_skill.skillType ==null)
			{
				trace('技能出现异常：', _skill.skillName);
				return;
			}
			Beat,Buff,Hurl,Confusion,Summon,Health,Dunt,Silence,StoryConfusion
			skillClass = flash.utils.getDefinitionByName("control.skill." + _skill.skillType) as Class;
		
			
			if(!skillClass) return;
			
			var skill:ISkill = new skillClass(params); 
			skill.realize();
			
 
		}
		
 
	}

}