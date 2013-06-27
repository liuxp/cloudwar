
package command
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import view.scene.PKScene;
 

	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * MoveCameraCommand.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-14 下午8:32:10
	 * @history 05/00/12,
	 */ 
	public class MoveCameraCommand extends CommandBase
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		// CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function MoveCameraCommand()
		{
			super();
			
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function execute(params:Object=null):void
		{
			var _view:PKScene = _ML.game.scene_PK;
			var container:Sprite =_ML.game.scene_PK.container;
			var p:Point = params.pos as Point;
			var isEase:Boolean = params.ease;
			//var glaP:Point = _view.container_character.localToGlobal(p);
			var disx:int = _ML.camera.x_margin - p.x;
			disx = Math.min(0, Math.max(_ML.camera.x_max, disx));
			if(isEase){
				TweenMax.to(container,2,{x:disx, ease:Strong.easeOut, onComplete:onTweenComplete});
			}else{
				container.x = Math.min(0, disx);
				onTweenComplete();
			}
			
		}
		
		private function onTweenComplete():void
		{
			this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.Camera_Arrive));
		}
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}