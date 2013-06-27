package net
{
    import flash.events.AsyncErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.navigateToURL;
    import flash.net.NetConnection;
    import flash.net.Responder;
    import flash.net.URLRequest;
    import flash.net.ObjectEncoding;
    /**
     * ...
     * @author ELF
     */
    public class RemotingConnect extends EventDispatcher
    {
        public static const NET_ERROR:String = 'NET_ERROR';
        private var netConnect:NetConnection = null;
        private var url:String = '';
        private var mainFunName:String = '';
        /**
         * 建立 网关协议
         * @param	_rpcURL
         * @param	_mainFunName
         */
        public function RemotingConnect(_rpcURL:String,_mainFunName:String) 
        {
//            try {
                this.mainFunName = _mainFunName;
                this.url = _rpcURL;
                this.netConnect = new NetConnection();
                this.netConnect.objectEncoding = ObjectEncoding.AMF3;
                this.netConnect.connect(_rpcURL);	
                this.netConnect.addEventListener(NetStatusEvent.NET_STATUS, this.onNET_STATUS);
                this.netConnect.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
                this.netConnect.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onASYNC_ERROR);
//            }catch (e:Error) { dispatchEvent(new Event(NET_ERROR));}
        }
        /**
         * 发送 请求
         * @param	_funName 
         * @param	_re 
         * @param	_parameters 
         */
        public function call_service(_re:Responder,_rpc:Object):void{			
            try{
                this.netConnect.call(this.mainFunName, _re , _rpc);			
            }catch (e:Error) {}
        }
        public function closeNet():void {
            this.netConnect.close();
            this.netConnect = null;
        }	
        private function onNET_STATUS(e:NetStatusEvent):void {
            dispatchEvent(new Event(NET_ERROR));
            try {
                //trace('\n####onNET_STATUS');
            }catch(e:Error){}
        }
        private function securityErrorHandler(e:SecurityErrorEvent):void {
            dispatchEvent(new Event(NET_ERROR));
            try {
                //trace('\n####securityErrorHandler');
            }catch(e:Error){}			
        }
        private function onASYNC_ERROR(e:AsyncErrorEvent):void {
            dispatchEvent(new Event(NET_ERROR));
            try {
                //trace('\n####onASYNC_ERROR');
            }catch(e:Error){}			
        }
    }
}