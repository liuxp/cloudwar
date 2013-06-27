
package control.ai
{
	import component.Dict;
	import component.vector.Vector2D;
	
	import control.view.CharacterMeditor;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import manager.CommandManager;
	import manager.MeditorManager;
	
	import model.config.ArmyConfig;
	import model.config.StaticConfig;
	
	import utils.GameUtil;
	
	import view.character.CharacterBase;
	
	
	/**
	 *撤退
	 * Escape.as class. 
	 * @author Administrator
	 * Created 2013-5-6 上午10:18:05
	 */ 
	public class Escape extends Forward
	{ 
		private var _marginX:int;
		private var _escapeDir:String;
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function Escape(meditor:CharacterMeditor)
		{
			super(meditor);
			
			_escapeDir = GameUtil.getCharacterEscapeDir(_vo.camp);
			_marginX = getEscapeMarginX();
		} 
		
		override public function move():void
		{
			
			this.checkTarget();
			_steeredVector.x = character.x;
			_steeredVector.y = character.y;
			_target = this.search(); 
			
			if(_target)
			{
				
				
				var dis:Number;
				var targetType:String = _target.armyType;
				var range_atk:int;
				var p:Point;
				
				p  = new Point(_target.x-character.x, _target.y-character.y);
				
				range_atk = _vo.range_atk;
				
				dis = p.length;
				if(dis <= range_atk && dis >=0)
				{
					if(this._isCD)
					{
						goBack();
					}
					else _act = attack;
				}else{
					
					changeDir(false);
					

					goBack();
					
					
				}
				
			}else{
				
				changeDir(false);				
				
				_meditor.updateSheet(ArmyConfig.State_Mov);
 
				if(this.isEscapeSuccess())
				{
					this.wait();
					this.stop();
					checkPKResult();
				}else{
					goBack();
				}
				
			}
 
		}
		
		private function goBack():void
		{
			_meditor.updateSheet(ArmyConfig.State_Mov);
			this.character.x += _vo.speed* _vo.scaleX;
		}
		private function checkPKResult():void
		{
			if( _vo.armyType != ArmyConfig.Type_General
				|| _vo.camp != ArmyConfig.Camp_Enemy) return;
			
			_ML.dialogType = StaticConfig.Dialog_BattleFail;
			CommandManager.CreateBattleStory(_ML.user.vo.seleced_mession);
		}
		
		override public function wait():void
		{
			if(!_skillVO)
			{
				if(this._isMagic)
				{
					_skillVO = _vo.skill_active[0];
				}else{
					_skillVO = _vo.skill_normal;
				}
			}
			_vo.range_atk = _skillVO.range;
			_vo.init_range_atk = _skillVO.range;

			_act = move;	
			
		}
		private function changeDir(isDefault:Boolean=true):void
		{
			var dir:String = isDefault ? GameUtil.getCharacterDirByPos(character, _target)
									   : this._escapeDir

			if(_vo.dir != dir)
			{
				_vo.dir = dir;
				_model.setVO(_vo);
			}
 
		}
		
		private function getEscapeMarginX():int
		{
			var posX:int;

			if(_escapeDir ==  ArmyConfig.Dir_Right)
			{
				posX = _ML.camera.x_right;
			}else{
				posX = _ML.camera.x_left;
			}
			return posX;
		}
		
		private function isEscapeSuccess():Boolean
		{
			if(_escapeDir ==  ArmyConfig.Dir_Right)
			{
				return  this.character.x > _ML.camera.x_right + character.width;
			}else{
				return  this.character.x < _ML.camera.x_left - character.width;
			}
		}
		
		override public function injured():void
		{
			
			super.injured();
				
			this.refreshHeroHP();
		}
		
		override public function setTarget(target:CharacterBase, isLock:Boolean=false):void
		{
			
		}
		
		override public function search():CharacterBase
		{
			
			var lis:Dict = GameUtil.getSearchTargets(_vo.camp);
			if(!lis) return null;
			
			var list:Array = []; 
			
			for each(var i:CharacterBase in lis.dict)
			{
				var p:Point = new Point(i.x - this.character.x, i.y - character.y);
				
				var dis:Number = p.length;
				if( dis <= _vo.range_guard )
				{
					return i;
				}
				
			}
			
			//if(_ML.master) return _ML.master;
			return null;
			
			
		}
		
	}
	
}