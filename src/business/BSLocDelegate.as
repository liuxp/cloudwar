package business
{
	import database.LocalDataService;
	import database.LocalStore;
	
	//import flash.net.Responder;
	
	public class BSLocDelegate
	{
		 
		
		public function BSLocDelegate(locAPI:String, BS:BSResponder, params:Object)
		{
			
			var data:Object = LocalStore.getObjData(locAPI);
			
			if(!data) data = {};
			data.api = locAPI;
			data.params = params;
			
			BS.onResult(data);
			
		}
		
		
	}
}