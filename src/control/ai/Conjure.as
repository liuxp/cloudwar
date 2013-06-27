 package control.ai
{
	import component.Dict;
	import component.DieAway;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	/**
	 *身怀大招
	 * @author Administrator
	 * 
	 */	
	public class Conjure extends Forward
	{
		
		private var _cd_cast:int;
		
		public function Conjure(meditor:CharacterMeditor)
		{
			super(meditor);
		}
		
		
		override protected function checkTarget():void
		{
			if(_target)
			{
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(_target.uid) 
					as CharacterMeditor;
				if(!meditor_target.model)
				{
					_target = null;
				}else{
					var vo:CharacterVO = meditor_target.model.getVO() as CharacterVO;
					if(!GameUtil.isArmyAlive(vo.camp, _target.uid))
					{
						_target = null;
					}
				}
				
			}
			
			
		}
		
		override public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			if(isLock)
			{
				_target = target;
				return;
			}
			
			if(target != _target)
			{
				if(!_target) _target = target;
				else{
					var type:String = _target.armyType;
					if(type == ArmyConfig.Type_Wall)_target = target;
				}
				
			}
			
		}
 
		
	}
}