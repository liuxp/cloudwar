package database
{
	import flash.data.SQLStatement;
	
	/**
	 * 保存数据的obj对象，转化SQLStatement对象的参数和SQL语句
	 * @author liaoqicai
	 * 
	 */	
	internal dynamic class SqlParameter extends Object
	{
		private var parameter : Object;
		private var sql:String;
		private var type:String;
		public function SqlParameter(par:Object,sqlStr:String)
		{
			parameter = par;
			if(sqlStr){
				sql = sqlStr;
				//保存数据
				if(sql.indexOf("replace")!=-1)
				{
					type = "replace";
					//更新数据
				}else if(sql.indexOf("update")!=-1)
				{
					type = "update";
				}else if(sql.indexOf("select")!=-1)
				{
					type = "select";
				}
			}
		}
		/**
		 * 给SQLStatement参数赋值
		 * @param sqlstatement sqlstatement对象
		 * 
		 */		
		public function transParameters(sqlstatement:SQLStatement):void
		{
			var keysStr:String="";
			var valueStr:String="";
			for (var i:String in parameter)
			{
				sqlstatement.parameters[':'+i] = parameter[i];
				if(type=="replace")
				{
					if(keysStr!="") keysStr += ",";
					keysStr += i;
					if(valueStr!="") valueStr += ",";
					valueStr += ":";
					valueStr += i;
				}else{
					if(valueStr!="") valueStr += ",";
					valueStr += i;
					valueStr += "=:";
					valueStr += i;
				}
			}
			if(keysStr!=""&&type=="replace") sql = sql.replace("&key",keysStr);
			if(valueStr!="") sql = sql.replace("&value",valueStr);
			sqlstatement.text = sql;
		}
		
		/**
		 * 清除全部属性
		 * 
		 */		
		public function clear():void
		{
			parameter = null;
			sql = "";
		}
	}
}