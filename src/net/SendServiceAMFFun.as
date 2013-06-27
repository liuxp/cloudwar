package net 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * 与sever交互，向后端发送数据、请求等。
	 * @author Elvis
	 */
	public class SendServiceAMFFun extends EventDispatcher
	{	
		//-------------------------------------------------
		//--------------------功能ID
		//-------------------------------------------------
		public static const ID_ADMIN:String = 'adminID';
		public static var $adminID:String = '';
		public static var $sessionid:String = '';
		public static const ACTION_001:String = 'sys.get_config';
		public static const ACTION_0000:String = 'user.regist';
		public static const ACTION_0001:String = 'user.login';
		public static const ACTION_0002:String = 'user.get';
		public static const ACTION_0003:String = 'user.get_friends';
		public static const ACTION_0004:String = 'user.add_friend';
		public static const ACTION_0005:String = 'user.get_umap';
		public static const ACTION_0006:String = 'user.del_friend';
		public static const ACTION_0007:String = 'user.get_msg';
		public static const ACTION_0008:String = 'user.choose_country';
		public static const ACTION_0009:String = 'user.set_fix_hids';
		public static const ACTION_0010:String = 'user.pk_done';
		public static const ACTION_0011:String = 'user.upgrade_stuff';
		public static const ACTION_0012:String = 'user.online_user';
		public static const ACTION_0013:String = 'user.send_msg';
		public static const ACTION_0014:String = 'user.friend_aid';
		public static const ACTION_0015:String = 'user.friend_unaid';
		
		
		public function SendServiceAMFFun(_target:IEventDispatcher = null) {
			super(_target);
		}
		//-------------------------------------------------
		//--------------------功能 信息处理 方法
		//-------------------------------------------------
		/**
		 * 每个 消息 都要建立消息 函数 
		 */
		public static function sendService(_action:String, _send_data:Object = null, _reFun:Function = null,_actionID:String = ''):void {
//			SendAndSelect.sendAndSelectService(_action, _send_data, _reFun,null,_actionID);
		}
		public static function sendService_regist(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0000, _send_data, _reFun);
		}	
		public static function sendService_login(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0001, _send_data, _reFun);
		}
		public static function sendService_get(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0002, _send_data, _reFun);
		}		
		public static function sendService_get_friends(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0003, _send_data, _reFun);
		}
		public static function sendService_add_friend(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0004, _send_data, _reFun);
		}		
		public static function sendService_get_umap(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0005, _send_data, _reFun);
		}		
		public static function sendService_del_friend(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0006, _send_data, _reFun);
		}		
		public static function sendService_get_msg(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0007, _send_data, _reFun);
		}
		public static function sendService_choose_country(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0008, _send_data, _reFun);
		}
		public static function sendService_set_fix_hids(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0009, _send_data, _reFun);
		}		
		public static function sendService_pk_done(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0010, _send_data, _reFun);
		}
		public static function sendService_upgrade_stuff(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0011, _send_data, _reFun);
		}		
		public static function sendService_online_user(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0012, _send_data, _reFun);
		}
		public static function sendService_send_msg(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0013, _send_data, _reFun);
		}	
		public static function sendService_friend_aid(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0014, _send_data, _reFun);
		}
		public static function sendService_friend_unaid(_reFun:Function = null, _send_data:Object = null):void {
			SendAndSelect.sendAndSelectService(ACTION_0015, _send_data, _reFun);
		}		
	}
}