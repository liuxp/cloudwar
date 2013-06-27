package database
{
	import database.AIRSQLite;
	import database.SqlParameter;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;

	/**
	 *本地数据存储 
	 * @author liaoqicai
	 * 
	 */	
	public class LocalDataService
	{
		/**
		 * 保存本地数据
		 * @param baseDataurl 要连接到的数据库地址
		 * @param tableSQL 创建数据表的SQL语句
		 * @param obj 保存的对象
		 * @return 保存成功的bool值
		 * 
		 */		
		public static function sqlSaveExecute(baseDataurl:String, tableSQL:String, obj:Object):Boolean{
			if(!obj.uid) throw new Error("保存的对象必需uid字段.......");
			var regExp:RegExp = /\btable_\w*\b/;
			var resultExp:Array = regExp.exec(tableSQL);
			if(!resultExp) throw new Error("数据表名不对..........");
			try{
				if(!AIRSQLite.setLocalSQLServer(baseDataurl,tableSQL))
				{
					trace("连接失败");
					return false;
				}
				var resultArr:Array = sqlFetchExecute(baseDataurl,tableSQL,{"uid":obj.uid}); 
				var sql:String;
				if(resultArr&&resultArr.length>0){
					sql = "update "+resultExp[0]+" set &value where uid=:uid";
				}else{
					sql = "replace into "+resultExp[0]+" (&key) values(&value)";
				}
				var parameter:SqlParameter = new SqlParameter(obj,sql);
				var result:SQLResult = AIRSQLite.querySQL(AIRSQLite.localSQLServer,parameter);
				if(result.rowsAffected==0){
					return false;
					trace("保存失败,影响行数为0行");
				}
			}catch(e:Error){
				trace("sql error ！@"+e.toString());
				return false;
			}
			return true;
		}
		
		/**
		 * 查询数据库
		 * @param baseDataurl 查询的数据库
		 * @param tableSQL 查询的数据表
		 * @param obj 查询的对象(该对象由一个查询值对组成的查询条件。例obj={key:value}。如取默认值null则按uid查询所有记录);
		 * @return 返回查询的信息
		 * 
		 */		
		public static function sqlFetchExecute(baseDataurl:String, tableSQL:String, obj:Object=null):Array{
			var regExp:RegExp = /\btable_\w*\b/;
			var resultExp:Array = regExp.exec(tableSQL);
			if(!resultExp) throw new Error("数据表名不对..........");
			try{  
				if(!AIRSQLite.setLocalSQLServer(baseDataurl,tableSQL))
				{
					trace("连接失败");
					return null;
				}
				var sql:String;
				var parameter:SqlParameter;
				if(obj) sql = "select * from "+ resultExp[0] + " WHERE &value";
				else sql = "select uid from "+resultExp[0];
				parameter = new SqlParameter(obj,sql);
				var result:SQLResult = AIRSQLite.querySQL(AIRSQLite.localSQLServer,parameter); 
				var arr:Array = result.data;
			}catch(e:Error){
				trace("sql error ！@"+e.toString());
			}
			return arr;
		}
		
		/**
		 *关闭数据库连接 
		 * 
		 */		
		public static function closeSQLConnection():void
		{
			AIRSQLite.closeSQLConnection();
		}
		
	}
}
