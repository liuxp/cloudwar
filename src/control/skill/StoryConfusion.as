
package control.skill
{
	import control.ai.CharacterAI;
	import control.view.CharacterMeditor;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	/**
	 *
	 * StoryConfusion.as class. 
	 * @author Administrator
	 * Created 2013-6-20 下午4:45:07
	 */ 
	public class StoryConfusion extends SkillBase
	{ 
		private var _duration:int;
		private var meditor_target:CharacterMeditor;
		private var targetAI:CharacterAI;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function StoryConfusion(data:Object)
		{
			super(data);
			
			meditor_target = data.meditor_target;
			targetAI = data.ai_target;
		} 
		
		override public function realize():void
		{
			 
				
				if(meditor_target)
				{
					
					if(!targetAI.isAlive) return;
					 
					_duration = _skill.duration*1000;
					
					targetAI.wait();
					targetAI._vo.delay = _duration;
					targetAI.start();
					
					GameUtil.deleteDelayFun(this.mid + targetAI.mid);
					
					GameUtil.delayExecuteFun(_duration, resume, 1, this.mid + targetAI.mid, 
						'resume', null,null, [targetAI]);
					
					GlobalUtil.removeAllChild(targetAI.character.container_top);
					createEft(_skill.eff_up_enimy, 60, 
						1, targetAI.character.container_top, _skill.duration);
				}
			 
			
			
			
			
			
		}
		
		private function resume(_ai:CharacterAI):void
		{
			if(!_ai || !_ai.isAlive || !_ai._vo) return;
			
			_ai._vo.delay = _ai._vo.init_delay;
			_ai._model.setVO(_ai._vo);
			_ai.move();
			_ai.start();
			
		}
		
		
	}
	
}