package command
{
	import component.tracks.Beeline;
	
	import control.view.CharacterMeditor;
	import control.view.bullet.ArrowMeditor;
	import control.view.bullet.BombMeditor;
	import control.view.bullet.BulletMeditor;
	import control.view.bullet.LaserMeditor;
	import control.view.bullet.StoneMeditor;
	
	import core.meditor.Meditor;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	/**
	 *生成子弹 
	 * @author Administrator
	 * 
	 */
	public class CreateBulletCommand extends CommandBase
	{
		private var _bulletContainer:Sprite;
		private var _atker:CharacterBase;
		private var _target:CharacterBase;
		
		public function CreateBulletCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			_atker = params.atker;  
			_target = params.target;
			var bulletType:String = params.bullet.Res;
			var otherSkills:Array = params.otherSkills;
			var effect:String = params.effect? params.effect : AssetsCfg.Hit;//受伤特效
			var type_atk:String = _atker.armyType;
			_bulletContainer = type_atk==ArmyConfig.Type_Brainman 
								? _ML.game.scene_PK.container_character 
								: _ML.game.scene_PK.container_bullet;
			//有轨迹
			if(bulletType)
			{
				var type:String =  bulletType; //GameUtil.getBulletType(type_atk);
				var bullet: SheetSprite = new SheetSprite(bulletType);
				var vo:BulletVO = new BulletVO; 
				vo.tx = _target ? _target.x : 960;
				vo.ty =  _target ? _target.y : _atker.y;
				vo.speed = _target ? 0 :params.bullet.speed;
				if(type_atk == ArmyConfig.Type_Catapult)
				{
					bullet.x = _atker.x - _atker.bitmap.width/2;
					bullet.y = _atker.y - _atker.bitmap.height;
					
				}else if(type_atk == ArmyConfig.Type_Archer)
				{
					bullet.x = _atker.x - 20;
					
					if(_target)
					{
						vo.ty = _target.y - 40;
						bullet.y = _atker.y - _atker.height/2;
					}else{
						
						bullet.y = _atker.y - 40;
					}
				} else{ 
					bullet.x = _atker.x;
					bullet.y = _atker.y;
					
				}
 
				vo.atk = _atker;
				vo.injured = _target;
				var ctrClass : Class = GameUtil.getBulletMeditorClassByType(params.track);
				var ctr:BulletMeditor = new ctrClass(bullet, vo, 
											{otherSkills:otherSkills, effect:effect});
				
				_bulletContainer.addChild(bullet);
				GlobalUtil.SortContainerChildren(_bulletContainer);
				
			}else{
				//瞬间击中
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(_target.uid) 
					as CharacterMeditor;
				var meditor_atker:CharacterMeditor =  MeditorManager.getMeditor(_atker.uid) 
					as CharacterMeditor;
				var vo_atker:CharacterVO = meditor_atker.model.getVO() as CharacterVO;
				
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO
					var camp:int = charVO.camp;
					
					if(GameUtil.isArmyAlive(camp, _target.uid))
					{
						if(!charVO.invincible)
						{
							

							/*var num:Number = GameUtil.getRestrictionByProfession(vo_atker.profession,
																				 charVO.profession)*/
							
							var atk:Number = vo_atker.atk;
							
							if(type_atk == ArmyConfig.Type_Dancer)
							{
								atk = -Math.min( atk, (charVO.hp_max - charVO.hp));
							}
							charVO.hp -= atk;
							model_target.setVO(charVO);

							meditor_target.ai.injured();
						}
						
						meditor_target.ai.setTarget(_atker);
 
						var posX : int = _target.x;
						var posY : int = charVO.armyType == ArmyConfig.Type_Wall
											? _atker.y
											: 0;
						
						
						/*CommandManager.createEffect({type: effect,
							pos:[0,posY],container:_target});*/
					}
					
					//GameUtil.playPKSnd(ArmyConfig.State_Injured, type_atk);
				}
			}
			
			clear();
		}
		
		
		 
		override public function clear():void
		{
			this._bulletContainer = null;
			this._atker = null;
			this._target = null;
			
			super.clear();
		}
	}
}