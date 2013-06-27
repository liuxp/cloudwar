
package control.view.PKUI
{
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	
	import model.GeneralModel;
	import model.ListModel;
	import model.SkillModel;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 *
	 * HeroSKillUIMeditor.as class. 
	 * @author Administrator
	 * Created 2013-5-6 下午10:12:50
	 */ 
	public class HeroSKillUIMeditor extends ViewWatcherMeditorBase
	{ 
		private var _heroSkills:Vector.<ViewBase>;
		private var _vo:Array;
		private var _container:Sprite;
		private var _view:ViewBase;
		private var _char:CharacterBase;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function HeroSKillUIMeditor(viewUI:ViewBase, mod:ListModel)
		{
			_vo = mod.getVO() as Array;
			_view = viewUI;
			_container = new Sprite;
			_view.addChild(_container);
			
			super(viewUI, mod);
		} 
		
		override protected function init():void
		{
			super.init();
			
//			initHeroSkills();
			
			
		}
		
		override public function update(data:Object):void
		{
			_vo = data as Array;
			//initHeroSkills();
		}
		
		override protected function addListenerCfg():void
		{
			this.addMeditorEventListener(MeditorEvent.PK_Start, onPKStartHandler)
		}
		
		private function onPKStartHandler(e:MeditorEvent):void
		{
			initHeroSkills();
		}
		
		private function initHeroSkills():void
		{ 
			GlobalUtil.removeAllChild(_container);
			if(!_vo) return;
			var len:uint = _vo.length
			var num:uint;
			
			for(var i:int; i<len; i++)
			{
				
				var mod:SkillModel = _vo[i] 
				var vo:SkillVO = mod.getVO() as SkillVO
				
				var skillUI:ViewBase = new ViewBase(_MM.getViewMaterial(AssetsCfg.HeroSkill));
				//hero.mouseEnabled = true;
				
				
				var ctr:HeroSkillMeditor = new HeroSkillMeditor(skillUI, [mod, _ML.monarch_general]);
				_container.addChild(skillUI);
				
				mod.setVO(vo);
				
				skillUI.x = 568 + num++ * (64+16) ;
				skillUI.y = 408;
			}
			
		}
	}
	
}