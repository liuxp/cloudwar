
package business.local
{
	public class BSLocCfg
	{
		/*************************API**************************************/
		/**
		 *读取本地用户数据 API  sqlFetchExecute
		 */		
		public static const API_Get_User: String = 'user'; 
		/**
		 *保存本地用户数据 API  sqlSaveExecute
		 */		
		public static const API_Save_Local: String = 'sqlSaveExecute';
		
		
		/*************************CLASS**************************************/
		/**
		 *读取数据的LocGetUser
		 */		
		public static const LocClass_Get_User : Class = LocGetUser;
		/**
		 *保存数据的 LocWriteUserData类
		 */		
		public static const LocClass_Write_UserData : Class = LocWriteUserData;
	}
}