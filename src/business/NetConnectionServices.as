package business
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	public class NetConnectionServices
	{
		private var _service : NetConnection;
		private var _isConnect : Boolean;
		//kingdowin.gicp.net
		//内网: http://192.168.0.180:8089
		//外网：http://app100641243.qzoneapp.com
		//public var url:String = 'http://app100641243.qzoneapp.com'
		public var url:String = 'http://kingdowin.3322.org'
		public var gateWay : String = url + '/gateway/'; //网关
		public var sessionId : String = '67b828a2280e6eb7e6136f188ea6cc5c';
		
		
		public function NetConnectionServices()
		{
			_service = new NetConnection;
			_service.objectEncoding = ObjectEncoding.AMF3;
			
			_service.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
			_service.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_service.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onASYNC_ERROR);
			
			Connect(gateWay + '?sessionid=' + sessionId);
		} 
		
		public function Connect(url:String):void
		{
			_service.connect(url);
		}
		
		private function onNetStatusHandler(e:NetStatusEvent):void
		{
			trace(e.info);
			switch(e.info.code)
			{
				case 'NetConnection.Call.Failed' :
					trace(e.info.code);
					break;
				default :
					break;	
			}
		}
		public function Send(res:flash.net.Responder,arg:Object):void
		{
			
			_service.call('amfp.api', res, arg);
			 
		}
		private function securityErrorHandler(e:SecurityErrorEvent):void {
			
			trace(e.text)		
		}
		private function onASYNC_ERROR(e:AsyncErrorEvent):void {
			
			trace(e.text)			
		}

	}
}