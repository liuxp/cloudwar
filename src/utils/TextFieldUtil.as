package utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFieldUtil
	{
		private static var _text:TextField;
		private static var _dropShadow:Boolean;
		
		public static function create(text:String="",dropShadow:Boolean=false):TextField
		{
			_text=new TextField();
			_text.selectable = false;
			_text.text = text;
			if(dropShadow)TextFieldUtil.dropShadow();
			return _text;
		}
		
		public static function createTextformat(color:uint=0xfff8aa,size:uint=12,
												fontType:String="宋体",
												bd:Boolean=true,align:String="left"):TextFormat
		{

		
			var tft:TextFormat = new TextFormat();
  			tft.color = color;
			tft.font = fontType;  
			tft.size = size;
			tft.align=align;
			tft.bold = bd;
			//tft.size=1000;
			return tft;

		}
		
		public static function dropShadow(displayObj:DisplayObject=null,distance:int=0,color:uint=0,strength:uint=1,angle:Number=45):void
		{	/**color,alpha,blurX,blurY,strength,quality**/
			//var glow:GlowFilter=new GlowFilter(0xffffff,1,1,1,1,1);
			/**distance,angle,color,alpha,blurX,blurY,strength,quality**/
			/* var shadow:DropShadowFilter=new DropShadowFilter(1,45,0,1,3,3,1,1); */
			var shadow:DropShadowFilter=new DropShadowFilter(distance,angle,color,1,3,3,strength,2);
			
			if(displayObj!=null)
			{
				displayObj.filters=[shadow];
			}
			else if(displayObj==null&&TextFieldUtil._text!=null)
			{
				TextFieldUtil._text.filters=[shadow];
			}
		}	
		
		public static function glow(displayObj:DisplayObject=null):void
		{	/**color,alpha,blurX,blurY,strength,quality**/
			var glow:GlowFilter=new GlowFilter(0xffffff,1,1,1,5,1);
			if(displayObj!=null)
			{
				displayObj.filters=[glow];
			}
			else if(displayObj==null&&TextFieldUtil._text!=null)
			{
				TextFieldUtil._text.filters=[glow];
			}
		}
		/**
		 * 得到打字体位图所需要的格式
		 * */
		public static function getTxtBitFmtStr(_colorStr:String, _size:int, 
											   _font:String, _lastStr:String):String
		{
			return '<font color="' + _colorStr + '" size="'
					+_size+'" face="'+_font+'">' + _lastStr + '</font>'
		}
		/**
		 * 借用羊村的方法：打字体位图
		 * */
		public static function textBitmap(_msg:String,_widthLine:int=0,
										_filters:Array = null,
										_isCompress:Boolean = false):Bitmap {
											
			var _blur:BlurFilter = new BlurFilter(3, 3, 2);
			var _s:Sprite = new Sprite();
			var _bit:Bitmap = null;
			var _txt:TextField = new TextField();
			var _tf:TextFormat = new TextFormat();
			
			_tf.leading = 3;		
			_txt.autoSize = 'left';
			_txt.multiline = true;
			_txt.htmlText = _msg;
			
			if (_txt.bottomScrollV > 1)_txt.setTextFormat(_tf);
			
			//每行文本到达指定宽度自动换行，且不强行压缩
			if (_widthLine > 0 && !_isCompress) {
				_txt.wordWrap = true;
				_txt.width = _widthLine ;

			}
			_txt.filters = [_blur];
			//附加额外滤镜
			if(_filters is Array)
			{

				_txt.filters = _txt.filters.concat(_filters);

			}
			//必须同样才能缩放
			_txt.scaleX =_txt.scaleY = 4;
			_s.addChild(_txt);
			 
			_bit = new Bitmap(MatrixUtil.disObjToBit(_s));
			
			_bit.scaleX = _bit.scaleY = 0.25;
			
			//强行把最宽行压缩到指定宽度
			if(_isCompress && _widthLine > 0 && _bit.width>_widthLine)
			{
				_bit.width = _widthLine;
			}
			
			return _bit;
		}
		
		public static  function getHtmStr(str:String , color:String="#ff0000", 
										  size:uint=12, font:String="宋体", 
										  _data:String = '', isLink:Boolean=false,  
										  underLine : Boolean = true):String
		{
			var f:String = "<font ";
			var f_ : String = ">";
			var _f : String = "</font>";
			var u_ : String = "<u>";
			var _u : String = "</u>";
			var a : String = "<a href='event:";
			var a_ : String = "'>";
			var _a : String = "</a>";
			var co:String = "color='" + color + "' ";
			var fa:String = "face='" + font + "' ";
			var si:String = "size='" + size.toString() + "'";
			if(isLink)
			{
				/**为了传递 slg任务追踪的任务id 添加 _data  Michael 2010/11/20*/
				var _str : String = _data.length?_data:str;
				if(underLine) return u_ + a + _str + a_ + f + co + si +  f_ +  str  + _f + _a + _u;
				else return  a + _str + a_ + f + co + si +  f_ +  str  + _f + _a ;
			}
			return f + co + fa + si + f_ +  str  + _f;
		}
		
			
	}
}