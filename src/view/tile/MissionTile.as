
package view.tile
{
	import component.ui.tiles.Tile;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.MaterialManager;
	import manager.ModelLocator;
	
	import model.config.StaticConfig;
	import model.vo.UserVO;
	
	import mx.core.mx_internal;
	
	import utils.GlobalUtil;
	
	
	/**
	 *
	 * MissionTile.as class. 
	 * @author Administrator
	 * Created 2013-5-28 下午3:00:51
	 */ 
	public class MissionTile extends SelectedTile
	{ 
		
		private var _icon:Bitmap;
		private var _sign:Bitmap;//tiaozhan
		private var _MM:MaterialManager = MaterialManager.getInstance();
		private var _ML:ModelLocator = ModelLocator.getInstance();
		private var _user:UserVO;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MissionTile()
		{
			super();
			
			
			_user = _ML.user.vo;
			_icon = GlobalUtil.createChildDisObj(this,Bitmap) as Bitmap;
			_sign = GlobalUtil.createChildDisObj(this,Bitmap) as Bitmap;
			
		} 
		
		 
		override public function set data(value:Object):void
		{
			_data = value;
			if(_data.type == StaticConfig.Mission_Mode_Challenge)
			{
				_sign.bitmapData = _MM.getMapMaterial('Mis_Challenge').bitmapData;
				
			}
			
			var chapter:Object = _user.progress[_user.seleced_chapter];
			
			if(chapter && chapter.hasOwnProperty(_data.id))//已经开启过的关卡
			{
				var lvstar:int = chapter[_data.id];
				
				if(lvstar == -1)//未打赢
				{
					_icon.bitmapData = _MM.getMapMaterial('Mis_Fail').bitmapData;
					
				}else if(lvstar >-1 && lvstar<3)//未3星
				{
					_icon.bitmapData = _MM.getMapMaterial('Mis_Pass').bitmapData;
					
				}else{//3星
					_icon.bitmapData = _MM.getMapMaterial('Mis_Perfect').bitmapData;
				}
				
			}else{//上锁
				_icon.bitmapData = _MM.getMapMaterial('Mis_Lock').bitmapData;
			}
			
			
		}
 
	}
	
}