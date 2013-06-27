package component
{
	import flash.net.SharedObject;
	
	public class ShareObj
	{
		public function ShareObj()
		{
		}
		/**得到缓存文件
		 * @ param name
		 * @ reutn*/
		public static function getSOByName(name:String):SharedObject
		{
			var so : SharedObject = SharedObject.getLocal(name);
			return so;
		}
		
		/**更新缓存文件某一属性值
		 * @ param so 
		 * @ param key
		 * @ param value
		 **/
		public static function setSODataByVO(so:SharedObject, key:String, value:*):void
		{
			
			try{
				so.data[key]=value;
				so.flush();
			}catch(e:Error){
				return;
			}
			
		}
		/**返回缓存文件某一属性值
		 * @ param so 
		 * @ param key
		 * @ return
		 **/
		public static function getSODataByVO(so:SharedObject, key:String ):*
		{
			return so.data[key] ;
		}
		/**删除缓存文件某一属性
		 * @ param so 
		 * @ param key
		 * @ return
		 **/
		public static function delSODataByVO(so:SharedObject, key:String ):*
		{
			 so.data[key]=null ;
			 delete so.data[key];
		}
		
		/*移动设备提供了本地文件系统，应用程序可利用这种本地文件系统来存储首选项、文档等。
		通常来说，应用程序应该假设此存储即可由应用程序本身访问，不得与其他应用程序共享。
		在所有平台上多可以通过 File.applicationStorageDirectory 属性访问这个存储。*/
	}
}