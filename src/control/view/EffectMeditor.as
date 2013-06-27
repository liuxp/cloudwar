
package control.view
{
	import core.view.ViewBase;
	
	import events.MeditorEvent;
	
	import flash.display.BitmapData;
	
	import manager.ModelLocator;
	
	import model.config.GameCfg;
	import model.vo.SheetVO;
	import control.view.sheet.SheetSpriteMeditor;
	
	public class EffectMeditor extends SheetSpriteMeditor
	{
		 
		private var _cd:int;
		private var _resume:Boolean;
		private var _ML :ModelLocator = ModelLocator.getInstance();
		
		public function EffectMeditor(view:ViewBase, cd:int=0, resume:Boolean=false, delay:int=20)
		{
			super(view);
			_cd = cd*1000;
			_resume = resume;
			_delay = delay;
		}
		
		override protected function initData():void
		{
			super.initData();
			_vo.delay = _delay;
		}
		
		override public function Play():void
		{
			
			_cd -= this._delay;
			if(this._render.isEnd())
			{
				 
				
				if( _cd<=0)
				{
					if(this._resume) resumeRender();
					_view.dispose();
					return;
				}else{
					_render.reset();
				}
			}
			
			var srcBit:BitmapData = _render.render();
			_view.bitmap.bitmapData = srcBit;
			if(srcBit)
			{
				/*_view.bitmap.y = - srcBit.height;
				_view.bitmap.x = -srcBit.width * 0.5;*/
				
				_view.bitmap.x =  _render.coords[0];
				_view.bitmap.y =  _render.coords[1];
			}
			
			
		}
		//恢复渲染
		public function resumeRender():void
		{
			
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Render_Start));
				
			
		}
		
		override public function clear():void
		{
			super.clear();
			_ML = null;
		}
	}
}