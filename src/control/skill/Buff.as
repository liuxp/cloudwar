
package control.skill
{
	import control.ai.CharacterAI;
	
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	
	/**
	 *
	 * Buff.as class. 
	 * @author Administrator
	 * Created 2013-5-8 上午10:17:28
	 */ 
	public class Buff extends SkillBase
	{ 
		private var _duration:int;
		private var _atkAI:CharacterAI;
		private var _atkVO:CharacterVO;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function Buff(data:Object)
		{
			super(data);
			
			_atkAI = data.ai_atk;
			_atkVO = _atkAI._vo;
			
		} 
		
		override public function realize():void
		{
			if(!_atkAI.isAlive) return;
			
			_duration = _skill.duration*1000;
			
			_atkAI.stop();
			
			if(_skill.buff_def) _atkVO.def += _skill.buff_def;
			if(_skill.buff_atk) _atkVO.atk += _skill.buff_atk;
			if(_skill.buff_speed) _atkVO.speed += _skill.buff_speed;
			
			_atkAI._model.setVO(_atkVO);
			
			_atkAI.start();
			
			if(_skill.eff_down_enimy)
			{
				createEft(_skill.eff_down_enimy, 60, 
					_atkVO.scaleX, _atkAI.character.container_bottom, _skill.duration);
			}
			
			if(_skill.eff_up_self)
			{
				createEft(_skill.eff_up_self, 60, 
					_atkVO.scaleX, _atkAI.character.container_top);
			}
			
			GameUtil.delayExecuteFun(_duration, resume, 1, this.mid);
			
		}
		
		private function resume():void
		{
			if(!_atkAI || !_atkAI.isAlive || !_atkAI._model) return;
			
			_atkAI.stop();
			
			if(_skill.buff_def) _atkVO.def -= _skill.buff_def;
			if(_skill.buff_atk) _atkVO.atk -= _skill.buff_atk;
			if(_skill.buff_speed) _atkVO.speed -= _skill.buff_speed;
			
			_atkAI._model.setVO(_atkVO);
			
			_atkAI.start();
		}
		
	}
	
}