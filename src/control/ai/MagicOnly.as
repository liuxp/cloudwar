
package control.ai
{
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	
	/**
	 *只使用魔法
	 * MagicOnly.as class. 
	 * @author Administrator
	 * Created 2013-4-26 下午4:49:52
	 */ 
	public class MagicOnly extends Forward
	{ 
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MagicOnly(meditor:CharacterMeditor)
		{
			super(meditor);
		} 
		
		
		/*override public function attack():void
		{
			playSound(this._vo.res, ArmyConfig.State_Atk);
			_meditor.updateSheet(ArmyConfig.State_Skill);
			this._isCD = true;
		
			_act = null;
			_actNext = wait;
			
			
			if(_target && _skillVO)
			{
				
				CommandManager.createSkill({ai:this, skill:_skillVO, 
											target:this._target}, 
											StaticConfig.SkillType_Active);
				_skillVO = null;
			}

		}
		
		override public function wait():void
		{
			super.wait();
			if(!_skillVO)
			{
				_skillVO = _vo.skill_active[0];
				_vo.range_atk = _skillVO.range;
				_vo.init_range_atk = _skillVO.range;
			}
		}*/
		
	}
	
}