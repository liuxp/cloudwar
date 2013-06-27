package command
{
	import component.Iterator;
	
	import control.ai.Static;
	import control.view.CharacterMeditor;
	
	import events.MeditorEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import manager.CommandManager;
	import manager.ModelLocator;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.config.ArmyConfig;
	import model.config.GameCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.UserVO;
	import model.vo.WaveVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.component.Zone;
	import view.character.CharacterBase;

	/**
	 *生成战波 
	 * @author Administrator
	 * 
	 */
	public class CreateWaveCommand extends CommandBase
	{
		private var container_character :Sprite;
		
		private var _npcs:Array;
		private var _pos:Point;
		private var _curNpc:Object;
		private var _cd:uint;//阵型cd
		private var _loop:int;
		private var _waves:Array;
		private var _isClear:Boolean;
		private var _delay:uint = 1000;
		

		
		public function CreateWaveCommand()
		{
			super();
			
			

			
		}
		
		private function cleanWave(e:MeditorEvent):void
		{
			_isClear = true;
			this.clear();
		}
		
		public function renderStart(e:MeditorEvent):void
		{
			if(_npcs && _npcs.length )
			{
				GameUtil.delayExecuteFun(_delay, delayFun, 0, this.mid, 
										 'delayFun');
			}
			
		}
		
		public function renderStop(e:MeditorEvent):void
		{
			GameUtil.deleteDelayFun(this.mid);
			
		}
		
		override public function execute(params:Object=null):void
		{
			var mession:Object = params;
			
			//if(mession.BaseSet.PKMode == StaticConfig.PKMode_Chase) return;
			
			var baseSet:Object = mession.BaseSet;
			_waves =  mession.EnemyProduceSet;
			_loop = baseSet.Loop;
 			_pos = new Point(baseSet.EnemyBornX, baseSet.EnemyBornY);

			_npcs= _waves.concat();
			
			container_character = _ML.game.scene_PK.container_character;
			
			this.addMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.addMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.addMeditorEventListener(MeditorEvent.Wave_Clean, cleanWave);
			
			GameUtil.delayExecuteFun(_delay, delayFun, 0, this.mid, 'delayFun');
 
		}
		//刷npc
		private function delayFun():void
		{
			if(_isClear) return;
			
			this._cd += this._delay;
			
			if(!_curNpc)
			{
				if(_npcs.length)
				{
					_curNpc = _npcs.shift();
				}else{//全部刷完后从头开始循环
					if(_loop >0)
					{
						this._npcs = this._waves.concat();
						this._cd = 0;
						_curNpc = _npcs.shift();
						_loop--;
						
					}else{
						//循环完毕
						GameUtil.deleteDelayFun(this.mid);
						clear();
						return;
					}
					
				}
			}
			
			
			var delay:uint = _curNpc.delay * 1000;

			if(_cd >= delay)//刷npc
			{
				var cfg:Object = _curNpc.army;
				var roll:Number = Math.random();
				
				for (var id:String in cfg)
				{
					var itm:Object = cfg[id];
					if(roll > itm.ProduceRate) continue;
					createCharacter(id, itm);
					trace(_cd,'秒后刷了一个敌人：', id)
				}
				
				this._curNpc = null;
			}
			
			 
 
			 
		}
		
		private function createCharacter(npcId:String, cfg:Object):void
		{
			for(var p:uint; p<cfg.num; p++)
			{
				
				var itm:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, npcId);
				var vo_npc:CharacterVO =  ObjToModelUtil.ObjToCharacter(itm, cfg.Level);
				vo_npc.camp = ArmyConfig.Camp_Enemy;
				vo_npc.init_ai = cfg.AiType;
				vo_npc.updateSkill(1);
				vo_npc.range_atk = vo_npc.skill_normal.range + Math.random()*20 + Math.random()*30;
				vo_npc.init_range_atk = vo_npc.range_atk;
				
				
				var pos:Array = [_pos.x+Math.random()*50 + Math.random()*50, 
								 _pos.y+Math.random()*20 + Math.random()*30 ];
				
				var container: Sprite = _ML.game.scene_PK.container_character;
				CommandManager.createCharacter({vo:vo_npc, pos:pos, 
												container:container, ai:true});
					
					 
				
			}
			
			
 
		}
		
		override public function clear():void
		{
			super.clear();
			this.removeMeditorEventListener(MeditorEvent.Render_Start, renderStart);
			this.removeMeditorEventListener(MeditorEvent.Render_Stop, renderStop);
			this.removeMeditorEventListener(MeditorEvent.Wave_Clean, cleanWave);
			
			GameUtil.deleteDelayFun(this.mid);
			container_character = null;
			this._npcs = null;
			this._curNpc = null;
			this._pos = null;
			this._waves = null;
			 
			
		}
		
	}
}