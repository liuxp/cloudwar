package net 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author ...
	 */
	public class SendAndSelect extends EventDispatcher
	{
		
		public static const ACTIONID:String = 'actionID';
		public static const ACTIONID_a:String = 'a';
		public static const SEND_TIME:String = "sendTime"; 	
		public static const RE_FUNCTION:String = "reFunction";
		public static const RECONNECTION:String = "reconnection";		//重连次数
		public static const SEND_METHOD:String = "sendMethod";
		public static const SESSIONID:String = "sessionid";
		public static const SERVER_NOW:String = 'server_now';
		public static const SERVER_NOW_TIMER:String = '$datetime';
		public static const RETURN_CODE:String = 'return_code';
		public static const METHOD:String = 'method';
		public static const PARAMS:String = 'params';		
		public static const RANDOM_NUM:Number = 1000000000;	
		public static const GUIDE_SIGN:String = 'guideSign';
		
        public static var $serviceData:Dictionary = new Dictionary();//消息功能组存储，队列字典
        public static var $systemTimer:Timer;//模拟服务器计数器
        public static var $sessionid:String;//
		
		public static var $systemTimer_nowSecond:Number = 0;//服务器当前时间，秒
		public static var $systemTimeDate:Date;
		public static var $SendServiceAMFDispatcher:EventDispatcher = new EventDispatcher();
		public function SendAndSelect() { throw new Error('无法实例化'); }
		/**
		 * 获得 全局 通信 对象 remoting 
		 * @return
		 */
		public static function getConnectNetRemoting():RemotingConnect {
			return RpcStaticCall.$remoting;
		}
		/**
		 * 建立 全局 通信 
		 * @param	_rpcURL					服务器 网管 URL http://192.168.0.0/gateway
		 * @param	_mainFunName			服务器 统一 后台 功能类 函数 http_api
		 */
		public static function setConnectNet(_rpcURL:String,_mainFunName:String):void {
			RpcStaticCall.connectNet(_rpcURL, _mainFunName);
		}
		/**
		 * 静态 消息 统一 返回
		 * @param	_method
		 * @param	_send_data
		 * @param	_reFun
		 * @param	_isUid
		 */
		public static function sendAndSelectService(_method:String, _send_data:Object = null, _reFun:Function = null, _isListenerFun:Function = null):void {
			var _data:Object = _send_data == null? { } :_send_data;
			//-----------------------建立 消息 ID 
			_data[ACTIONID] = ACTIONID_a + (new Date()).getTime().toString() + Math.floor(Math.random() * RANDOM_NUM).toString();
			//-----------------------建立消息功能组
			var _obj:Object = {};
			_obj[RE_FUNCTION] = _reFun;		//返回数据后执行的方法
			_obj[SEND_TIME] = new Date();	//发送时间
			_obj[SEND_METHOD] = _method;	//发出的方法，方便查重
			//-----------------------
			$serviceData[_data[ACTIONID]] = _obj;//消息功能组存储，队列字典	
			//-----------------------//存放广播侦听 器收听 Fun
			if($sessionid){
				_data[SESSIONID] = $sessionid;
			}
			if (_isListenerFun!=null){
				$SendServiceAMFDispatcher.addEventListener(NetEvent.NET_BROADCAST_ALL, _isListenerFun, false, 0, true);
			}
			//-----------------------发送消息
			RpcStaticCall.callService( {method:_method, params:_data}, reCheckFun, reErrorCheckFun);
			//RpcStaticCall.callService( {gateway_key:SendServiceAMFFun.$gatewayKey, method:_method, params:_data }, reCheckFun, reErrorCheckFun);
		}
		/**
		 * 服务器消息返回，静态统一处理分发
		 * @param	_dataObj
		 */
		private static function reCheckFun(_dataObj:Object):void {
			$systemTimeDate = _dataObj[SERVER_NOW] as Date;
			var _method:String = String(_dataObj[METHOD]);
			var _actionID:String = _dataObj[PARAMS][ACTIONID];//返回数据绑定id
			var _error:int = int(_dataObj[RETURN_CODE]);		
			var _time:Number = $systemTimeDate.getTime() * 0.001;//当前系统时间
			if ($serviceData[_actionID] != null && $serviceData[_actionID] != undefined){
				//trace("\n===============================================");
				//trace("【"+_method+"】返回毫秒："+((new Date()).time - ($serviceData[_actionID][SEND_TIME] as Date).time));
				//trace("===============================================");
			}
			
			setSystem(_time);//模拟计算服务器时间
			
			//-------------------------------判断 返回处理函数
			if ($serviceData[_actionID] != null && $serviceData[_actionID] != undefined && _error == 0){
				//-------------------------------------------回调函数
				if ($serviceData[_actionID][RE_FUNCTION] is Function) {
					if ($serviceData[_actionID][RE_FUNCTION] != null) {
						($serviceData[_actionID][RE_FUNCTION] as Function).apply(null, [_dataObj]);
					}
				}
				//-------------------------------------------广播返回值
				var _event:NetEvent = new NetEvent(NetEvent.NET_BROADCAST_ALL);
				_event.contentObj = _dataObj;
				$SendServiceAMFDispatcher.dispatchEvent(_event);	
			}
			else {
				var _event_error:NetEvent = new NetEvent(NetEvent.ERROR_BROADCAST);
				_event_error.contentObj = _dataObj;
				$SendServiceAMFDispatcher.dispatchEvent(_event_error);
			}
			delete $serviceData[_actionID];//清理销毁 以处理 返回
		}
		public static function reErrorCheckFun(_dataObj:Object):void {
			//trace('------服务器错误消息----')
			throw new Error(_dataObj);
		}
		/**
		 * 模拟 服务器当前时间
		 * @param	_time
		 */
		public static function setSystem(_time:Number):void {	
			$systemTimer_nowSecond = _time;
			if ($systemTimer == null) {				
				$systemTimer = new Timer(1000, 0);
				$systemTimer.addEventListener(TimerEvent.TIMER, onSystemTimer);
				$systemTimer.start();
			}
		}
		public static function onSystemTimer(e:TimerEvent):void {
			$systemTimer_nowSecond += 1;
		}
		
	}

}