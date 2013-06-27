package command
{
	import component.Dict;
	
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.UIManager;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	import view.component.Zone;

	/**
	 * 生成角色
	 * @author Administrator
	 * 
	 */
	public class CreateCharacterCommand extends CommandBase
	{
		
		
		public function CreateCharacterCommand()
		{
			
			
		}

		override public function execute(params:Object=null):void
		{
			
			var pos:Array = params.pos;
			var itm:CharacterVO = params.vo;
			var container:Sprite = params.container;
			var cd_alive:int = params.cd_alive;
			var ai:Boolean = params.ai;
			if(!itm)return;
			
			var _vo:CharacterVO = itm;
			if(cd_alive) _vo.cd_alive = cd_alive;
			if(_vo.armyType == ArmyConfig.Type_Wall)
			{
				
				_vo.dir = GameUtil.getCharacterDefaultDir(ArmyConfig.Camp_Enemy );
			}else{
				_vo.res = (_vo.armyType == ArmyConfig.Type_Monarch
						  || _vo.armyType == ArmyConfig.Type_General) 
						  ? _vo.gid
						  : _vo.gid + '_step' + _vo.step;
				
				if(!_vo.dir)
				{
					var isDefault:Boolean = GameUtil.isDefaultDir(_vo.camp);
					_vo.dir = GameUtil.getCharacterDefaultDir(_vo.camp, isDefault);
				}
			}
 
			var _model:CharacterModel = null; 
			var char:CharacterBase;
			var ctr:CharacterMeditor = null;
			var zone:Zone = null;
			
			
			char = new CharacterBase(_vo.res, _vo.armyType, _vo.camp);
			char.name = itm.gid;

			_model = new CharacterModel(); 
			_vo.state = ArmyConfig.State_Wait;
			
			if(_vo.camp == ArmyConfig.Camp_Me)
			{	
				if(_vo.armyType == ArmyConfig.Type_Monarch)
				{
					_ML.master = char;
					this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Refresh_HeroHP, _vo));
				}
				// create hero zone
				/*var params:Object = {};
				params.ranges = [_vo.range_minGuard,  _vo.range_guard];
				params.pos = pos;
				params.id = itm.id;
				zone = CommandManager.createZone(params);*/
				
			}else{

				if(_vo.armyType == ArmyConfig.Type_General)
				{
					//敌方武将
					var npcLis:Array = _ML.pkNpcs.getVO() as Array;
					if(!npcLis) npcLis = [];
					npcLis.push(_vo);
					_ML.pkNpcs.setVO(npcLis);
					
					this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Refresh_HeroHP, _vo));
					
				}
			}
 
			char.x = pos[0];
			char.y = pos[1];
			
			ctr = new CharacterMeditor(char, _model, zone);
			
			if(_vo.camp != ArmyConfig.Camp_Fri) GameUtil.AddArmy(_vo.camp, char);
			
			_model.setVO(_vo);
			
			
			if(!container.contains(char))
			{
				container.addChild(char);
			}
			
			GlobalUtil.SortContainerChildren(container);
			
			if(ai) ctr.aiStart();
		}
	}
	
	
}