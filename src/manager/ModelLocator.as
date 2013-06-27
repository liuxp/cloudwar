package manager
{
	import component.Dict;
	
	import flash.display.Stage;
	
	import model.CharacterModel;
	import model.EquipModel;
	import model.GeneralModel;
	import model.ListModel;
	import model.MessionModel;
	import model.UserModel;
	import model.config.GameCfg;
	import model.vo.CameraVO;
	import model.vo.EquipListVO;
	import model.vo.EquipVO;
	import model.vo.MessionVO;
	import model.vo.WaveVO;
	
	import view.Game;
	import view.character.CharacterBase;
	
	public class ModelLocator
	{
		private static var _instance : ModelLocator;
		
		public var game:Game;
		public var stage:Stage;
		public var gameCfg:GameCfg;
		public var wave:WaveVO; 
		public var ourDirDefault:Boolean;
		public var enemyDirDefault:Boolean;
		public var user : UserModel;
		
		public var enemies : Dict;//角色列表
		public var myArmies :Dict;//角色列表
		public var master:CharacterBase;//主角
		public var monarch_general:GeneralModel; //赵云Monarch
		public var monarch_character:CharacterModel;
		public var master_atkTarget:CharacterBase;
		public var boss:CharacterBase;
		
		public var isCharSort:Boolean;//角色排序
		
		public var equips:EquipModel;
		public var heroEquip:EquipModel;
		public var selEquip:EquipModel;
		public var pkHeros:ListModel;//参加战斗的英雄
		public var pkNpcs:ListModel;//参加战斗的npc
		public var arms:ListModel;//所有的军队
		public var skills:ListModel;
		public var pkSkills:ListModel;
		
		public var reward:Object = {};//奖励
		public var camera:CameraVO;
		public var dialogType:String;
		
		public var friends:ListModel;
		
		public function ModelLocator(single:SingleTon)
		{
			 if(single){
			 	
			 	this.gameCfg = new GameCfg();
			 	this.user = new UserModel;
				this.enemies = new Dict;
				this.myArmies = new Dict;
			 	this.pkHeros = new ListModel();
				this.pkNpcs = new ListModel();
				this.camera = new CameraVO();
				this.equips = new EquipModel();
				this.friends = new ListModel();
				this.arms = new ListModel();
				this.skills = new ListModel();
				this.pkSkills = new ListModel();
				this.heroEquip = new EquipModel();
				this.selEquip = new EquipModel();
			 }
		}
		public static function getInstance():ModelLocator
		{
			if(!_instance)
			{
				_instance = new ModelLocator(new SingleTon());
			}
			return _instance;
		}
		/**
		 * 获得 stage 长宽
		 */
		public function getStageWidth():Number {
			//return this.stage == null?GameCfg.stageWidth:this.stage.stageWidth;
			return GameCfg.stageWidth;
		}
		public function getStageHeight():Number {

			//var height:int = this.stage == null?GameCfg.stageHeight:this.stage.fullScreenHeight;
			//var height:int = this.stage == null?GameCfg.stageHeight:this.stage.fullScreenHeight;
			return GameCfg.stageHeight;
 
		}		
	}
}
class SingleTon{}