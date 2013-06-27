package core.meditor
{
	import core.ModelBase;
	import core.observer.IObserver;
	import core.observer.IObservers;
	import core.observer.ObserverManager;
	
	public class Meditors extends MeditorBase implements IObservers
	{
		protected var _model : ModelBase;
		protected var _models:Array
		
		public function Meditors(models:Array)
		{
			super();
			initModels(models);
			ObserverManager.addObservers(this);
		}
		
		protected function initModels(models:Array):void
		{
			_models = models;
		}
		
		public function update(data:Object):void
		{
			trace(data);
		}
		
		public function get obsIDs():Array
		{
			var lis:Array = [];
			for each( var i:ModelBase in _models)
			{
				lis.push(i.uid);
			}
			return lis;
		}
		
		public function get obsNames():Array
		{
			var lis:Array = [];
			for each( var i:ModelBase in _models)
			{
				lis.push(this._mid + '_' + i.uid);
			}
			return lis;
		}
		
		override public function clear():void
		{
			ObserverManager.removeObservers(this);
			
			super.clear();
			
			
			
			_model = null;
		}
	}
}