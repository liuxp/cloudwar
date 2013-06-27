package net 
{
	import com.adobe.serialization.json.JSON;
	import com.kingdowin.events.NetEvent;
	import com.kingdowin.game.events.MainEvent;
	import com.kingdowin.game.global.GlobalData;
	import com.kingdowin.global.GlobalStaticConst;
	import com.kingdowin.global.InterfaceFun;
	import com.kingdowin.main.Main;
	import com.qq.openapi.MttService;
	
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author Elvis liuhaitao
	 */
	public class SendPost extends SendAndSelect
	{
		
		public static var $ServiceAMFDispatcher:EventDispatcher = new EventDispatcher();
        private static var $analyticsRuler:Number = 0;
        private static var $analyticsRecord:Number = 0;
        private static var $analyticsFirst:Number = 0;
        private static const analyticsTimes:int = 1800000;
        private static const analyticsTimes_v:int = 60000;
		public function SendPost() 
		{
			super();
		}
        private static function formatObjToStr(_method:String,_obj:Object):String{
            var _str:String = ''
            for(var i:String in _obj){
                _str += '&'+i+'='+_obj[i];
            }
            _str = 'method='+_method+_str
            return _str;
        }
		public static function sendAndSelectService(_method:String, _send_data:Object = null, _reFun:Function = null, _isListenerFun:Function = null, _actionId:String = ''):void {
            var _data:Object = _send_data == null? { } :_send_data;
			var _obj:Object = {};
            //-----------------------建立 消息 ID 
			if(_actionId == '')
			{
				_data[ACTIONID] = ACTIONID_a + (new Date()).getTime().toString() + Math.floor(Math.random() * RANDOM_NUM).toString();
				_obj[RECONNECTION] = 0;		//该消息首次被发出
			}
			else
			{
				_data[ACTIONID] == _actionId;
				_obj[RECONNECTION] = $serviceData[_actionId][RECONNECTION] +1;		//该消息被重发的次数
			}
			_data[METHOD] = _method;
            _data[SESSIONID] = SendServiceAMFFun.$sessionid;	//发出的方法，方便查重
            var _getTimer:Number = $systemTimer_nowSecond*1000;
            $analyticsRuler =_getTimer - _getTimer%analyticsTimes+analyticsTimes+analyticsTimes_v;  
            var _a:Number = $analyticsRuler;
            var _b:Number = $analyticsRecord;
            if($analyticsRuler != $analyticsRecord){//统计 间隔计时
                $analyticsRecord = $analyticsRuler;
                _data['analytics'] = 1;	//发出的方法，方便查重
            }
            _data[SendServiceAMFFun.ID_ADMIN] = SendServiceAMFFun.$adminID;
            //-----------------------建立消息功能组

            _obj[RE_FUNCTION] = _reFun;		//返回数据后执行的方法
            _obj[SEND_METHOD] = _method;	//发出的方法，方便查重
            _obj[PARAMS] = _data;			//
            //-----------------------
            $serviceData[_data[ACTIONID]] = _obj;//消息功能组存储，队列字典	
			
			//引导状态，假发送
//			if(GlobalData.$isGuide &&
//				_method != SendServiceAMFFun.ACTION_00020)
//			{	
//				//广播引导事件
//				var _event:MainEvent = new MainEvent(MainEvent.GUIDE_CALL);
//				//引导假消息标记
//				_data[GUIDE_SIGN] = GUIDE_SIGN;
//				//引导假发送的消息
//				_event.content = {fun:_reFun,method:_method, params:_data};
//				$SendServiceAMFDispatcher.dispatchEvent(_event);	
//				return;
//				//				_reFun(GuideCall.getReturnData({method:_method, params:_data}));
//			}

            //-----------------------//存放广播侦听 器收听 Fun

//			trace("发出:"+_method+" 【Id】"+_actionId);
            if (_isListenerFun!=null){
                $SendServiceAMFDispatcher.addEventListener(NetEvent.NET_BROADCAST_ALL, _isListenerFun, false, 0, true);
            }		
			//数据 字节格式化
			var _d:ByteArray = new ByteArray();
			var _jsonStr:String = 'json_params='+JSON.encode(_data);
//			trace(_jsonStr);
            _d.writeUTFBytes(_jsonStr);
//			_d.position = 0;
//			trace(_d.readUTFBytes(_d.length));
			//消息已发出,告知UI
			var _serviceSend:NetEvent = new NetEvent(NetEvent.SERVICE_SEND);
			_serviceSend.data = _obj;
			$ServiceAMFDispatcher.dispatchEvent(_serviceSend);	
			//是否 是 QQ浏览器
            if(GlobalStaticConst.$isQQ){
                InterfaceFun.qqMttService_post(_d,rePostFun);
            }
            else{
                InterfaceFun.qqMttService_send(GlobalStaticConst.$baseURL, GlobalStaticConst.QQ_APP_ID, _d, rePostFun);
            }
		}		
		public static function getPARAMS(_actionID:String):Object {
//			var _o:* = $serviceData;
			return $serviceData[_actionID][PARAMS];
		}
		public static function clearService():void {
			for (var i:Object in $serviceData) {
				delete $serviceData[i];
			}
			$serviceData = null;
			$serviceData = new Dictionary();
		}
        private static function rePostFun(_code:int,_data:ByteArray):void {
//			TestStage.addTrace("返回"+_code);
			if (_code == 0) {//正确数据
                if (_data == null || _data.length <= 0) return;
				
//                Main.traceTest('');
//                Main.traceTest('当前手机操作系统--:'+flash.system.Capabilities.os);   
				
                if(GlobalStaticConst.$isQQ){
                    _data.uncompress();
                }
                //Main.traceTest('json数据返回解压缩数据:'+_data.length);
                var _str:String = _data.readUTFBytes(_data.length);
                //Main.traceTest('json数据返回数据:'+_str);
//                Main.$stage.addChild(Main.$textParent);
				var _dataObj:Object = JSON.decode(_str) as Object;
                //Main.traceTest('json数据返回##############:');
				var _method:String = String(_dataObj[METHOD]);
				var _actionId:String = _dataObj[ACTIONID];//返回数据绑定id
				var _error:int = int(_dataObj[RETURN_CODE]);			
                $ServiceAMFDispatcher.dispatchEvent(new NetEvent(NetEvent.SERVICE_RE));
				//模拟未收到消息，重发消息
				if(_method != 'user.login' && _method != 'sys.get_config' && $serviceData[_actionId][RECONNECTION] < 0)
				{
//					$serviceData[_actionId][PARAMS]
//					trace("重发:"+_method +" 【Id】"+_actionId);
					sendAndSelectService(_method, $serviceData[_actionId][PARAMS], $serviceData[_actionId][RE_FUNCTION], null, _actionId);
					return;
				}
//				trace("收到:"+_method+" 【Id】"+_actionId);
//				TestStage.addTrace(_method +"重发"+$serviceData[_actionId][RECONNECTION]+"次后成功！");
				GlobalData.$waitingTimeOut_times = 0;
				
				$systemTimeDate = new Date();
				$systemTimeDate.setTime(_dataObj[SERVER_NOW][SERVER_NOW_TIMER]);
				var _getTimer:Number = $systemTimeDate.getTime();
				if($analyticsFirst == 0){
					$analyticsRuler =_getTimer - _getTimer%analyticsTimes+analyticsTimes+analyticsTimes_v;
					$analyticsRecord = $analyticsRuler;
					$analyticsFirst = 1;
				}
				var _time:Number = _getTimer * 0.001;//当前系统时间		
				setSystem(_time);//模拟计算服务器时间
				
				//-------------------------------判断 返回处理函数
				if ($serviceData[_actionId] != null && $serviceData[_actionId] != undefined && _error == 0){
					//-------------------------------------------回调函数
					if ($serviceData[_actionId][RE_FUNCTION] != null) {
						if ($serviceData[_actionId][RE_FUNCTION] is Function) {
							($serviceData[_actionId][RE_FUNCTION] as Function).call(null,_dataObj);
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
                    $ServiceAMFDispatcher.dispatchEvent(_event_error);
				}				
			}
			else {//错误数据 QQ 服务器错误
//				$ServiceAMFDispatcher.dispatchEvent(new NetEvent(NetEvent.SERVICE_RE));
				if(_code == (MttService.EIOERROR || MttService.EIOTIMEOUT)){
					var _netError:NetEvent = new NetEvent(NetEvent.NET_STATUS_ERROR);
					$ServiceAMFDispatcher.dispatchEvent(_netError);					
				}
//				var _NET_STATUS_ERROR:NetEvent = new NetEvent(NetEvent.NET_STATUS_ERROR);
//				$ServiceAMFDispatcher.dispatchEvent(_NET_STATUS_ERROR);			
			}
			
			delete $serviceData[_actionId];//清理销毁 以处理 返回			
		}
	}

}