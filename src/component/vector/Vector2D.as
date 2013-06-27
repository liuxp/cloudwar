package component.vector{
	import flash.display.Graphics;
	
	public class Vector2D {
		private var _x:Number;
		private var _y:Number;
		
		//构造函数
		public function Vector2D(x:Number=0,y:Number=0) {
			_x=x;
			_y=y;
		}
		
		//绘制向量(以便于显示)
		public function draw(graphics:Graphics,color:uint=0):void {
			graphics.lineStyle(0,color);
			graphics.moveTo(0,0);
			graphics.lineTo(_x,_y);
		}
		
		//克隆对象
		public function clone():Vector2D {
			return new Vector2D(x,y);
		}
		
		//位置归零
		public function zero():Vector2D {
			_x=0;
			_y=0;
			return this;
		}
		
		//是否在零位置
		public function isZero():Boolean {
			return _x==0&&_y==0;
		}
		
		//获得向量的角度
		public function get angle():Number {
			return Math.atan2(_y,_x);
		}
		
		//设置向量的模(即大小)
		public function set length(value:Number):void {
			var a:Number=angle;
			_x=Math.cos(a)*value;
			_y=Math.sin(a)*value;
		}
		
		//获取向量大小的平方
		public function get lengthSQ():Number {
			return _x*_x+_y*_y;
		}
		
		//获取向量的模(即大小)
		public function get length():Number {
			return Math.sqrt(lengthSQ);
		}
		
		//设置向量的角度
		public function set angle(value:Number):void {
			var len:Number=length;
			_x=Math.cos(value)*len;
			_y=Math.sin(value)*len;
		}   
		
		
		//截断向量(设置向量模最大值)
		public function truncate(max:Number):Vector2D {
			length=Math.min(max,length);
			return this;
		}
		
		//交换x,y坐标
		public function reverse():Vector2D {
			_x=- _x;
			_y=- _y;
			return this;
		}
		
		
		//定义二个向量的加法运算
		public function add(v2:Vector2D):Vector2D {
			return new Vector2D(_x+v2.x,_y+v2.y);
		}
		
		//定义二个向量的减法运算
		public function subtract(v2:Vector2D):Vector2D {
			return new Vector2D(_x-v2.x,_y-v2.y);
		}
		
		//向量模的乘法运算
		public function multiply(value:Number):Vector2D {
			return new Vector2D(_x*value,_y*value);
		}
		
		//向量模的除法运算
		public function divide(value:Number):Vector2D {
			return new Vector2D(_x/value,_y/value);
		}
		
		//判定二个向量(坐标)是否相等
		public function equals(v2:Vector2D):Boolean {
			return _x==v2.x&&_y==v2.y;
		}
		
		//设置x轴坐标
		public function set x(value:Number):void {
			_x=value;
		}
		
		//返回x轴坐标
		public function get x():Number {
			return _x;
		}
		
		//设置y轴坐标
		public function set y(value:Number):void {
			_y=value;
		}
		
		//返回y轴坐标
		public function get y():Number {
			return _y;
		}
		
		
		//单位化向量(即设置向量的模为1，不过这里用了一种更有效率的除法运算，从而避免了lengh=1带来的三角函数运算)
		public function normalize():Vector2D {
			if (length==0) {
				_x=1;
				return this;
			}
			//建议大家画一个基本的3,4,5勾股定理的直角三角形即可明白下面的代码
			var len:Number=length;
			_x/=len;
			_y/=len;
			return this;
		}       
		
		//判定向量是否为单位向量
		public function isNormalized():Boolean {
			return length==1.0;
		}
		
		//点乘(即向量的点积)
		public function dotProd(v2:Vector2D):Number {
			return _x*v2.x+_y*v2.y;
		}
		
		//叉乘(即向量的矢量积)
		public function crossProd(v2:Vector2D):Number {
			return _x*v2.y-_y*v2.x;
		}
		
		//返回二个向量之间的夹角
		/**首先对向量v1,v2做了单位化处理，使其变成（模为1的）单位向量，
		 * 这样夹角公式中的|a|×|b|（即分母）自然也就是1，公式演变成cos(θ)=a.b（即夹角余弦 等于 向量a与b的点乘），
		 * 然后再对其取反余弦Math.acos，最终得到夹角
		*/
		public static function angleBetween(v1:Vector2D,v2:Vector2D):Number {
			if (! v1.isNormalized()) {
				v1=v1.clone().normalize();
			}
			if (! v2.isNormalized()) {
				v2=v2.clone().normalize();
			}
			return Math.acos(v1.dotProd(v2));//建议先回顾一下http://www.cnblogs.com/yjmyzz/archive/2010/06/06/1752674.html中提到的到夹角公式
		}
		
		//判定给定的向量是否在本向量的左侧或右侧，左侧返回-1，右侧返回1
		public function sign(v2:Vector2D):int {
			return perp.dotProd(v2)<0?-1:1;
		}
		
		//返回与本向量垂直的向量(即自身顺时针旋转90度，得到一个新向量)
		/**
		 *  x1 = x0 cos(a) - y0 sin(a);
			y1 = yo cos(a) + x0 sin(a)
			把a设为90度，则 x1 = -y0 y1 = x0;
		*/
		
		public function get perp():Vector2D {
			return new Vector2D(- y,x);//建议回顾一下"坐标旋转"
		}
		
		
		//返回二个矢量末端顶点之间的距离平方
		public function distSQ(v2:Vector2D):Number {
			var dx:Number=v2.x-x;
			var dy:Number=v2.y-y;
			return dx*dx+dy*dy;
		}
		
		//返回二个矢量末端顶点之间的距离
		public function dist(v2:Vector2D):Number {
			return Math.sqrt(distSQ(v2));
		}
		
		//toString方法
		public function toString():String {
			return "[Vector2D (x:"+_x+", y:"+_y+")]";
		}
	}
}