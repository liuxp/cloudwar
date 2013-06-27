
package business
{
	import flash.net.Responder;

    public class BSDelegate
	{
		private var _res : Responder;
		private static var _services : NetConnectionServices = new NetConnectionServices();
		
		public function BSDelegate(params : Object, result:BSResponder)
		{
			
			_res = new Responder(result.onResult, result.onFault);
			
			_services.Send(_res, params);
			
		}
		
		
	}
}