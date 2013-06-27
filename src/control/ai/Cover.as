
package control.ai
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	import component.Dict;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 * 掩护
	 * Cover.as class. 
	 * @author Administrator
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created 2013-4-5 下午6:53:15
	 * @history 05/00/12,
	 */ 
	public class Cover extends Forward
	{ 
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var _marginX:int
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
		public function Cover(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_marginX = Math.random()*100 + 10;
		} 
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		override public function move():void
		{
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			
			//			this.checkTarget();
			_target = this.search();
			
			var coord:Vector2D;
			if(_target)
			{
				_vo.dir = GameUtil.getCharacterDirByPos(character, _target);
				_model.setVO(_vo);
				
				var point:Point = new Point(_target.x-character.x,_target.y-character.y);
				var dis:Number = point.length;
				if(dis <= _vo.range_atk )
				{
					if(this._isCD) _act = wait;
					else _act = attack;
					return;	
				}else{
					coord = new Vector2D(_target.x, _target.y);
					rush(coord);
				}
				
			}
			
			//向主角靠近
			_vo.dir = GameUtil.getCharacterDirByPos(character, _ML.master);
			_model.setVO(_vo);
			dis = Math.abs(character.x - _ML.master.x);

			if(dis <= _marginX)
			{
				if(_target) coord = new Vector2D(_target.x , character.y);
				else _act = wait;
				
			}else{
				coord = new Vector2D(_ML.master.x , character.y);
				
			}
			
			if(coord)
			{
				_meditor.updateSheet(ArmyConfig.State_Mov);
				rush(coord);	
			}
			
			
			
			
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