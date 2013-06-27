package database
{
	/**
	 * 本地数据库配置,包含所要操作的数据库地址和创建数据表的SQL（注意：创建表的sql语句中表名必须以table_开头）
	 * @author liaoqicai
	 * 
	 */	
	public class DataBaseConfig
	{
		public static const BASEDATA_URl:String = "localDatabase.db";
		
		public static const USERS_DATATABLE:String = "CREATE TABLE IF NOT EXISTS table_userData" +
			" (" +
			" uid TEXT PRIMART KEY," +
			" name TEXT," +
			" score INTEGER," +
			" old INTEGER" +
			" )";
	}
}