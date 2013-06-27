package control.view.bullet
{
	import component.Dict;
	import component.tracks.Beeline;
	import component.tracks.Parabola;
	import component.tracks.Rays;
	
	import control.view.CharacterMeditor;
	
	import core.view.ViewBase;
	
	import events.MeditorEvent;
	
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.CharacterModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.vo.BulletVO;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	/**
	 *穿透 
	 * @author Administrator
	 * 
	 */	
	public class LaserMeditor extends BulletMeditor
	{
		protected var _track:Rays;
		private var _cd:int;
		
		public function LaserMeditor(view:ViewBase, vo:BulletVO,  params:Object=null)
		{
			super(view, vo, params);
			
			_track = new Rays(_view,vo.tx, vo.ty, vo.speed);
		}
		
		override public function Play():void
		{
			super.Play();
			
			/*if(++_cd%2==0)
			{
				CommandManager.createEffect({type:'AoeAP03',
											pos:[_view.x,_view.y]});
			}*/
 
			_track.Render();
			
			if(_view.x >= _bulletVO.tx )
			{
				
				
				var type : String = _bulletVO.atk.armyType;
				
				//GameUtil.playPKSnd(ArmyConfig.State_Injured, type);
				
				skillEff();
				searchTargets();
				_view.dispose();
				
				
				
			}
		}
		override protected function searchTargets():void
		{
			var meditor_atker:CharacterMeditor =  MeditorManager.getMeditor(_bulletVO.atk.uid) 
				as CharacterMeditor;
			var atker:CharacterBase = meditor_atker.view as CharacterBase;
			var vo_atker:CharacterVO = meditor_atker.model.getVO() as CharacterVO;
			var gerVO:GeneralVO = GameUtil.getPKArmyData(_bulletVO.atk.camp,_bulletVO.atk.name);
			var targets:Dict = GameUtil.getSearchTargets(vo_atker.camp);
			var dict:Dictionary = targets.dict;
			var scale_x:int = vo_atker.scaleX;
			for each(var i:CharacterBase in dict)
			{
				var dis_x:int = i.x - atker.x;
				if(dis_x >=0 && scale_x>0)
				{
					continue;
				}else if(dis_x<=0 && scale_x<0)
				{
					continue;
				}
				var len:int = Math.abs(this._bulletVO.ty - i.y);
				if(len > _bulletVO.range) continue;
				
				var viewId:String = i.uid;
				var meditor_target:CharacterMeditor = MeditorManager.getMeditor(viewId) 
					as CharacterMeditor;
				
				if(meditor_target && meditor_target.ai)
				{
					var model_target:CharacterModel = meditor_target.model as CharacterModel;
					var charVO:CharacterVO = model_target.getVO() as CharacterVO;
					var camp:int = charVO.camp;
					
					
					
					if(GameUtil.isArmyAlive(camp, viewId))
					{
						charVO.hp -= vo_atker.atk;
						model_target.setVO(charVO);
						
						meditor_target.ai.injured();
						meditor_target.ai.setTarget(_bulletVO.atk);
						
						
					}
					
					
				}
				
			}
		}
		override protected function skillEff():void
		{
			
			var posX : int = _view.x;
			
			var posY : int = _view.y;
			
			CommandManager.createEffect({type:AssetsCfg.Hit,
				pos:[posX,posY]});
			
		}
		
		override public function clear():void
		{
			_track = null;
			super.clear();
		}
	}
}