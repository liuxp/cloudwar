package database 
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Elvis liuhaitao
	 */
	public class SQLManager 
	{
		public static var $conn:SQLConnection;
		public static var $name_db:String;
		public static var $name_table:String;
		public static var $folder:File;
		public static var $dbFile:File;
		public static var $createStmt:SQLStatement;
		public static var $selectStmt:SQLStatement;
		public static var $insertStmt:SQLStatement;
		public static var $deleteStmt:SQLStatement;
		public static var $selectResult:SQLResult;
		public static var $userData:String
		public function SQLManager() 
		{
			
		}
		public static function init(_dbName:String = 'DB_Kingdowin_caocao_A.db',_tableName:String = 'DB_Kingdowin_caocao_A'):void {
			$name_db = _dbName;
			$name_table = _tableName;
			$userData = '1234ABCD'
			$conn = new SQLConnection();
			var folder:File = File.applicationStorageDirectory; 
		    var dbFile:File = folder.resolvePath(_dbName);  
			try {
//                $conn.close();
				$conn.open(dbFile);//1 
//				create_table();//尝试
				select_data();//尝试
//				delete_data();//尝试
			}
			catch (_error:SQLError){ 
				trace("Error message:", _error.message); 
				trace("Details:", _error.details); 
			} 
		}
		public static function create_table():void {
			$createStmt = new SQLStatement(); 
			$createStmt.sqlConnection = $conn; 
 
			var _sql:String =  
				"CREATE TABLE IF NOT EXISTS " + $name_table + " (" +
                " dataId TEXT ," + 
				" userData TEXT " +   
				")"; 
			try{
				$createStmt.text = _sql;
				$createStmt.execute();
				insert_data();
			}
			catch (_error:SQLError) {
				trace('create_table is error:', _error.message);
			}
		}	
		public static function select_data():void {
            $selectStmt = new SQLStatement();
			$selectStmt.sqlConnection = $conn;
			$selectStmt.text = "SELECT userData FROM " + $name_table;
			try{
                var _rNum:int
                var _data:Array
				$selectStmt.execute();
				$selectResult = $selectStmt.getResult();
                if($selectResult.data){
                    _rNum = $selectResult.data.length;
                    _data = $selectResult.data;
					trace(_data);	
					$conn.close();
                }
                else{
                    insert_data()//2
                }	
			}
			catch (_error:SQLError) {
				trace('select_data is error:', _error.message);
//				create_table()//2
			}			
		}
		public static function insert_data():void {
			$insertStmt = new SQLStatement();
			$insertStmt.sqlConnection = $conn;
			var _sql:String =  
				"INSERT INTO "+$name_table+" (userData) " +  
//				"VALUES (" + $userData + ")";
				"VALUES ('"+$userData+"')";
			$insertStmt.text = _sql;
			try 
			{ 
				// execute the statement 
				$insertStmt.execute();
				trace("INSERT statement succeeded"); 
			} 
			catch (error:SQLError) 
			{ 
//				create_table();
				trace("Error message:", error.message); 
				trace("Details:", error.details); 
			}  			
		}
		public static function delete_data():void {
			$deleteStmt = new SQLStatement();
			$deleteStmt.sqlConnection = $conn;
			var _sql:String = 
				"DELETE FROM " + $name_table;
			$deleteStmt.text = _sql;	
			try 
			{ 
				// execute the statement 
				$deleteStmt.execute();
				trace("delete statement succeeded"); 
			} 
			catch (error:SQLError) 
			{ 
//				create_table();
				trace("Error message:", error.message); 
				trace("Details:", error.details); 
			}			
		}
	}

}