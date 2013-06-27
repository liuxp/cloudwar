package command
{
	import flash.display.Sprite;
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	
	import view.scene.MapBGImg;

	public class CreateBattleMapCommand extends CommandBase
	{
		private var container_map:MapBGImg;
		
		public function CreateBattleMapCommand()
		{
			super();
			var container:Sprite =_ML.game.scene_PK.container;
			container.x = 0;
			container_map = _ML.game.scene_PK.map;
		}
		
		override public function execute(params:Object=null):void
		{
			 
			var user:UserVO  = _ML.user.getVO() as UserVO;
			
			if(!params)
			{
				var bg:String = user.mMession.BaseSet.Background;
				container_map.drawBg(bg, user.mMession.BaseSet.BgSize); 
			}else{
				container_map.addImg(params.bit, params.matrix);
			}
			
				
			 
		}
		
		
	}
}