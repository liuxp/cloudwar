package view.scene
{
	import control.view.DialogUIMeditor;
	import control.view.EnergyUIMeditor;
	import control.view.FoodUIMeditor;
	import control.view.MapBGImgMeditor;
	import control.view.PKUI.ArmyProductUIMeditor;
	import control.view.PKUI.HeroSKillUIMeditor;
	import control.view.PKUI.PKMessionUIMeditor;
	import control.view.TalkBubbleUIMeditor;
	
	import core.ModelBase;
	import core.view.ViewBase;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	import model.config.GameCfg;
	
	import mx.core.SpriteAsset;
	
	import utils.GlobalUtil;
	
	import view.dialog.DialogUI;
	import view.dialog.TalkBubble;
	
	public class PKScene extends SceneBase
	{
		public var container:Sprite;
		public var container_ui:Sprite;
		public var container_btn:Sprite;
		/*地图*/
		public var map:MapBGImg;
		/*尸体*/
		public var container_corpse:Sprite;
		/*英雄*/
		public var container_character:Sprite;
		/*子弹*/
		public var container_bullet:Sprite;
		/*pk结果*/
		public var container_result:Sprite;
		/*特效*/
		public var container_skill:Sprite;
		/*对战信息*/
		public var pkMessionUI:ViewBase;
		/*英雄技能*/
		public var pkSkillUI :ViewBase;//技能
		public var armyProductUI:ViewBase;//士兵生产
		public var pKMessionUI:ViewBase;				//游戏进度UI
		public var foodUI:ViewBase;
		public var dialogUI:DialogUI;
		public var energyUI:ViewBase;
		public var talkBubble:TalkBubble;//对话气泡
		public var skipStoryBtn:SimpleButton//胜利面板
		
		public function PKScene()
		{
			super();
			
			
			
			container = GlobalUtil.createContainer(this,true,false);
			container_ui = GlobalUtil.createContainer(this,true,false);
			container_btn = GlobalUtil.createContainer(this,true,false);
			
			map = new MapBGImg();
			new MapBGImgMeditor(map,new ModelBase);
			container.addChild(map);
			
			container_corpse = GlobalUtil.createContainer(container,true,false);
			
 			
			container_result = GlobalUtil.createContainer(container,false,false);
			
			
			container_character = GlobalUtil.createContainer(container,false,false);
			
 
			container_bullet = GlobalUtil.createContainer(container,false,false);
			
 
			container_skill = GlobalUtil.createContainer(container,false,false);
			
			
			//UI建立
			this.setUIGroup();
			this.updataPKUIforStage();
		}
		/**
		 * UI 自适应 x,y调整
		 */
		public function updataPKUIforStage():void {
			var _sw:Number = _ML.stage.stageHeight;
			var _sh:Number = _ML.stage.stageWidth;
			if (this.armyProductUI) {
				//this.pkSkillUI.x = _sw * 0.5 - this.pkSkillUI.width * 0.5;
				this.armyProductUI.y = 400; //_ML.getStageHeight() - pkSkillUI.height;
				 
			}
			
			if (this.foodUI) {
				//this.pKMessionUI.x = _sw * 0.5 - this.pKMessionUI.width * 0.5;
				this.foodUI.x = 8;
				this.foodUI.y = 352;
				//this.foodUI.y = pkSkillUI.y - pkSkillUI.height ;			
			}
			
			this.energyUI.y = 352;//this.foodUI.y;
			this.energyUI.x = 536; //_ML.getStageWidth() - this.energyUI.width - 10;
			
			if (this.dialogUI) {
				this.dialogUI.x = 9;
				this.dialogUI.y =  136;			
			}
		}
		public function setUIGroup():void {
			//兵种生产界面
			this.armyProductUI = new ViewBase(_MM.getViewMaterial(AssetsCfg.PKSkillUI));
			new ArmyProductUIMeditor(armyProductUI, _ML.pkHeros);
			container_ui.addChild(this.armyProductUI);
			
			this.pkSkillUI = new ViewBase();
			new HeroSKillUIMeditor(pkSkillUI, _ML.pkSkills);
			container_ui.addChild(this.pkSkillUI);
			
			
			//游戏进度UI
			this.pKMessionUI = new ViewBase(_MM.getViewMaterial(AssetsCfg.PKMessionUI));
			var _pKMessionUI_ctr:PKMessionUIMeditor = new PKMessionUIMeditor(pKMessionUI, _ML.user);
			container_ui.addChild(this.pKMessionUI);
			
			//粮草
			this.foodUI = new ViewBase(_MM.getViewMaterial(AssetsCfg.UI_Food));
			new FoodUIMeditor(this.foodUI, _ML.monarch_general);
			container_ui.addChild(this.foodUI);
			//气力
			this.energyUI = new ViewBase(_MM.getViewMaterial(AssetsCfg.UI_Energy));
			new EnergyUIMeditor(this.energyUI, _ML.monarch_general);
			container_ui.addChild(this.energyUI);
			
			//对话
			this.dialogUI = new DialogUI(_MM.getViewMaterial(AssetsCfg.UI_Dialog));
			new DialogUIMeditor(this.dialogUI);
			
			//气泡
			talkBubble = new TalkBubble(_MM.getViewMaterial(AssetsCfg.UI_TalkBubble));
			new TalkBubbleUIMeditor(talkBubble);
			
			//跳过剧情按钮
			this.skipStoryBtn =  _MM.getBtnMaterial(AssetsCfg.Btn_Skip);
			container_btn.addChild(this.skipStoryBtn);
			this.skipStoryBtn.x = 360;
			this.skipStoryBtn.y = 340;
			this.skipStoryBtn.visible = false;
			
		}
	}
}