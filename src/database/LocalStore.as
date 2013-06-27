package database 
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Elvis liuhaitao
	 */
	public class LocalStore 
	{
		
		public function LocalStore() 
		{
			
		}
		public static function setItem(_key:String,_str:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(_str);
			EncryptedLocalStore.setItem(_key, bytes);
		}
		public static function getItem(_key:String):String
		{
			var storedValue:ByteArray = EncryptedLocalStore.getItem(_key);
			if(storedValue == null)return '';
			return (storedValue.readUTFBytes(storedValue.length));
		}
		public static function removeItem(_key:String):void
		{
			EncryptedLocalStore.removeItem(_key);
		}
		
		public static function setObjData(key:String, obj:Object):void
		{
			var bt:ByteArray = new ByteArray();
			bt.writeObject(obj);
			EncryptedLocalStore.setItem(key, bt);
		}
		
		public static function getObjData(key:String):Object
		{
			var storedValue:ByteArray = EncryptedLocalStore.getItem(key);
			if(storedValue == null)return '';			
			return storedValue.readObject()
		}
	}

}