package control.skill
{
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;

	public class SkillOverlay extends SkillBase
	{
		protected var _target:CharacterBase;
		protected var _atker:CharacterBase;
		protected var _atkVO:CharacterVO;
		
		public function SkillOverlay(data:Object)
		{
			super(data);
			_target = data.target;
			_atker = GameUtil.getCharacterById(_hero.gid);
			_atkVO = GameUtil.getCharVOByViewId(_atker.uid);
		}
		
		override public function clear():void
		{
			super.clear();
			_target = null;
			_atker = null;
			_atkVO = null;
		}
		
		
	}

}