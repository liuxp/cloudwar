package core.view
{
	import core.ModelBase;
	import core.meditor.MeditorBase;
	
	import flash.events.Event;
	
	import manager.MeditorManager;
	import manager.UIManager;
	
	
	/**视觉控制器基类
	 * leo*/
	public class ViewMeditorBase extends MeditorBase
	{
		
		protected var _uid : String;
		
		public function ViewMeditorBase(viewUI:ViewBase, model:ModelBase=null)
		{
			super();
			_uid = viewUI.uid;
//			MeditorManager.addMeditor(this);
			if(!viewUI.parent)
			{
				viewUI.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			}else{
				init();
			}
			
			
			viewUI = null;
		}
		
		private function addToStageHandler(e:Event):void
		{
			var viewUI : ViewBase = e.target as ViewBase;
			viewUI.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			viewUI = null;
			init();
		}
		 
		protected function init():void
		{
			addListenerCfg();
		}
		
		/* 增加监听器 */
		protected function addListenerCfg():void
		{
			 
		}

		/* 取消监听器 */
		protected function removeListenerCfg():void
		{
			
		}
		/* 关闭界面*/
		protected function close():void
		{
			removeListenerCfg();
			
			
		}
		
		override public function clear():void
		{
			close();
//			MeditorManager.removeMeditor(this);
			_uid = null;
			super.clear();
			
		}
		
	}
}