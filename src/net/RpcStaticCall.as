package net 
{
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author Elvis
	 */
	public class RpcStaticCall 
	{
		public static var $remoting:RemotingConnect = null;
        public static var JSON_TAG:String = 'false';
        private static var $URLLoader:URLLoader
        private static var $URLRe:URLRequest
		public function RpcStaticCall() 
		{
			
		}
		/**
		 * 建立service 连接
		 * @param	_rpcURL
		 * @param	_mainFunName
		 */
		public static function connectNet(_rpcURL:String,_mainFunName:String):void {
            if ($remoting != null) {
                $remoting.closeNet();
                $remoting = null;
            }
            else {
                $remoting = new RemotingConnect(_rpcURL,_mainFunName);
            }
		}	
        public static function toNet(_url:String):void{
            if($URLRe==null){
                $URLRe = new URLRequest(_url);
            }
            if($URLLoader==null){
                $URLLoader = new URLLoader();
            }
            $URLLoader.load($URLRe);
            
        }
		/**
		 * 请求每个 service 
		 * @param	_actionID		service ID
		 * @param	_rpcData		传输给 server  的数据包
		 * @param	_reFun			返回数据处理 function
		 * @param	_errorFun		
		 */
		public static function callService(_rpcData:Object, _reFun:Function = null, _errorFun:Function = null):void {
			$remoting.call_service(new Responder(_reFun, _errorFun) ,_rpcData);
		}		
	}

}