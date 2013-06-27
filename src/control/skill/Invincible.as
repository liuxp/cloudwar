package control.skill
{
	import control.view.CharacterMeditor;
	
	import core.UID;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;

	/**
	 *无敌 
	 * @author Administrator
	 * 
	 */
	public class Invincible implements ISkill
	{
		private var _pos:Point;
		private var _hero:GeneralVO;
		private var _charVO:CharacterVO;
		private var _charMod:CharacterModel;
		
		public function Invincible(hero:GeneralVO, pos:Point)
		{
			_hero = hero;
			_pos = pos;
		}
 
		
		public function realize():void
		{
			var character:CharacterBase = GameUtil.getCharacterById(_hero.id);
			var meditor:CharacterMeditor = MeditorManager.getMeditor(character.uid) as CharacterMeditor;
			_charMod = meditor.model as CharacterModel;
			_charVO = _charMod.getVO() as CharacterVO;
			_charVO.invincible = true;
			_charMod.setVO(_charVO);
			GameUtil.delayExecuteFun(5000,resume,1,'invincible' + UID.createUID());
		}
		
		private function resume():void
		{
			_charVO.invincible = false;
			_charMod.setVO(_charVO);
		}
	}
}