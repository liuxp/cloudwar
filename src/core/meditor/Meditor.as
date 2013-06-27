package core.meditor
{
	import core.ModelBase;
	import core.observer.IObserver;
	import core.observer.ObserverManager;

	public class Meditor extends MeditorBase implements IObserver
	{
		protected var _model : ModelBase;
		
		public function Meditor(model:ModelBase)
		{
			super();
			
			_model = model;
			
			ObserverManager.addObserver(this);
		}
		
		public function update(data:Object):void
		{
		}
		
		public function get obsID():String
		{
			return _model.uid;
		}
		
		public function get obsName():String
		{
			return this._mid;
		}
		
		override public function clear():void
		{
			ObserverManager.removeObserver(this);
			
			super.clear();
			
			
			
			_model = null;
		}
	}
}