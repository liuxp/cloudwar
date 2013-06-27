package database
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;

	/**
	 * 本地数据库的操作
	 * @author liaoqicai
	 * 
	 */	
	internal class AIRSQLite
	{
		// 数据库连接字串
		public static var localSQLServer:SQLConnection = new SQLConnection();;
		
		
		
		
		/**
		 * 
		 * @param urlParameter 本地数据库地址
		 * @param tableSQLParameter 创建表达sql语句
		 * @return 本地数据库是否连接成功的bool值
		 * 
		 */		
		public static function setLocalSQLServer(urlParameter:String, tableSQLParameter:String):Boolean
		{
			try
			{
				var dbFile:File = File.applicationDirectory.resolvePath(urlParameter);
				if(localSQLServer.connected)
				{
					return true;
				}
				if(dbFile.exists){
					localSQLServer.open(dbFile, SQLMode.UPDATE);
				}else{
					localSQLServer.open(dbFile);
				}
				createTables(tableSQLParameter);
			}
			catch(error:Error)
			{
				return false;
			}
			return true;
		}
		
		
		
		/**
		 * 对本地数据库执行sql操作
		 * @param conn SQLConnection对象
		 * @param cmdParams SqlParameter参数对象
		 * @return 返回执行sql的结果
		 * 
		 */		
		public static function querySQL(conn:SQLConnection, cmdParams:SqlParameter = null):SQLResult
		{
			var sqlstatement:SQLStatement = new SQLStatement();
			sqlstatement.sqlConnection = conn;
			try
			{
				/*if(cmdParams && cmdParams.length > 0)
				{
					cmdParams.transParameters(sqlstatement);
				}*/
				
				cmdParams.transParameters(sqlstatement);
				sqlstatement.execute();
				cmdParams.clear();
			}
			catch(error:SQLError)
			{
				trace(error.details);
				throw error;
			}
			return sqlstatement.getResult(); 
		}
		
		/**
		 *建表 
		 * @param tableSQL 建表的sql
		 * 
		 */		
		private static function createTables(tableSQL:String):void
		{
			var createTables:SQLStatement = new SQLStatement();
			createTables.sqlConnection = localSQLServer;
			
			createTables.text = tableSQL;
				
			createTables.execute();
		}
		
		/**
		 *关闭数据库连接 
		 * 
		 */		
		public static function closeSQLConnection():void
		{
			localSQLServer.close();
		}
		
		/**
		 * 删除记录
		 * @param sqlConnection
		 * 
		 */		
		public static function clearCache(sqlConnection:SQLConnection):void
		{
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = "DELETE FROM statements";
			stmt.execute();
		}
	}
}