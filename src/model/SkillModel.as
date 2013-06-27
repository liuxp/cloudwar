
package model
{
	import core.ModelBase;
	import core.observer.ObserverManager;
	
	import model.vo.SkillVO;
	
	
	/**
	 *
	 * SkillModel.as class. 
	 * @author Administrator
	 * Created 2013-4-19 上午11:02:40
	 */ 
	public class SkillModel extends ModelBase
	{ 
		private var _vo:SkillVO
		
		public function SkillModel(vo:Object=null)
		{
			_vo = vo as SkillVO;
		} 
		
		override public function setVO(data:Object):void
		{
			_vo = data as SkillVO;
			
			Change();
		}
		
		override public function getVO():Object
		{
			return _vo;
		}
		
		override protected function Change():void
		{
			ObserverManager.notifyObserver(this._uid, _vo);
		}
		
		
	}
	
}