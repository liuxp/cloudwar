package business.rmt
{
	import business.BSResponder;
	
	import events.MeditorEvent;

	import model.vo.UserVO;
	
	import utils.ObjToModelUtil;
	
	internal class RmtGetUser extends BSResponder
	{
		public function RmtGetUser()
		{
			super();
		}  
		
		override public function onFault(e:Object):void
		{
			
		}
		
		override public function onResult(e:Object):void
		{ 
			var data : Object = e.data;
			var vo:UserVO = ObjToModelUtil.ObjToUser(data);
			_ML.user.setVO(vo);
			
		 
		}
	}
}