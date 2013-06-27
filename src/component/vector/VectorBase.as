package component.vector{
	
	public class VectorBase {
		//质量
		protected var _mass:Number=1;
		//最大速度
		protected var _maxSpeed:Number;
		//坐标
		protected var _position:Vector2D;
		//速度
		protected var _velocity:Vector2D;
		
		protected var _x:Number;
		protected var _y:Number;
		public var rotation:int;
		
		public function VectorBase() {
			_position=new Vector2D  ;
			_velocity=new Vector2D  ;
		}
 
		public function update():void {
			
			//设置最大速度
			_velocity.truncate(_maxSpeed);
			
			//根据速度更新坐标向量
			_position=_position.add(_velocity);         
			
			 
			//更新x,y坐标值
			x=position.x;
			y=position.y;
			
			//处理旋转角度
			rotation=_velocity.angle*180/Math.PI;
		}
		
		 
		
		 
		//下面的都是属性定义

		public function set mass(value:Number):void {
			_mass=value;
		}
		
		public function get mass():Number {
			return _mass;
		}
		
		public function set maxSpeed(value:Number):void {
			_maxSpeed=value;
		}
		
		public function get maxSpeed():Number {
			return _maxSpeed;
		}
		
		public function set position(value:Vector2D):void {
			_position=value;
			x=_position.x;
			y=_position.y;
		}
		
		public function get position():Vector2D {
			return _position;
		}
		
		public function set velocity(value:Vector2D):void {
			_velocity=value;
		}
		
		public function get velocity():Vector2D {
			return _velocity;
		}
		
		public function set x(value:Number):void {
			_x=value;
			_position.x= _x;
		}
		
		public function set y(value:Number):void {
			_y=value;
			_position.y= _y;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get x():Number
		{
			return _x;
		}
		public function clear():void
		{
			this._position = null;
			this._velocity = null;
		}
	}
}