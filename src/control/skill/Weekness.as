package control.skill
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import flash.utils.Dictionary;
	
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;

	public class Weekness extends SkillOverlay
	{
		private var _range:int = 200;
		private var _atkAdd:Number;
		private var _cd:int;
		private var _initAtkDict:Dict;
		
		public function Weekness(data:Object)
		{
			super(data);
			_range = data[0];
			_atkAdd = data[1];
			_cd = data[2];
		}
		
		override public function realize():void
		{
		
			_initAtkDict = new Dict();
 
			var viewId:String = _target.uid;
			var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
				as CharacterMeditor;
			
			if(meditor_target && meditor_target.ai)
			{
				var model_target:CharacterModel = meditor_target.model as CharacterModel;
				var charVO:CharacterVO = model_target.getVO() as CharacterVO;
				var camp:int = charVO.camp;
				
				if(GameUtil.isArmyAlive(camp, viewId))
				{
					this._initAtkDict.AddItem(viewId, charVO.atk);
					charVO.atk *= _atkAdd;
					model_target.setVO(charVO);
					 
					GameUtil.delayExecuteFun(this._cd, resume, 1, 'resume_'+ viewId, 
											 'resume', null, null, [viewId]);
				}
				
				
				
			}
 
			
		}
		
		private function resume(viewId:String):void
		{
			var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
													as CharacterMeditor;
			if(meditor_target)
			{
				var model_target:CharacterModel = meditor_target.model as CharacterModel;
				if(model_target)
				{
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					charVO.atk = this._initAtkDict.getItem(viewId);
					model_target.setVO(charVO);
				}
				
			}
			
			this._initAtkDict.DeleteItem(viewId);
			if(this._initAtkDict.isEmpty()) this.clear();
		}
		
		override public function clear():void
		{
			super.clear();
			_initAtkDict.DeleteAllItms();
			_initAtkDict = null;
		}
	}
	
	
}