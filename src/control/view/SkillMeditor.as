package control.view
{
	import core.view.ViewBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	import manager.ModelLocator;
	
	import model.config.ArmyConfig;
	import model.config.GameCfg;
	import model.config.StaticConfig;
	import model.vo.GeneralVO;
	import model.vo.SheetVO;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	import control.view.sheet.SheetSpriteMeditor;
	
	public class SkillMeditor extends SheetSpriteMeditor
	{
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		private var _hero : GeneralVO;
		private var _skill:Object;
		
		public function SkillMeditor(view:ViewBase, hero:GeneralVO, skill:Object)
		{
			_hero = hero;
			_skill = skill;
			super(view);
			this._delay = 50;
		}
		
		override protected function addListenerCfg():void
		{
			/**移除view对象 liuxp 2011/9/20*/
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

		}
		
		override protected function removeListenerCfg():void
		{
			
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

		}
		
		override public function Play():void
		{
			if(this._render.isEnd())
			{
				var _pos:Point = new Point(_view.x, _view.y);
				//技能特效完毕，开始播放攻击者动画，然后播放技能效果，最后恢复所有受伤者动画
				var char:CharacterBase = GameUtil.getCharacterById(_hero.id);
				var ctr:CharacterMeditor = MeditorManager.getMeditor(char.uid) as CharacterMeditor;
				ctr.ai._isCD = false;
				//ctr.ai.releaseSkill({hero: this._hero, pos:_pos, skill:_skill});

//				this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Render_Resume, _hero.id));
				
				
				
				_view.dispose();
				return;
			}
			
			var srcBit:BitmapData = _render.render();
			_view.bitmap.bitmapData = srcBit;
			
			if(srcBit && _render.coords)
			{
				_view.bitmap.x = _render.coords[0];
				_view.bitmap.y = _render.coords[1];
			}
			
			
		}
		
		
		
		override public function clear():void
		{
			_hero = null;
			_skill = null;
			_ML = null;
			super.clear();
		}
	}
}