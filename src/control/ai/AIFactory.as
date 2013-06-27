package control.ai
{
	import control.ai.Escape;
	import control.view.CharacterMeditor;
	
	import flash.utils.getDefinitionByName;
	
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	
	import utils.GameUtil;
	
	import view.component.Zone;
	
	public class AIFactory
	{
		public function AIFactory()
		{
			
		}
		
		public static function getAI(vo:CharacterVO, meditor:CharacterMeditor, 
									 zone:Zone=null):CharacterAI
		{
			var ai:CharacterAI;
			var armyType:String = vo.armyType;
			if(vo.boss)
			{
				ai = new Conjure(meditor);
			}else if(vo.init_ai)
			{
				Escape,Standby;
				var aiClass:Class = flash.utils.getDefinitionByName('control.ai.' + vo.init_ai) as Class;
				ai = new aiClass(meditor);
			}else{
				switch(armyType)
				{
					case ArmyConfig.Type_Monarch :	
						vo.camp == ArmyConfig.Camp_Enemy 
						? ai = new Peace(meditor)
						: ai = new Puppet(meditor);
						break;
					case ArmyConfig.Type_Walk :
						vo.camp == ArmyConfig.Camp_Enemy
						? ai = new Forward(meditor)
						: ai = new Cover(meditor);
						break;
					case ArmyConfig.Type_Assassin :
					case ArmyConfig.Type_Spear :
					case ArmyConfig.Type_Fighter :
						vo.camp == ArmyConfig.Camp_Enemy
							? ai = new Forward(meditor)
							: ai = new Assist(meditor);
						break;
					case ArmyConfig.Type_General :	
						vo.camp == ArmyConfig.Camp_Enemy
						? ai = new Surround(meditor)
						: ai = new Assist(meditor);
						break;
					case ArmyConfig.Type_Archer :
						ai = new Aim(meditor);
						break;
					case ArmyConfig.Type_Brainman :	
					case ArmyConfig.Type_Warlock :	
						vo.camp == ArmyConfig.Camp_Enemy 
						? ai = new Forward(meditor)
						: ai = new MagicOnly(meditor);
						break;
					case ArmyConfig.Type_Wall :
						ai = new Static(meditor)
						break;
					case ArmyConfig.Type_Catapult :
						vo.camp == ArmyConfig.Camp_Enemy 
						? ai = new Snipe(meditor)
						: ai = new MagicOnly(meditor);
						break;
					case ArmyConfig.Type_Dancer :	
						
						vo.camp == ArmyConfig.Camp_Enemy 
						? ai = new Peace(meditor)
						: ai = new Renew(meditor);
						break;
					default:
						ai = new Peace(meditor);
						break;
				}
			}
			
			
			return ai;
		}
		
		
	}
}
