package component
{ 
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Pool 
	{ 
		public  var MAX_VALUE:uint; 
		public  var GROWTH_VALUE:uint; 
		public  var counter:uint; 
		public  var pool:Array;
		public  var currentSprite:DisplayObject; 
		public  var _classObj:Class;
		
		public function Pool( classObj:Class, maxPoolSize:uint, growthValue:uint=1 ):void 
		{ 
			MAX_VALUE = maxPoolSize; 
			GROWTH_VALUE = growthValue; 
			counter = maxPoolSize; 
			_classObj = classObj;
			
			var i:uint = maxPoolSize; 
			
			pool = new Array(MAX_VALUE); 
			while( --i > -1 ) 
				pool[i] = new classObj(); 
		} 
		
		public function getItem():Object 
		{ 
			if ( counter > 0 ) 
				return currentSprite = pool[--counter]; 
			if(MAX_VALUE > 0) return null;
			var i:uint = GROWTH_VALUE; 
			while( --i > -1 ) 
				pool.unshift ( new _classObj() ); 
			counter = GROWTH_VALUE; 
			return getItem(); 
			
		} 
		
		public function returnItem(itm:Object):void 
		{ 
			pool[counter++] = itm; 
		} 
	} 
}