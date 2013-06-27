package command
{
	import control.view.EffectMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	import control.view.SkillMeditor;
	
	import flash.display.Sprite;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	/**
	 *生成buff特效 
	 * @author Administrator
	 * 
	 */	
	public class CreateHeroBuffCommand extends CommandBase
	{
		private var _view:Sprite;
		
		public function CreateHeroBuffCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{

			var type:String = params.type;
			var char:CharacterBase = params.hero;
			switch(true)
			{
				case type.indexOf('A')!=-1 :
					_view = char.container_top;
					break;
				default :
					_view = char.container_bottom;
					break;
			}
			
			var eff:SheetSprite = new SheetSprite(type);
			var ctr:SheetSpriteMeditor = new EffectMeditor(eff);
			_view.addChild(eff);

		}
	}
}