
package control.skill
{
	import component.Dict;
	
	import control.ai.CharacterAI;
	import control.view.CharacterMeditor;
	
	import flash.utils.Dictionary;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *混乱
	 * Confuse.as class. 
	 * @author Administrator
	 * Created 2013-5-1 下午10:50:11
	 */ 
	public class Silence extends SkillBase
	{ 
		private var _duration:int;
		private var _atkAI:CharacterAI;
		private var _atkVO:CharacterVO;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function Silence(data:Object)
		{
			super(data);
			
			_atkAI = data.ai_atk;
			_atkVO = _atkAI._vo;
			
		} 
		
		override public function realize():void
		{
			
			var targets:Dict = GameUtil.getSearchTargets(_atkAI._vo.camp);
			var dict:Dictionary = targets.dict;
			var objNum:int = _skill.objNum;
			var targetAI:CharacterAI;
			
			for each(var i:CharacterBase in dict)
			{
				if(objNum <1) return;
				var len:int = GlobalUtil.getDistance( _atkAI.character.x, _atkAI.character.y,
					i.x, i.y);
				
				if(len > _atkAI._vo.range_atk) continue;
				
				var meditor_target:CharacterMeditor  = GameUtil.getCharMeditorByViewId(i.uid);
				
				
				if(meditor_target)
				{
					targetAI = meditor_target.ai;
					if(!targetAI.isAlive) return;
					--objNum;
					
					_duration = _skill.duration*1000;
					
					targetAI.wait();
					targetAI._vo.cd_skill = int.MAX_VALUE;
					targetAI.attack();
					
					GameUtil.deleteDelayFun(this.mid+i.uid);
					
					GameUtil.delayExecuteFun(_duration, resume, 1, this.mid+i.uid, 
						'resume', null,null, [targetAI]);
					
					GlobalUtil.removeAllChild(targetAI.character.container_top);
					createEft(_skill.eff_up_enimy, 60, 
						_atkVO.scaleX, targetAI.character.container_top, _skill.duration);
				}
			}
			
			
			
			
			
		}
		
		private function resume(_ai:CharacterAI):void
		{
			if(!_ai || !_ai.isAlive || !_ai._vo) return;
			
			_ai._vo.cd_skill = 0;
			
		}
		
	}
	
}