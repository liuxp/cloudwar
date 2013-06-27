package control.view.bullet
{
	import component.tracks.Beeline;
	import component.tracks.Parabola;
	
	import core.view.ViewBase;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.vo.BulletVO;
	
	import utils.GameUtil;
	
	public class ArrowMeditor extends BulletMeditor
	{
		protected var _track:Parabola;
		
		public function ArrowMeditor(view:ViewBase, vo:BulletVO, params:Object=null)
		{
			super(view, vo, params);
			
			_track = new Parabola(_view,vo.tx, vo.ty, vo.speed);
		}
		
		override public function Play():void
		{
			super.Play();
			
			/*_view.bitmap.x = _render.coords[0];
			_view.bitmap.y = _render.coords[1];*/
			
			_track.Render();
			
			if(_view.x == _bulletVO.tx && _view.y==_bulletVO.ty)
			{
				var type : String = _bulletVO.atk.armyType;
				
				
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