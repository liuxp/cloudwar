package command
{
	import control.view.EffectMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	import control.view.SkillMeditor;
	
	import flash.display.Sprite;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	/**
	 *生成特效 
	 * @author Administrator
	 * 
	 */	
	public class CreateEffectCommand extends CommandBase
	{
		
		public function CreateEffectCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			var container:Sprite;
			
			if(params.container)
			{
				var char:CharacterBase = params.container ;
				container = char.container_top;
			}else{
				container = _ML.game.scene_PK.container_skill;
			}
		 
			var type:String = params.type;  
			var pos:Array = params.pos;
			
			var eff:SheetSprite = new SheetSprite(type);
			var ctr:SheetSpriteMeditor = new EffectMeditor(eff, params.cd, params.resume);
			container.addChild(eff);
			if(pos)
			{
				eff.x = pos[0];
				eff.y = pos[1];
			}else{
				eff.y = 30;
			}
			
		}
	}
}