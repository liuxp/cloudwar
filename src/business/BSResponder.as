
package business
{
	import core.meditor.MeditorBase;
	
	import manager.ModelLocator;
	
	
	public class BSResponder extends MeditorBase
	{
		public var params : Object;
		protected var _ML:ModelLocator = ModelLocator.getInstance();
		
		public function BSResponder()
		{
		}
		
		public function onResult(value:Object):void
		{ 
		}
		
		public function onFault(value:Object):void
		{	
		}
	}
}