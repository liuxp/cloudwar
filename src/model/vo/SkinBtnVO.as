package model.vo
{
	public class SkinBtnVO
	{
		public var up :String;
		public var down :String;
		
		public function SkinBtnVO(up:Class, down:Class)
		{
			this.up = up;
			this.down = down;
		}
	}
}