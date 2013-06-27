
package model.vo
{
	
	/**
	 *
	 * CookieVO.as class. 
	 * @author Administrator
	 * Created 2013-4-23 上午10:30:55
	 */ 
	public class CookieVO extends VOBase
	{ 
		public var user:Object
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function CookieVO()
		{
			super();
			
			user = {
				lv:1,
				country:'蜀',
				character : '',
				army:{
					ShuDB : {lv:1,step:1}
				},
				hero:{
					ShuYX1 :{lv:50, stuffs:{}, skills:{}}
				}
			}
		} 
		
		
		
	}
	
}