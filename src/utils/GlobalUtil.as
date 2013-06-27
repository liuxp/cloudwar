package utils
{
	import control.view.bullet.BombMeditor;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class GlobalUtil
	{
		public static const BAN_LIST:Array = [';','&','>','<'];		
		public function GlobalUtil(singleTon:SingleTon)
		{
		}
		/**
		 *移除容器内所有子对象 
		 * @param container
		 * 
		 */		
		public static function removeAllChild(container:DisplayObjectContainer):void
		{
			if(!container || container.numChildren<1) return;
			while(container.numChildren>0) container.removeChildAt(0);
		}
		/**
		 *得到居中坐标 
		 * @param container
		 * @param child
		 * @return 
		 * 
		 */		
		public static function getCenterPoint(container:DisplayObjectContainer, child:DisplayObject):Point
		{
				var x:int = (container.width - child.width) >>1 ;
				var y:int = (container.height - child.height)>>1;
				return new Point(x , y);
		}
		/**
		 *居中显示 
		 * @param container
		 * @param child
		 * 
		 */		
		public static function setCenterPos(container:DisplayObjectContainer, child:DisplayObject):void
		{
			child.x = (container.width - child.width) >>1 ;
			child.y = (container.height - child.height)>>1;
		}
		/**
		 *随机区间取数值 
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */		
		public static function getRandomIndex(min:int, max:int):int
		{
			return Math.floor(Math.random()*max) + min;
		}
		/**
		 *得到2个坐标点的距离 
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return 
		 * 
		 */		
		public static function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			/*var dx:Number = Math.abs(x1) - Math.abs(x2);
			var dy:Number = Math.abs(y1) - Math.abs(y2);
			
			return Math.sqrt(dx*dx + dy*dy);*/
			var point:Point = new Point(x1-x2, y1-y2);
			return point.length;
		}
		/**
		 * 垃圾回收
		 * */
		public static function GC():void
		{
			try{
				var lc1 : LocalConnection = new LocalConnection;
				var lc2 : LocalConnection = new LocalConnection;
				lc1.connect('aaa');
				lc2.connect('aaa');
			}catch(e:Error){
				trace('gc')
			}
		}
		
		/**
		 * 所有子MC播放or停止
		 */
		public static function stopAllMc(_con : DisplayObject, _isPlay:Boolean = false):void
		{
			var child:DisplayObject;
			if (! _isPlay)
			{
				if (_con is DisplayObjectContainer)
				{
					var con:DisplayObjectContainer = _con as DisplayObjectContainer;
				
					var i:int = con.numChildren;
					if (con is MovieClip)
					{
						var m:MovieClip = con as MovieClip;
						m.stop();
						//						trace(m.name,"stop");
					}
					while ((i--)>0)
					{
						child = con.getChildAt(i);
						stopAllMc(child,_isPlay);
					}
				}
			}
			else
			{
				if (_con is DisplayObjectContainer)
				{
					var con1:DisplayObjectContainer = _con as DisplayObjectContainer;
					var j:int = con1.numChildren;
					if (con1 is MovieClip)
					{
						var m1:MovieClip = con1 as MovieClip;
						m1.play();
						//						trace(m1.name,"play");
					}
					while ((j--)>0)
					{
						child = con1.getChildAt(j);
						stopAllMc(child,_isPlay);
					}
				}
			}
		} 
		/**
		 *容器子对象的深度排序 
		 * @param container
		 * 
		 */		
		public static function SortContainerChildren(container:DisplayObjectContainer):void
		{
			
			var total : uint = container.numChildren-1;
			var num:int = total;
			
			var sort_arr : Array = [];
			while(num > -1)
			{
				var itm : DisplayObject = container.getChildAt(num);
				var sortItms : Object = {};
				sortItms.index = itm.y;
				sortItms.itm = itm;
				sort_arr.push(sortItms);
				num--;
			}
			
			sort_arr.sortOn('index', Array.NUMERIC);
			
			while(num <= total)
			{
				num++;
				var sortItm : Object = sort_arr[num];
				if(!sortItm) continue;
				itm = sortItm.itm;
				container.setChildIndex(itm, num);
				
			}
		}
		/**
		 * 
		 * @param parent
		 * @param mouseChildren
		 * @param mouseEnabled
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		public static function createContainer( parent:DisplayObjectContainer,
												mouseChildren:Boolean=true,
												mouseEnabled:Boolean=true, 
												x:int=0, y:int=0):Sprite
		{
			var spr:Sprite = new Sprite();
			parent.addChild(spr);
			spr.mouseChildren = mouseChildren;
			spr.mouseEnabled = mouseEnabled;
			spr.x = x;
			spr.y = y;
			
			return spr;
		}
		
		public static function createChildDisObj(parent:DisplayObjectContainer,
												 childClass:Class,
												 x:int=0, y:int=0):DisplayObject
		{
			var child:DisplayObject = new childClass();
			parent.addChild(child);
			child.x = x;
			child.y = y;
			return child;
		}
		
		public static function setChildrenAttrs(parent:Sprite, params:Object):void
		{
			var index:int = parent.numChildren-1;
			while(index >-1)
			{
				var child:DisplayObject = parent.getChildAt(index);
				for(var key:String in params)
				{
					if(child.hasOwnProperty(key))
					{
						child[key] = params[key];
					}
				}
				
				index--;
			}
		}
		
		/**
		 * 清理事件
		 * @param	_obj
		 * @param	_event
		 * @param	_fun
		 */
        public static function deleteEventFun(_obj:Object,_event:String,_fun:Function):void {
            if (_obj != null) {
                if((_obj as EventDispatcher).hasEventListener(_event)){
                    (_obj as EventDispatcher).removeEventListener(_event, _fun);
                }
                if (_obj is Timer) {
                    (_obj as Timer).stop();
                    _obj = null;
                }
            }
        }		
		/**
		 * 清理Bitmap
		 * @param	_bitmap
		 */
		public static function clearBitmap(_bitmap:Bitmap):void {
			if (_bitmap) {
				if (_bitmap.bitmapData) {
					_bitmap.bitmapData.dispose();
				}
				_bitmap = null;
			}
		}
		/**
		 * 清除 从父层显示对象删除自己
		 * @param	_dis
		 */
		public static function removeDisplaySelf(_dis:DisplayObject):void {
			if (_dis && _dis.parent) {
				if (_dis.parent.contains(_dis)) {
					_dis.parent.removeChild(_dis);
				}
			}
		}
		/**
		 * 獲得 Object 屬性 個數
		 * @param	_obj
		 * @return
		 */
		public static function getObjNum(_obj:Object):uint {
			var _num:uint = 0;
			var i:Object;
			if(_obj){
				for (i in _obj) {
					_num++;
				}
			}
			return _num;
		}
		/**
		 * 給 顯示對象 裡的 文本對象 賦值
		 * @param	_mc
		 * @param	_txtName
		 * @param	_str
		 */
		public static function setTxt(_mc:DisplayObjectContainer, _txtName:String, _str:*):void {
			if (_mc) {
				if (_mc.getChildByName(_txtName)) {
					var _txt:TextField = _mc.getChildByName(_txtName) as TextField;
					_txt.text = String(_str);
				}
			}
		}
		/**
		 * 颜色 变化
		 * @param	_mc
		 * @param	_default
		 */
		public static function colorChange(_mc:DisplayObject,_default:Boolean = false):void {
            if (_mc != null) {
				if (_default) {
					_mc.transform.colorTransform = new ColorTransform();
				}
				else {
					_mc.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -128, -128, -128, -128);
				}
            }
		}	
		/**
		 * 设置 显示对象 子 mouseEnabled 状态
		 * @param	_mc
		 * @param	_b
		 * @param	_exception
		 */
		public static function setMcChildrenEnable(_mc:DisplayObjectContainer, _b:Boolean, _exception:String = ''):void {
			var _dis:DisplayObject
			for (var i:uint = 0; i < _mc.numChildren; i++) {
				_dis = _mc.getChildAt(i)
				if (_dis.hasOwnProperty('mouseEnabled')) {
					if (_exception != '' && _dis.name == _exception) {
						continue;
					}
					(_dis as InteractiveObject).mouseEnabled = _b;
				}
			}
		}
		/**
		 * 元件 不可编辑，灰度
		 * @param	_mc
		 * @param	_b
		 */
		public static function enableDisplay(_mc:*, _b:Boolean = false,_isFilters:Boolean = false):void {
			if (!_b) {
				var _color:ColorMatrixFilter = new ColorMatrixFilter();
				var _colorMatrix:ColorMatrix = new ColorMatrix();
				_colorMatrix.adjustSaturation(-100);
				_color.matrix = _colorMatrix;
				if ((_mc as Object).hasOwnProperty('filters')) {
					_mc.filters = null;
					_mc.filters = [_color];
				}
				if (!_isFilters && (_mc as Object).hasOwnProperty('mouseEnabled')) {
					//if(_mc.mouseEnabled == true){
						//(_mc as DisplayObject).dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
					//}
					_mc.mouseEnabled = false;
				}
				//if ((_mc as Object).hasOwnProperty('mouseChildren')) {
					//_mc.mouseChildren = false;
				//}
			}
			else{				
				if ((_mc as Object).hasOwnProperty('filters')) {
					_mc.filters = null;
				}
				if (!_isFilters && (_mc as Object).hasOwnProperty('mouseEnabled')) {
					//if(_mc.mouseEnabled == false){
						//(_mc as DisplayObject).dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
					//}
					_mc.mouseEnabled = true;
				}
				//if ((_mc as Object).hasOwnProperty('mouseChildren')) {
					//_mc.mouseChildren = true;
				//}				
			}	

		}
		
		/**
		 *耗时测试 
		 * @param counts
		 * @param fun
		 * @param params
		 * @return 
		 * 
		 */		
		public static function TimeConsumeTest(counts:int, fun:Function, params:Array):void
		{
			var time:Number = flash.utils.getTimer();
			
			
			for(var i:int; i<counts; i++)
			{
				fun.apply(null, params);
			}
			
			trace('耗时：', flash.utils.getTimer() - time);
		}
		
		
		
		/**
		 * 判断字符串是否包含列表中的字符串
		 */		
		public static function hasText(_str:String,_checkList:Array = null):Boolean 
		{
			var i:int;
			if(_checkList == null)_checkList = BAN_LIST;
			for(i=0;i<_checkList.length;i++)
			{
				if(_str.indexOf(_checkList[i]) != -1)return true;
			}
			return false;
		}		
		/**
		 * 随机 打乱数组
		 * @param	_sArr
		 * @return
		 */
		public static function randomArray(_sArr:Array):Array {
			_sArr.sort(function():Number { return Math.random() > 0.5? -1:1; } );
			return _sArr;
			
		}
		/**
		 *深复制 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function clone(obj:Object):Object
		{
			var by:ByteArray = new ByteArray();
			by.writeObject(obj);
			by.position = 0;
			return by.readObject();
		}
	}
	
	
}

class SingleTon {}