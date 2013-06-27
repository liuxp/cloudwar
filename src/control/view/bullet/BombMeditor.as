package control.view.bullet
{
	import core.view.ViewBase;
	
	import model.config.ArmyConfig;
	import model.vo.BulletVO;
	
	import utils.GameUtil;
 
	
	public class BombMeditor extends BulletMeditor
	{
		 
		public function BombMeditor(view:ViewBase,  vo:BulletVO, params:Object=null)
		{
			 
			_bulletVO = vo;
			_bulletVO.range = 40;
			super(view, vo, params);
		}
		
		override public function Play():void
		{
			super.Play();
			
			_view.bitmap.x = _render.coords[0];
			_view.bitmap.y = _render.coords[1];
 
			if(_bulletVO.cd-- <=0 )
			{
				var type : String = _bulletVO.atk.armyType;
				
				//GameUtil.playPKSnd(ArmyConfig.State_Injured, type);
 
				skillEff();
				searchTargets();
				_view.dispose();
 
			}
			
		}
		 
	}
}