package manager
{
	import component.Dict;
	
	import core.meditor.MeditorBase;
	import core.view.ViewMeditorBase;
	
	import flash.utils.Dictionary;
	 
	
	public class MeditorManager
	{
		private static var _dict : Dictionary = new Dictionary(true);
		
		public function MeditorManager()
		{
			
			throw Error('can not instantiate!')
			
		}
		
		public static function addMeditor(id:String, meditor:MeditorBase):void
		{
			 if(!_dict[id]) _dict[id] = meditor;
		}
		
		public static function getMeditor(id:String):MeditorBase
		{
			if(isHaveMeditor(id)) return _dict[id];
			return null;
		}
		public static function isHaveMeditor(id:String):Boolean
		{
			return _dict[id] != null;
		}
		
		public static function removeMeditor(id:String):void
		{
			_dict[id] = null;
			delete _dict[id];
			
		}
		
	}
}

