package command
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import component.Dict;
	
	import control.ai.CharacterAI;
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	import control.view.EffectMeditor;
	import control.view.SkillMeditor;
	import control.view.sheet.SheetSpriteMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;
	
	/**
	 *生成普攻技能 
	 * @author Administrator
	 * 
	 */
	public class CreateSkillNormalCommand extends CommandBase
	{
		private var _container:Sprite;
		private var _atkAI:CharacterAI;
		private var _skill:SkillVO;
		private var _delay:int = 60;
		
		public function CreateSkillNormalCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
			_atkAI = params.ai;
			_skill = params.skill;
			
			if(!_skill) return;
			var _target:CharacterBase = params.target;
			var _targetAI:CharacterAI;
			var _charVO:CharacterVO;
			
			_atkAI._vo.cd_atk = _skill.cd * 1000 / _atkAI._vo.delay;
			_atkAI._vo.init_cd_atk = _atkAI._vo.cd_atk;
			
			var charState:String = params.charState ? params.charState 
													: _skill.charState;
			
			_atkAI._meditor.updateSheetBySkill(charState);
			
			var meditor_target:CharacterMeditor = MeditorManager.getMeditor(_target.uid) 
													as CharacterMeditor;
			_targetAI = meditor_target.ai;
			
			if(_skill.eff_up_self)	
			{
				_charVO = _atkAI._vo;
				/*createEft(_skill.eff_up_self, _delay, 
						  _charVO.scaleX, _atkAI.character.container_temp);*/
				
			}
 
			if(_skill.bulletId)
			{
				var bullet_cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Bullet, _skill.bulletId);
				var bullet_vo:BulletVO = ObjToModelUtil.ObjtoBullet(bullet_cfg);
				
				CommandManager.createBullet({atker:_atkAI.character, 
					target:_target, 
					bullet:bullet_vo, 
					track:bullet_vo.type,
					effect:_skill.eff_up_enimy})
					
			}else if(_skill.eff_up_enimy && _targetAI)	
			{
				if(_skill.objNum>1)
				{
					var targets:Dict = GameUtil.getSearchTargets(_atkAI._vo.camp);
					var dict:Dictionary = targets.dict;
					var objNum:int = _skill.objNum;
					for each(var i:CharacterBase in dict)
					{
						if(objNum <1) return;
						var len:int = GlobalUtil.getDistance( _atkAI.character.x, _atkAI.character.y,
																i.x, i.y);
						
						if(len > _atkAI._vo.range_atk) continue;
 
						meditor_target = MeditorManager.getMeditor(i.uid) 
							as CharacterMeditor;
						
						if(meditor_target && meditor_target.ai)
						{
							if(_ML.gameCfg.config.follow.hasOwnProperty(charState))
							{
								_atkAI._meditor.setFollowFun(
									_ML.gameCfg.config.follow[charState].frame,
									GameUtil.targetInjuredByNormal,
									[_targetAI, _skill]);
							}else{
								GameUtil.targetInjuredByNormal(_targetAI, _skill);
								
							}
//							GameUtil.targetInjuredByNormal(_targetAI, _skill);
							
							--objNum;
						}
					}
				}else{
					
					if(_ML.gameCfg.config.follow.hasOwnProperty(charState))
					{
						_atkAI._meditor.setFollowFun(
								_ML.gameCfg.config.follow[charState].frame,
								GameUtil.targetInjuredByNormal,
								[_targetAI, _skill]);
					}else{
						GameUtil.targetInjuredByNormal(_targetAI, _skill);
						
					}
				}
				 
			}
			
			
//			this.clear();
			
			//SoundManager.playSound(type);
		}
		
		 
		/*private function targetInjured(targetAI:CharacterAI):void
		{
			var vo:CharacterVO = targetAI._vo;
			if(!vo) return;
			var damage:int = _skill.damage;
			vo.hp -= damage;
			targetAI._model.setVO(vo);
			
			createEft(_skill.eff_up_enimy, _delay, 
				vo.scaleX, targetAI.character.container_top);
			
			GameUtil.playPKSnd(_skill.eff_up_enimy);
			
			targetAI.injured();
			
			var char:CharacterBase = targetAI.character;
			var posX:int = char.x + 10 * -vo.scaleX;
			if(posX > _ML.camera.x_right) posX = char.x + 10 * vo.scaleX;
			TweenMax.to(char,0.2,{x:posX, ease:Strong.easeOut});
			
			
		}
		
		private function createEft(eff:String, delay:int, scaleX:int, container:Sprite):void
		{
			var atkEft:SheetSprite = new SheetSprite(eff);
			new EffectMeditor(atkEft, 0, false, delay);
			atkEft.scaleX = scaleX;
			container.addChild(atkEft);
		}*/
		
		override public function clear():void
		{
			this._container = null;
			
			super.clear();
		}
	}
}
