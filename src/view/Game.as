package view
{
	import control.view.scene.PKSceneMeditor;
	
	import core.view.ViewBase;
	
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import utils.GlobalUtil;
	
	import view.scene.PKScene;

	
	public class Game extends ViewBase
	{
		public var layerGame:Sprite; //
		public var layerPanel:Sprite;//场景
		public var layer_pop:Sprite;//弹窗容器
		public var layer_tip:Sprite;
		
		private var _ML:ModelLocator = ModelLocator.getInstance();
		/*场景*/
		public var scene_PK:PKScene;
		
		public function Game()
		{
			super();			
			this.mouseEnabled = false;

			this.initUI();
		}
		public function initUI():void {
			
			//
			this.layerGame = GlobalUtil.createContainer(this);
			this.layerPanel = GlobalUtil.createContainer(this);
			this.layer_pop = GlobalUtil.createContainer(this);
			this.layer_tip = GlobalUtil.createContainer(this,false,false);
 
		}
		
		public function setPanelScene():void {
			CommandManager.ChangeScene(StaticConfig.Scene_Entry);
		}
		public function delPanelScene():void {
			//if(this.mPanelScene.parent)
				//this.layerPanel.removeChild(this.mPanelScene);
			this.layerPanel.removeChildren();
		}
		public function panelStageToGame():void {
			
			//this.delPanelScene();
			this.setPKScene();
		}
		public function gameStageToPanel():void {
			this.setPanelScene();
			scene_PK.visible = false;
			
		}
		public function test_panelGameResult():void {
			var _vo:UserVO = _ML.user.getVO() as UserVO;
			//_vo.game_result = StaticConfig.GAME_RESULT_AWARD;
			_vo.game_result = StaticConfig.GAME_RESULT_FALSE;
			
		}
		
		public function setPKScene():void {
			if(!scene_PK)
			{
				scene_PK = new PKScene();
				var pk_ctr:PKSceneMeditor = new PKSceneMeditor(scene_PK, _ML.user);
				
			}
			if(!scene_PK.parent)
			{
				this.layerGame.addChild(scene_PK);	
			}
			scene_PK.visible = true;		
		}
		
	}
}