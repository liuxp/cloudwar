
package control.view.sheet
{
	import component.Dict;
	import component.TimeLoop;
	import component.load.XMLEditor;
	
	import core.ModelBase;
	import core.view.ViewBase;
	import core.view.ViewWatcherMeditorBase;
	
	import events.MeditorEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import manager.MaterialManager;
	import manager.TimeLoopManager;
	
	import model.config.ArmyConfig;
	import model.vo.CharacterVO;
	import model.vo.SheetVO;
	
	import utils.GameUtil;
	import utils.MatrixUtil;
	
	import view.character.CharacterBase;
	import view.character.ICharacter;

	/**
	 *位图序列播放控制器 
	 * @author leo
	 * 
	 */	
	public class SheetRender  
	{
		
		private var _vo:SheetVO;
		private var _infoDict:Dict; //序列xml
		private var _bitDict:Dict;//序列图表
		private var _srcBit:BitmapData;//原位图
		private var _srcBitDict:Dict;
		private var _coordDict:Dict;
		public var running:Boolean;//是否渲染
		private var _bitLis:Vector.<BitmapData>;//位图序列
		private var _MM:MaterialManager = MaterialManager.getInstance();
		private var _type:String; //位图类型
		public var coords:Array;
		public var bitW:int;
		public var bitH:int;
		private var _sheetState :String;//动画状态
		private var _isCharacter :Boolean;
		private var _isLock:Boolean;//素材查找切换
		
		private var _followFun:Function;
		private var _followFunParams:Array;
		private var _followFrame:uint;
		
		public function SheetRender(vo:SheetVO, type:String)
		{
			
			_vo = vo;
			_type = type;
			_infoDict = new Dict();
			_bitDict = new Dict();
			_srcBitDict = new Dict();
			_coordDict = new Dict();
			
			/*_srcBit = _MM.getSheetMaterial(type);
			coords = getCoords();*/
		}
 		
		private function getCoords(type:String):Array
		{
			var arr:Array ;
			if(!this._coordDict.isHaveItem(type))
			{
				var xmls:Vector.<XML> = this._isCharacter || this._isLock
										? _MM.getCharacterSheetXML(type, 'xy')
										: _MM.getSheetMaterialInfos(type, 'xy');
				if(xmls && xmls.length)
				{
					var xml:XML = xmls[0];
					var x:int =  xml.@frameX;
					var y:int =  xml.@frameY;
					arr = [x * _vo.scale , y * _vo.scale];
					
					this._coordDict.AddItem(type, arr);
				}else{
					return null;
				}
			}

			return this._coordDict.getItem(type);
		}
		/**
		 *得到位图序列xml配置 
		 * @param name
		 * @return 
		 * 
		 */		
		private function getInfos(name:String):Vector.<XML>
		{
			if(!this._infoDict.isHaveItem(name))
			{
				var type:String = this._isCharacter ? _type + '_' + _vo.state
													: _vo.state;
				
				var infos:Vector.<XML> = this._isCharacter || this._isLock
											? _MM.getCharacterSheetXML(type, name)
											: _MM.getSheetMaterialInfos(type, name);
				if(infos) _infoDict.AddItem(name, infos);
				else return null;
			}
			
			return _infoDict.getItem(name);
		}
		/**
		 *更改位图序列列表 
		 * @param state
		 * 
		 */		
		public function chageState(state:String, isCharacter:Boolean=false, isLock:Boolean=false):void
		{
			
			if(state == _vo.state && _vo.assets || !state) return;
			
			_isCharacter = isCharacter;
			_isLock = isLock;
			_sheetState = _isCharacter ? _type + '_' + state : state;
			//得到位图源
			if(!this._srcBitDict.isHaveItem(_sheetState))
			{
				var srcBit:BitmapData = _isCharacter || isLock 
										? _MM.getCharacterSheetMaterial(_sheetState)
										: _MM.getSheetMaterial(_sheetState);
				
				this._srcBitDict.AddItem(_sheetState, srcBit);
				this._srcBit = srcBit;
				
			}else{
				
				this._srcBit = this._srcBitDict.getItem(_sheetState);
			}
			//得到锚点
			this.coords = this.getCoords(_sheetState);
			this._srcBit.lock();
			_vo.state = state;
			_vo.assets = this.getInfos(_vo.state);
			if(_vo.assets) _vo.toalFrame = _vo.assets.length;
			_vo.frame = -1;
			
			if(!_bitDict.isHaveItem(state))
			{
				_bitDict.AddItem(state, new Vector.<BitmapData>(_vo.toalFrame));
			}
			_bitLis = _bitDict.getItem(state);
		}
 		
		public function setFollowFun(frame:int, fun:Function, funParams:Array):void
		{
			this._followFrame = frame;
			this._followFun = fun;
			this._followFunParams = funParams;
		}
		//是否渲染到最后一帧
		public function isEnd():Boolean
		{
			return _vo.frame >= _vo.toalFrame-1
		}
		
		public function reset():void
		{
			_vo.frame = -1;
			
		}
		
		public function reverse():void
		{
			this._bitLis = this._bitLis.reverse();
		}
		//渲染
		public function render():BitmapData
		{
			if(!_srcBit) return null;
			
			if(running)
			{
				_vo.frame++;
				if(this._followFun!=null && this._followFrame == _vo.frame)
				{
					this._followFun.apply(null, this._followFunParams);
					this._followFun = null;
					this._followFunParams = null;
					
				}
			}
			
			if(_vo.frame <0 || _vo.frame >= _vo.toalFrame) return null;
			
			if(!_bitLis[_vo.frame])
			{
				var xml:XML = _vo.assets[_vo.frame];
				var w:uint = xml.@width;
				var h:uint = xml.@height;
				var x:uint = xml.@x;
				var y:uint = xml.@y;
				var _frameX:int = xml.@frameX;
				var _frameY:int = xml.@frameY;
				var _frameW:uint = xml.@frameWidth;
				var _frameH:uint = xml.@frameHeight;
				//校验frame宽高
				if(_frameW == 0) _frameW = w;
				if(_frameH == 0) _frameH = h;
				
				this.bitW = w;
				this.bitH = h;
				var _bit:BitmapData = new BitmapData(w,h,true, 0x00000000);
				_bit.copyPixels(this._srcBit, new Rectangle(x,y,w,h), new Point(0,0));
				_bit.lock();
				var tmpBit:BitmapData = new BitmapData(_frameW,_frameH,true, 0x00000000);
				var mix:Matrix = new Matrix(1,0,0,1, -_frameX, -_frameY);
				
				tmpBit.draw(_bit, mix);
				_bit.dispose();
				/*var srcBit:BitmapData = MatrixUtil.ScaleBitmapdata(
					tmpBit, tmpBit.width * _vo.scale, tmpBit.height * _vo.scale);*/
				_bitLis[_vo.frame] = tmpBit;
			}
			
			//trace(this._type , '__state:', _vo.state, '—————————————— 帧数：', _vo.frame);
			
			return _bitLis[_vo.frame];
		}
		
		
		private function removeBitDict():void
		{
			var dict:Dictionary = _bitDict.dict
			for each(var v:Vector.<BitmapData> in dict)
			{
				for each(var i:BitmapData in v)
				{
					if(i) i.dispose();
				}
			}
			
			this._bitDict.DeleteAllItms();
			
		}
		
		public function clear():void
		{
			
			
			_vo = null;
			_MM = null;
			
			_infoDict.DeleteAllItms();
			_infoDict = null;
			
			
			_srcBit = null;
 
			
			_bitLis.splice(0, _bitLis.length);
			this._bitLis = null;
			
			removeBitDict();
			this._bitDict = null;
			
			this.coords = null;
			
		}
		
	}
}