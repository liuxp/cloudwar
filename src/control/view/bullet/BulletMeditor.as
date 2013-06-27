package control.view.bullet
{
	import component.Dict;
	
	import control.skill.ISkill;
	import control.view.CharacterMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	
	import core.view.ViewBase;
	
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
 
	public class BulletMeditor extends SheetSpriteMeditor
	{
		protected var _bulletVO:BulletVO;
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		protected var _otherSkills:Array;
		protected var _effect:String;
		
		public function BulletMeditor(view:ViewBase,  vo:BulletVO, params:Object=null)
		{
			_bulletVO = vo;
			_otherSkills = params.otherSkills;
			_effect = params.effect;
			
			super(view);
			
			
		}
		
		
		/**
		 *中弹效果 
		 * 
		 */		
		protected function skillEff():void
		{

			var posX : int = _view.x;
			
			var posY : int = _view.y;
			
			CommandManager.createEffect({type:_effect,
				pos:[posX,posY]});

		}
		/**
		 *寻找受伤目标 
		 * 
		 */		
		protected function searchTargets():void
		{
			var meditor_atker:CharacterMeditor =  MeditorManager.getMeditor(_bulletVO.atk.uid) 
				as CharacterMeditor;
			var mod:CharacterModel = meditor_atker.model as CharacterModel;
			if(!mod) return;
			var vo_atker:CharacterVO = mod.getVO() as CharacterVO;
			//var gerVO:GeneralVO = GameUtil.getPKArmyData(_bulletVO.atk.camp,_bulletVO.atk.name);
			var targets:Dict = GameUtil.getSearchTargets(vo_atker.camp);
			var dict:Dictionary = targets.dict;
 
			for each(var i:CharacterBase in dict)
			{
				var type : String = i.armyType;
				var pos:Array = [i.x, i.y];
				var len:int = GlobalUtil.getDistance( pos[0],pos[1], 
													  this._bulletVO.tx, this._bulletVO.ty);
				if(len > _bulletVO.range) continue;
				
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					
					
					if(charVO && charVO.hp>0)
					{
						/*var num:Number = GameUtil.getRestrictionByProfession(vo_atker.profession,
																			 charVO.profession);*/
						charVO.hp -= vo_atker.atk ;
						meditor_target.ai.injured();
						model_target.setVO(charVO);
						
						meditor_target.ai.setTarget(_bulletVO.atk);
						
						GameUtil.playPKSnd(_effect);
						
						skillEff();
 
					}
					
					
				}
				
			}
			
			
		}
		
		/*public function overlaySkill(atkGerVO:GeneralVO, target:CharacterBase):void
		{
			
			for(var key:String in this._otherSkills)
			{
				
				var skillObj:Object = _otherSkills[key];
				var skillParams:Array;
				
				for(var i:String in skillObj)
				{
					var skillClass :Class = GameUtil.getSkillClassByType(i);
					skillParams = skillObj[i];
					
					var skill:ISkill = new skillClass(
						{
							hero: atkGerVO,
							params: skillParams,
							target: target,
							effect: this._effect
						}); 
					skill.realize();
				}
			}
		}
		*/
		override public function Play():void
		{
			super.Play();
			
			if(_render.coords)
			{
				_view.bitmap.x = _render.coords[0]
				_view.bitmap.y = _render.coords[1]
			} 
		}
		
		override public function clear():void
		{
			_bulletVO = null;
			super.clear();
		}
	}
}