package command
{
	
	import control.view.panel.MeditorPanelArmyTraining;
	import control.view.panel.MeditorPanelCamp;
	import control.view.panel.MeditorPanelEntry;
	import control.view.panel.MeditorPanelEquipCompose;
	import control.view.panel.MeditorPanelEquipSelect;
	import control.view.panel.MeditorPanelEquipStrength;
	import control.view.panel.MeditorPanelHeroSelect;
	import control.view.panel.MeditorPanelMission;
	import control.view.panel.MeditorPanelSkill;
	import control.view.panel.MeditorPanelStoreBuy;
	import control.view.panel.MeditorPanelStoreSold;
	import control.view.panel.dispose.MeditorPanelDispose;
	import control.view.scene.PanelPKFailMeditor;
	import control.view.scene.PanelPKWinMeidtor;
	
	import core.view.ViewBase;
	
	import flash.display.Sprite;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.config.UICfg;
	import model.vo.UserVO;
	
	import view.Game;
	import view.dispose.PanelDisposeUI;
	import view.panel.PanelArmyTraining;
	import view.panel.PanelCamp;
	import view.panel.PanelEntry;
	import view.panel.PanelEquipCompose;
	import view.panel.PanelEquipSelect;
	import view.panel.PanelEquipStrength;
	import view.panel.PanelHeroSelect;
	import view.panel.PanelHeroSkill;
	import view.panel.PanelMission;
	import view.panel.PanelPKWin;
	import view.panel.PanelStoreBuy;
	import view.panel.PanelStoreSold;
	import view.scene.SceneBase;
	
	 
	
	/**
	 *更换场景
	 * @author Administrator
	 * 
	 */
	public class ChangeSceneCommand extends CommandBase
	{
		private var _scene:Game;
		private var _vo:UserVO;
		private var _MM:MaterialManager = MaterialManager.getInstance();
		
		public function ChangeSceneCommand()
		{
			super();
 
		}
		
		override public function execute(params:Object=null):void
		{
			_scene = _ML.game;

			var resultUI:String;
			var view:ViewBase;
			
			switch(params)
			{
			
				case StaticConfig.Scene_PK_Fail :
					resultUI = AssetsCfg.UI_Game_Result_FailUI;
					view = new SceneBase(_MM.getViewMaterial(resultUI));
					new PanelPKFailMeditor(view);
					_scene.layer_pop.addChild(view);
					
					if(_scene.scene_PK){
						_scene.scene_PK.remove();
						CommandManager.clearMession();
					}
					
					break;
				case StaticConfig.Scene_PK_Win :
					resultUI = AssetsCfg.UI_Game_Result_WinUI;
					view = new PanelPKWin();
					new PanelPKWinMeidtor(view);
					_scene.layer_pop.addChild(view);
					
					if(_scene.scene_PK){
						_scene.scene_PK.remove();
						CommandManager.clearMession();
					}
					break;
				case StaticConfig.Scene_Entry ://游戏开始界面
					view = new PanelEntry();
					new MeditorPanelEntry(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_Camp ://大本营
					view = new PanelCamp();
					new MeditorPanelCamp(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_HeroSkill ://英雄技能
					view = new PanelHeroSkill();
					new MeditorPanelSkill(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_Army ://军队
					view = new PanelArmyTraining();
					new MeditorPanelArmyTraining(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_EquipSelect ://装备更换
					view = new PanelEquipSelect();
					new MeditorPanelEquipSelect(view, [_ML.heroEquip, _ML.equips]);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_EquipStrength ://装备强化
					view = new PanelEquipStrength();
					new MeditorPanelEquipStrength(view, [_ML.monarch_general, _ML.equips]);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_EquipCompose ://装备合成
					view = new PanelEquipCompose();
					new MeditorPanelEquipCompose(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_HeroSelect ://英雄更换
					view = new PanelHeroSelect()
					new MeditorPanelHeroSelect(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_StoreBuy ://商店
					view = new PanelStoreBuy()
					new MeditorPanelStoreBuy(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_StoreSold ://商店
					view = new PanelStoreSold()
					new MeditorPanelStoreSold(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_Army ://兵种
					view = new PanelArmyTraining()
					new MeditorPanelArmyTraining(view);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_Mission ://关卡
					view = new PanelMission()
					new MeditorPanelMission(view, _ML.user);
					_scene.layerPanel.addChild(view);
					break;
				case StaticConfig.Scene_Dispose ://战前部署
					view = new PanelDisposeUI()
					new MeditorPanelDispose(view, _ML.user);
					_scene.layerPanel.addChild(view);
					break;
				default:
					break;
			}
 
		}
		
		override public function clear():void
		{
			super.clear();
			_scene = null;
			_MM = null;
		}
	}
}