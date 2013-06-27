
package view.dispose
{
	import component.ui.SheetButton;
	
	import control.view.panel.MeditorPanelSkill;
	import control.view.panel.dispose.MeditorPanelArmyList;
	import control.view.panel.dispose.MeditorPanelDisposeSkill;
	import control.view.panel.dispose.MeditorPanelFriendList;
	import control.view.panel.dispose.MeditorPanelSkillList;
	import control.view.panel.dispose.MeditorPanelTroops;
	import control.view.sheet.SheetLoopMeditor;
	
	import flash.display.DisplayObject;
	
	import manager.MaterialManager;
	
	import model.config.AssetsCfg;
	
	import utils.GlobalUtil;
	
	import view.character.SheetSprite;
	import view.component.GameIcon;
	import view.scene.SceneBase;
	import view.tile.DisposeSkillTile;
	import view.tile.FriendTile;
	
	
	/**
	 *
	 * PanelCamp.as class. 
	 * @author Administrator
	 * Created 2013-5-30 下午10:18:23
	 */ 
	public class PanelDisposeUI extends SceneBase
	{ 
		//援军
		public var panelFri:PanelFriendList;
		public var dis_friend:PanelDisposeFriend;
		//军队
		public var panelArmies:PanelArmyList;
		public var dis_troops:PanelTroops;
		//技能
		public var panelSkills:PanelSkillList;
		public var dis_skill:PanelDisposeSkill;
		
		private var _curDis:DisposeBase;
		
		public var title:GameIcon
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function PanelDisposeUI()
		{
			super(MaterialManager.getInstance().getViewMaterial(AssetsCfg.UI_Dispose));
			
		} 
		
		public function initUIGroup():void
		{
			dis_friend = GlobalUtil.createChildDisObj(this,PanelDisposeFriend,328,80) as PanelDisposeFriend
			dis_friend.name = 'friend_btn';
			
			panelFri = GlobalUtil.createChildDisObj(this, PanelFriendList) as PanelFriendList;
			new MeditorPanelFriendList(panelFri, _ML.friends);
			
			panelArmies = GlobalUtil.createChildDisObj(this, PanelArmyList) as PanelArmyList;
			new MeditorPanelArmyList(panelArmies,_ML.arms);
			panelArmies.visible = false;
			
			dis_troops = GlobalUtil.createChildDisObj(this, PanelTroops,328,236) as PanelTroops;
			new MeditorPanelTroops(dis_troops,_ML.pkHeros);
			dis_troops.name = 'troop_btn';
			
			panelSkills = GlobalUtil.createChildDisObj(this, PanelSkillList) as PanelSkillList;
			new MeditorPanelSkillList(panelSkills,_ML.skills);
			panelSkills.visible = false;
			
			dis_skill = GlobalUtil.createChildDisObj(this, PanelDisposeSkill,328,328) as PanelDisposeSkill;
			new MeditorPanelDisposeSkill(dis_skill,_ML.pkSkills);
			dis_skill.name = 'skill_btn';
			
			var btn:SheetSprite = new SheetSprite(AssetsCfg.Eff_start);
			new SheetLoopMeditor(btn);
			addChild(btn);
			btn.x = 612;
			btn.y = 392;
			btn.name = 'start_btn';
			
			title = GlobalUtil.createChildDisObj(this, GameIcon,0,8) as GameIcon;
			showTitle(AssetsCfg.Title_Dispose_Friend);
		}
		
		public function showTitle(name:String):void
		{
			title.showImg(name);
		}
		
		public function showSelDispose(dispose:DisposeBase):void
		{
			if(this._curDis && this._curDis != dispose)
			{
				this._curDis.reset();
			}
			
			this._curDis = dispose;
			this._curDis.select();
			
			this.setRightUILayerOut();
		}
		
		public function setRightUILayerOut():void
		{
			
			dis_troops.y = this.dis_friend.y + this.dis_friend.height;
			this.dis_skill.y = this.dis_troops.y + this.dis_troops.height;
		}
	}
	
}