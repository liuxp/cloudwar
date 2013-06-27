package core.view
{
	import core.ModelBase;
	import core.meditor.Meditors;
	
	import flash.events.Event;
	
	import manager.MaterialManager;
	import manager.MeditorManager;
	import manager.ModelLocator;

	/**
	 * 可绑定数据的视觉控制器基类
	 * */
	public class ViewWatchersMeditorBase extends Meditors
	{
		protected var _ML :ModelLocator = ModelLocator.getInstance();
		protected var _MM :MaterialManager = MaterialManager.getInstance();
		
		public function ViewWatchersMeditorBase(viewUI:ViewBase, models:Array)
		{
			super(models);
			
			if(!viewUI.parent)
			{
				viewUI.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			}else{
				init();
			}
			
			viewUI = null;
		}
		public function get view():ViewBase
		{
			return null;
		}
		
		public function get model():ModelBase
		{
			return _model;
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
			
			_ML = null;
			_MM = null;
			super.clear();
		}
		
	}
}