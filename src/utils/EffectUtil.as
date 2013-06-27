package utils
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Strong;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	

	
	public class EffectUtil
	{
		public static var _direction : String = 'left';
		 
		
	
		public static  function fly(_view:DisplayObject):void
		{
			 
			var tw1:TweenLite = new TweenLite(_view, 1, { y: _view.y - 60, alpha:1 });
			var tw2:TweenLite = new TweenLite(_view, .6, { alpha:0, ease:Strong.easeInOut , 
															onComplete:onFinishTween,
															onCompleteParams : [[_view]]});

			var timeline:TimelineLite = new TimelineLite();
			timeline.append( tw1 );
			timeline.append( tw2 );
			
			
		}
		
		
		/**淡出*/
		public static function FadeOut(_view:DisplayObjectContainer):void
		{
			var tw1:TweenLite = new TweenLite(_view, 2, { overwrite:0 });
			var tw2:TweenLite = new TweenLite(_view, .6, { alpha:0, ease:Strong.easeInOut , 
															onComplete:onFinishTween,
															onCompleteParams : [[_view]]});

			var timeline:TimelineLite = new TimelineLite();
			timeline.append( tw1 );
			timeline.append( tw2 );
		}
		
		/**
		 * 膨胀效果
		 * */
		public static  function Swell(_view:DisplayObjectContainer):void
		{
			
			_view.scaleX = _view.scaleY = 0; 
			var tw1:TweenLite = new TweenLite(_view, 0.2, { scaleX:1, scaleY:1, ease:Back.easeOut});
			var tw2:TweenLite = new TweenLite(_view, 0.1, { overwrite:0 });
			var tw3:TweenLite = new TweenLite(_view, 0.2, 
									{  	alpha:0, 
										onComplete:onFinishTween,
										onCompleteParams : [[_view]]});

			var timeline:TimelineLite = new TimelineLite();
			timeline.append( tw1 );
			timeline.append( tw2 );
			timeline.append( tw3 );
			//timeline.append( tw4 );
		} 
		
		public static function Fly(_view:DisplayObjectContainer):void
		{
			 
			var tw1:TweenLite = new TweenLite(_view, .3, { y: _view.y - 60, alpha:1 , ease:Strong.easeOut });
			//var tw2:TweenLite = new TweenLite(this, 1, { overwrite:0 });
			var tw3:TweenLite = new TweenLite(_view, .3, 
								{ 	alpha:0, ease:Strong.easeInOut , 
									onComplete:onFinishTween,
									onCompleteParams : [[_view]]});

			var timeline:TimelineLite = new TimelineLite();
			timeline.append( tw1 );
			//timeline.append( tw2 );
			timeline.append( tw3 );
		}
		private static function onFinishTween(params:Array):void
		{
			var dis : DisplayObject = params[0];
			if(dis && dis.parent)
			{
				
				dis.parent.removeChild(dis);
				dis = null;
			}
			//var _model : RpgModelLocator = RpgModelLocator.getInstance();
			//_model.EventDispatch.dispatchEvent(new HeroEvent(HeroEvent.FlyComplete));
		}
		//淡入
		public static function Fade_In(_view:DisplayObjectContainer):void
		{
			_view.alpha = 0;
			var tl:TweenLite = new TweenLite(_view, 1, { alpha:1, ease:Strong.easeInOut});
		}
		//淡出
		public static function Fade_Out(_view:DisplayObject, completeFun:Function=null, completeFunParams:Array=null):void
		{
			var vars:Object = { alpha:0, ease:Strong.easeInOut};
			if(completeFun!=null) vars.onComplete = completeFun;
			if(completeFunParams!=null) vars.onCompleteParams = completeFunParams;
			
			_view.alpha = 1;
			var tl:TweenLite = new TweenLite(_view, 1, vars);
		}

		
	}
}