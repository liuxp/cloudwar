package control.view.bullet
{
	import component.tracks.Beeline;
	import component.tracks.Parabola;
	
	import core.view.ViewBase;
	
	import model.config.ArmyConfig;
	import model.vo.BulletVO;
	
	import utils.GameUtil;
	
	public class StoneMeditor extends BulletMeditor
	{
		protected var _track:Beeline;
		
		public function StoneMeditor(view:ViewBase, vo:BulletVO, params:Object=null)
		{
			super(view, vo, params);
			
			_track = new Beeline(_view,vo.tx, vo.ty);
		}
		
		override public function Play():void
		{
			super.Play();
			
			_view.bitmap.x = _render.coords[0];
			_view.bitmap.y = _render.coords[1];
			
			_track.Render();
			
			if(_view.x == _bulletVO.tx && _view.y==_bulletVO.ty)
			{
				var type : String = _bulletVO.atk.armyType;
				
				//GameUtil.playPKSnd(ArmyConfig.State_Injured, type);
				
				_track.stopRender();
				skillEff();
				searchTargets();
				_view.dispose();
				
				
				
			}
		}
		
		override public function clear():void
		{
			_track = null;
			super.clear();
		}
	}
}