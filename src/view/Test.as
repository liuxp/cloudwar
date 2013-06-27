package view
{
	import component.Dissolve;
	import component.Pool;
	import component.RadiusShape;
	import component.tracks.Beeline;
	import component.tracks.ITrack;
	import component.tracks.Parabola;
	import component.tracks.Rays;
	
	import control.view.CharacterMeditor;
	import control.view.EffectMeditor;
	
	import core.meditor.Meditors;
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextInteractionMode;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import manager.CommandManager;
	import manager.MaterialManager;
	
	import model.CharacterModel;
	import model.SkillModel;
	import model.UserModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.config.sheet.GameMaterial;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SkillVO;
	import model.vo.UserVO;
	
	import utils.GameUtil;
	import utils.GlobalUtil;
	import utils.ObjToModelUtil;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;
	import view.dialog.TalkBubble;
	
	public class Test extends Sprite
	{
		private var _ball:RadiusShape;
		private var _track:ITrack;
		
		private var _user:UserModel;
		private var _skill:SkillModel;
		private var _mdts:Meditors;
		
		public function Test()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler)
			
		}
		
		protected function addHandler(event:Event):void
		{
			/*_ball = new RadiusShape();
			_ball.Create(50,50);
			addChild(_ball);
			_ball.x = _ball.y = 100;
			_track = new Rays(_ball, 400, 100,2);*/
			//this.addEventListener(Event.ENTER_FRAME, renderHander);
			//			this.stage.addEventListener(MouseEvent.CLICK, clickHandler);
			/*var hid:String = 'NPC_qi_bing'
			var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Npc, hid);
			var _gerVO:GeneralVO = ObjToModelUtil.ObjToGeneral(cfg);
			var _charVO:CharacterVO = ObjToModelUtil.GeneralToCharacter(_gerVO);
			_charVO.camp = ArmyConfig.Camp_Enemy;
			_charVO.state = ArmyConfig.State_Mov;
			var char:CharacterBase = new CharacterBase(_charVO.type, _charVO.armyType, _charVO.camp);
			var _model:CharacterModel = new CharacterModel
			
			var ctr:CharacterMeditor = new CharacterMeditor(char, _model);
			addChild(char);
			_model.setVO(_charVO);
			char.y = 200;
			
			var eff:SheetSprite = new SheetSprite('trap');
			var effctr:EffectMeditor = new EffectMeditor(eff);
			char.container_top.addChild(eff); 
			eff.y = 30*/
			/*_user = new UserModel();
			_skill = new SkillModel;
			_mdts = new Meditors([_user, _skill]);
			_user.setVO(new UserVO);
			_skill.setVO(new SkillVO);*/
			
			var dissolve:Dissolve = new Dissolve();
			addChild(dissolve);
			var bm_top:Bitmap = MaterialManager.getInstance().getMapMaterial('map_01');
			var bm_bottom:Bitmap = MaterialManager.getInstance().getMapMaterial('map_02');
			dissolve.setBit(bm_top.bitmapData, bm_bottom.bitmapData);
			dissolve.show();
		}
		
		protected function clickHandler(evt:MouseEvent):void
		{
			
			var str:String = removeRepeatWord('ss bb');
			
			var time:Number = flash.utils.getTimer();
			
			var fun:Function = renderHander;
			
			for(var i:int; i<10000; i++)
			{
				fun.apply(null, [new Event(Event.ENTER_FRAME)]);
			}
			
			trace('耗时：', flash.utils.getTimer() - time);
			
			_mdts.clear();
		}
		
		protected function renderHander(event:Event):void
		{
			
			/*_track.Render();
			trace(_ball.x, '___', _ball.y)*/
		}
		
		private function removeRepeatWord(str:String):String
		{
			var resArr:Array = str.split("");
			var resStr:String = "";
			var len:int = resArr.length;
			for(var i:int=0;i<len;i++)
			{
				if(resArr[i]==undefined)
				{
					break;
				}
				for(var j:int=0;j<len;j++)
				{
					if(i!=j&&resArr[i]==resArr[j]&&resArr[i]!=" ")
					{
						resArr.splice(j,1);
					}
				}
			}
			resStr = resArr.join("");
			return resStr;
		}
	}
}