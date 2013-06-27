package business
{
	import business.local.BSLocCfg;
	
	import database.DataBaseConfig;
	 
	/**
	 * 本地请求API
	 * @author Administrator liaoqicai
	 * 
	 */	
	public class BSLocUtil
	{
		public function BSLocUtil()
		{
			throw Error('can not instantiate!')
		}
		
		/**
		 * 从本地sever中,读取用户数据;
		 * @param key 获取数据的键
		 * @param value 键值
		 * 
		 */		
		public static function GetUser():void
		{
			
			send(BSLocCfg.API_Get_User, BSLocCfg.LocClass_Get_User);
		}
		/**
		 * 向本地数据库写数据
		 * @param obj  需要写入的对象
		 * 
		 */		
		public static function WriteUserData(obj:Object):void
		{
			//send(BSLocCfg.API_Save_Local, DataBaseConfig.BASEDATA_URl, DataBaseConfig.USERS_DATATABLE, BSLocCfg.LocClass_Write_UserData, obj);
		}
		
		/**
		 * 
		 * @param LocalAPI 操作本地数据库的API
		 * @param DataBaseurl 要操作的本地数据库地址
		 * @param TableSQL 需要创建的数据表SQL语句
		 * @param BSClass BSResponder业务逻辑类
		 * @param params 操作数据库需要的参数
		 * 
		 */		
		private static function send(LocalAPI:String, BSClass:Class , params:Object=null):void
		{
			var bsRes :BSResponder = new BSClass();
			
			var bsDel :BSLocDelegate = new BSLocDelegate(LocalAPI, bsRes, params);
		}
	}
}