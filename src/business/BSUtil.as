package business
{
	import business.rmt.BSRmtCfg;
	
	/**
	 * 服务端请求API
	 * */
	public class BSUtil
	{
		public function BSUtil()
		{
			throw Error('can not instantiate!')
		}
		
		public static function GetUser():void
		{
			send(BSRmtCfg.API_Get_User, BSRmtCfg.RmtClass_Get_User, null);
		}
		
		private static function send(RmtAPI:String, BSClass:Class , params:Object=null):void
		{
			var bsRes :BSResponder = new BSClass();
			
			
			if(!params)
			{
				params = { method: RmtAPI, params : {} }
			}
			
			bsRes.params = params;
			var bsDel :BSDelegate = new BSDelegate(params, bsRes);
		}
	}
}