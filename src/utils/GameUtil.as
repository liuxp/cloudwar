package utils
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import component.Dict;
	import component.TimeLoop;
	
	import control.ai.CharacterAI;
	import control.skill.*;
	import control.sound.SoundManager;
	import control.view.CharacterMeditor;
	import control.view.EffectMeditor;
	import control.view.bullet.ArrowMeditor;
	import control.view.bullet.BombMeditor;
	import control.view.bullet.LaserMeditor;
	import control.view.bullet.StoneMeditor;
	
	import core.ModelBase;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	import manager.MaterialManager;
	import manager.MeditorManager;
	import manager.ModelLocator;
	import manager.TimeLoopManager;
	
	import model.CharacterModel;
	import model.GeneralModel;
	import model.config.ArmyConfig;
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.vo.CharacterVO;
	import model.vo.GeneralVO;
	import model.vo.SheetVO;
	import model.vo.SkillVO;
	
	import view.character.CharacterBase;
	import view.character.SheetSprite;

	
	public class GameUtil
	{
		private static var _ML:ModelLocator = ModelLocator.getInstance();
		public static const $gameUtil_def_type:Object = { walk:1, archer:2, brainman:3 };
		public static const $gameUtil_country:Array = ['','hero_158','hero_159','hero_160']
		public function GameUtil()
		{
		}
		
		/**延迟指定时间后，执行函数
		 * @delay 延迟
		 * @fun 执行函数
		 * @count 执行次数
		 * @id 延迟id
		 * leo 2011/12/26*/
		public static function delayExecuteFun(delay:Number, fun:Function, count:uint=1, 
											   id:String='', funName:String=null, 
											   complete:Function=null, 
											   completeParams:Array=null,
											   funParams:Array=null):void
		{
			
			var tl : TimeLoop = new TimeLoop(delay, count, fun, complete, completeParams, funParams);
			if(funName)
			{
				
				tl.funName = funName;
			}
			TimeLoopManager.getInstance().addTimeLoop(tl,id);
		}
		/**
		 * 删除延迟函数
		 * */
		public static function deleteDelayFun(delayId:String):void
		{
			if(TimeLoopManager.getInstance().isHaveTimeLoop(delayId))
			{
				TimeLoopManager.getInstance().delTimeLoop(delayId);
			}
		}
		/**
		 *通过坐标得到角色朝向  
		 * @param target
		 * @param targetCamp
		 * @param reference
		 * @return 
		 * 
		 */		
		public static function getCharacterDirByPos(target:CharacterBase, 
													reference:CharacterBase):String
		{
			var dir :String;
			if(target.x <= reference.x)
			{
				if(target.camp != ArmyConfig.Camp_Enemy)dir = ArmyConfig.Dir_Right
				else dir = ArmyConfig.Dir_Right

			}
			else{
				if(target.camp != ArmyConfig.Camp_Enemy)dir = ArmyConfig.Dir_Left
				else dir = ArmyConfig.Dir_Left
			}
			return dir;
		}
		
		public static function getCharacterDirByPoint(target:CharacterBase,
													  point:Point):String
		{
			return point.x >= target.x  ? ArmyConfig.Dir_Right
										: ArmyConfig.Dir_Left
			
		}
		/**
		 *得到角色默认朝向 
		 * @param camp
		 * @return 
		 * 
		 */		
		public static function getCharacterDefaultDir(camp:int, isDefault:Boolean=true):String
		{
			var dir :String;
			switch(camp)
			{
				case ArmyConfig.Camp_Me :
					dir = isDefault ? ArmyConfig.Dir_Right : ArmyConfig.Dir_Left;
					break;
				default :
					dir = isDefault ? ArmyConfig.Dir_Left : ArmyConfig.Dir_Right;
					break;
			}
			return dir;
		}
		
		public static function getCharacterEscapeDir(camp:int):String
		{
			var dir :String;
			switch(camp)
			{
				case ArmyConfig.Camp_Me :
					dir = ArmyConfig.Dir_Left;
					break;
				default :
					dir = ArmyConfig.Dir_Right ;
					break;
			}
			return dir;
		}
		
		public static function isDefaultDir(camp:int):Boolean
		{
			if(camp == ArmyConfig.Camp_Me) return _ML.ourDirDefault
			
				return _ML.enemyDirDefault;
		}
		
		/**
		 *通过角色朝向设置到横向缩放 
		 * @param camp
		 * @param dir
		 * @return 
		 * 
		 */		
		public static function setCharacterDirInfo(value:CharacterVO):void
		{
			
			var camp:int = value.camp;
			var dir:String = value.dir;
			var speed:int = value.speed;
			var scaleX:int;
			
			switch(camp)
			{
				case ArmyConfig.Camp_Me :
					scaleX = dir == ArmyConfig.Dir_Right ? 1 : -1;
//					speed = dir == ArmyConfig.Dir_Right ? Math.abs(speed) : -Math.abs(speed);
					break;
				default :
					scaleX = dir == ArmyConfig.Dir_Right ? 1 : -1;
//					speed = dir == ArmyConfig.Dir_Right ? Math.abs(speed) : -Math.abs(speed);
					break;
					
			}
			
			value.scaleX = scaleX;
//			value.speed = speed;
		}
		/**
		 *位图序列是否循环 
		 * @param state
		 * @return 
		 * 
		 */		
		public static  function isSheetStateLoop(state:String):Boolean
		{
			
			return  state == ArmyConfig.State_Mov
				|| state == ArmyConfig.State_Wait 
				//|| state == ArmyConfig.State_Injured 
				
			
		}
		/**
		 *攻击目标列表 
		 * @param camp
		 * @return 
		 * 
		 */		
		public static function getSearchTargets(camp:int):Dict
		{
			
			switch(camp)
			{
				case ArmyConfig.Camp_Enemy :
					return ModelLocator.getInstance().myArmies;
				case ArmyConfig.Camp_Me :
					return ModelLocator.getInstance().enemies;
				default :
					return null;
			}

		}
		
		public static function getArmys(camp:int):Dict
		{
			switch(camp)
			{
				case ArmyConfig.Camp_Enemy :
					return ModelLocator.getInstance().enemies;
				case ArmyConfig.Camp_Me :
					return ModelLocator.getInstance().myArmies;
				default :
					return null;
			}
			
		}
		
		/**
		 *清除缓存列表里的army数据 
		 * @param camp
		 * @param armyId
		 * 
		 */		
		public static function ClearArmy(camp:int, armyId:String):void
		{
			var dict:Dict = getArmys(camp);
			
			if(dict.isHaveItem(armyId)) dict.DeleteItem(armyId);
		}
		
		public static function AddArmy(camp:int, army:CharacterBase):void
		{
			var dict:Dict = getArmys(camp);
			var armyId:String = army.uid;
			if(!dict.isHaveItem(armyId)) dict.AddItem(armyId, army);
		}
		
		public static function isArmyAlive(camp:int, armyId:String):Boolean
		{
			var dict:Dict = getArmys(camp);
			return (dict.isHaveItem(armyId));
		}
		/**
		 *是否可复活 
		 * @param camp
		 * @return 
		 * 
		 */		
		public static function isReborn(camp:int):Boolean
		{
			return camp == ArmyConfig.Camp_Me;
		}
		/**
		 *是否支持触摸
		 * @return 
		 * 
		 */		
		public static function isSupportTouch():Boolean
		{
			return Multitouch.inputMode != MultitouchInputMode.NONE;
		}
	
		/**
		 *得到配置数据 
		 * @param type
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getCfgByItmID(type:String, id:String):Object
		{
			var cfg : Object = id 
								? _ML.gameCfg.config[type][id] 
								: _ML.gameCfg.config[type];
			return cfg;
		}
		/**
		 *得到AOE的目标列表 
		 * @param pos
		 * @param range
		 * @param camp
		 * @return 
		 * 
		 */		
		public static function getAoeTargets(pos:Array, range:int, camp:int):Vector.<CharacterBase>
		{
			var lis:Vector.<CharacterBase> = new Vector.<CharacterBase>;
			var armies:Dict = getSearchTargets(camp);
			var dict:Dictionary = armies.dict;
			for each(var itm:CharacterBase in dict)
			{
				var len:Number = GlobalUtil.getDistance(pos[0], pos[1], itm.x, itm.y);
				if(len <=range) lis.push(itm);
			}
			
			return lis;
		}
		
		public static function playPKSnd(state:String, isLock:Boolean=false):void
		{

			SoundManager.playSound(state, false, isLock);
		 
		}
		/**
		 *得到角色视觉对象 
		 * @param generalVid
		 * @return 
		 * 
		 */		
		public static function getCharacterById(generalid:String):CharacterBase
		{
			return _ML.game.scene_PK.container_character.getChildByName(generalid) as CharacterBase;
		}
		/**
		 * 獲得 Arr 格式 章節 配置 數據
		 * @param	_obj
		 * @return
		 */
		public static function get_chapterCfg_arr(_obj:Object):Array {
			var _arr:Array = [];
			var _num:int = 0;
			for (var i:Object in _obj) {
				_num = get_chapter_index(i);
				_obj[i]['index'] = _num;
				_arr.push(_obj[i]);
			}
			_arr.sortOn('index');
			return _arr;
		}
		/**
		 * 獲得 章節 ID 的數字標號
		 * @param	_id
		 * @return
		 */
		public static function get_chapter_index(_id:Object):int {
			return int(String(_id).substring(1));
		}
		/**
		 *从序列大位图中取出所需的小位图 
		 * @param srcBit
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function getSheetBitBySheetXML(srcBit:BitmapData, xml:XML):BitmapData
		{
			
			var w:uint = xml.@width;
			var h:uint = xml.@height;
			var x:uint = xml.@x;
			var y:uint = xml.@y;
			var _frameX:int = xml.@frameX;
			var _frameY:int = xml.@frameY;
			var _frameW:uint = Math.max(xml.@frameWidth, w);
			var _frameH:uint = Math.max(xml.@frameHeight, h);

			var _bit:BitmapData = new BitmapData(w,h,true, 0x00000000);
			_bit.copyPixels(srcBit, new Rectangle(x,y,w,h), new Point(0,0));
			
			//var tmpBit:BitmapData = new BitmapData(_frameW,_frameH,true, 0x00000000);
			//var tmpBit:BitmapData = new BitmapData(w,h,true, 0x00000000);
			//var mix:Matrix = new Matrix(1,0,0,1, -_frameX, -_frameY);
			
			//tmpBit.draw(_bit, mix);
			
			return _bit;
		}

		/**
		 * 计算 装备 增益值
		 * @param	_cfg
		 * @param	_lv
		 * @return
		 */
		public static function getEquipValue(_cfg:Object,_lv:int):Object {
			return { hp:Number(_cfg.equip_HP) + Number(_cfg.equip_Hp_param) * _lv, atk:Number(_cfg.equip_Atk) + Number(_cfg.equip_Atk_param) * _lv, speed:_cfg.Attak_speed, range:_cfg.equip_maxRange };
		}

		/**
		 *得到pk武将数据 
		 * @param camp
		 * @param vid
		 * @return 
		 * 
		 */		
		public static function getPKArmyData(camp:int, id:String):GeneralVO
		{
			var mod:ModelBase = camp == ArmyConfig.Camp_Enemy
				? _ML.pkNpcs
				: _ML.pkHeros;
			var lis : Array = mod.getVO() as Array;
			return SearchUtil.getItemByVOFromList('gid', id, lis) as GeneralVO;
		}
		/**
		 *得到我方兵种信息 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getMyArmyData(id:String):GeneralVO
		{
			for each(var mod:GeneralModel in _ML.pkHeros)
			{
				var vo:GeneralVO = mod.getVO() as GeneralVO;
				if(vo.id == id) return vo;
			}
			return null;
		}
		
		/**
		 *清除缓存的pk武将数据 
		 * @param camp
		 * @param vid
		 * 
		 */		
		public static function ClearPKArmyData(camp:int, id:String):void
		{
			if(camp != ArmyConfig.Camp_Enemy) return;
			var mod:ModelBase =  _ML.pkNpcs
			var lis : Array = mod.getVO() as Array;
			SearchUtil.delItemByVOFromList('gid', id, lis);
			
			mod.setVO(lis);
		}
		/**
		 *得到角色数据 
		 * @param viewId
		 * @return 
		 * 
		 */		
		public static function getCharVOByViewId(viewId:String):CharacterVO
		{
			var meditor:CharacterMeditor = MeditorManager.getMeditor(viewId)as CharacterMeditor;
			var mod:CharacterModel = meditor.model as CharacterModel;
			var vo:CharacterVO = mod.getVO() as CharacterVO;
			return vo;
		}
		
		public static function getCharMeditorByViewId(viewId:String):CharacterMeditor
		{
			return MeditorManager.getMeditor(viewId)as CharacterMeditor;
		}
		
		/**
		 *得到兵种头像 
		 * @param type
		 * @param res
		 * @return 
		 * 
		 */		
		public static  function getArmyIcon(type:String, res:String):BitmapData
		{
			
			var _resXML:Vector.<XML> = MaterialManager.getInstance().getSheetMaterialInfos(type, res);
			var srcBit:BitmapData = MaterialManager.getInstance().getSheetMaterial(type);
			return GameUtil.getSheetBitBySheetXML(srcBit, _resXML[0]);
			
		}
		
		
		public static function isPKWin():Boolean
		{
			return _ML.enemies.isEmpty() && !_ML.myArmies.isEmpty()
			
		}
		
		public static function isNpcGeneralsClear():Boolean
		{
			var arr:Array = _ML.pkNpcs.getVO() as Array;
			return arr && arr.length <1;
		}
		/**
		 *是否是魔法攻击兵种 
		 * @param armyType
		 * @return 
		 * 
		 */		
		public static function isMagicAtkOnly(armyType:String):Boolean
		{
			return armyType == ArmyConfig.Type_Brainman
					|| armyType == ArmyConfig.Type_Dancer
					|| armyType == ArmyConfig.Type_Catapult
					|| armyType == ArmyConfig.Type_Warlock
		}
		
		/**
		 *得到攻击者对目标者的相克系数 
		 * @param profession_atk
		 * @param profession_def
		 * @return 
		 * 
		 */		
		/*public static function getRestrictionByProfession(profession_atk:String, 
														  profession_def:String):Number
		{
			var restriction:Object = GameUtil.getCfgByItmID(
										StaticConfig.Cfg_Other, 
										StaticConfig.Cfg_Other_Restriction);
			
			var army_cfg:Object = restriction[profession_atk];
				
			return army_cfg[profession_def];	
		}*/
		/**
		 *得到子弹轨迹类 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getBulletMeditorClassByType(type:String):Class
		{
			switch(type)
			{
				case StaticConfig.Bullet_Track_Bomb :
					return BombMeditor;
				case StaticConfig.Bullet_Track_Arrow :
					return ArrowMeditor;
				case StaticConfig.Bullet_Track_Laser :
					return LaserMeditor;
				case StaticConfig.Bullet_Track_Stone :
					return StoneMeditor;
				default :
					return null;
			}
			
		}
		
		/**
		 * 获得 武将类型 的素材类型（1，2，3）
		 * @param	_str
		 * @return
		 */
		public static function getDef_typeToIcon(_str:String):int {
			var _type:String = _str.toLowerCase();
			var _frame:int = 1;
			return $gameUtil_def_type[_type];
		}
		/**
		 * 检查 是否被雇用了
		 * @param	_mAid
		 * @param	_checkId
		 * @return
		 */
		public static function check_isAid(_mAid:Array,_checkId:String):Object {
			var _obj:Object = null;
			var l:uint = _mAid.length;
			var i:uint = 0;
			var _e:Object
			for (i = 0; i < l; i++) {
				_e = _mAid[i];
				if (_e.id == _checkId) {
					_obj = _e;
					break;
				}
			}
			return _obj;
		}
		/**
		 * 格式化 抽奖奖励格式
		 * @param	_sA
		 * @return
		 */
		public static function formateRanAward(_sA:Array):Array {
			var _arr:Array = [];
			var i:uint = 0;
			var l:uint = _sA.length;
			var _obj:Object = null;
			for (i = 0; i < l; i++) {
				_obj = { id:_sA[i][0], res:_sA[i][0], num:_sA[i][1] };
				_arr.push(_obj);
			}
			return _arr;
		}
		
		public static function createCharVO(id:String, lv:int):CharacterVO
		{
			var cfg:Object = GameUtil.getCfgByItmID(StaticConfig.Cfg_Army, id);
			var vo_char:CharacterVO =  ObjToModelUtil.ObjToCharacter(cfg, lv);
			return vo_char;
		}
		/**
		 *普通受伤 
		 * 
		 */		
		public static function targetInjuredByNormal(targetAI:CharacterAI, _skill:SkillVO):void
		{
			var vo:CharacterVO = targetAI._vo;
			if(!vo) return;
			var damage:int = _skill.damage;
			vo.hp -= damage;
			targetAI._model.setVO(vo);
			
			createSkillEft(_skill.eff_up_enimy, 60, 
				vo.scaleX, targetAI.character.container_top);
			
			GameUtil.playPKSnd(_skill.eff_up_enimy);
			
			targetAI.injured();
			
			var char:CharacterBase = targetAI.character;
			var posX:int = char.x + 10 * -vo.scaleX;
			if(posX > _ML.camera.x_right) posX = char.x + 10 * vo.scaleX;
			TweenMax.to(char,0.2,{x:posX, ease:Strong.easeOut});
			
			
		}
		/**
		 *生成技能特效 
		 * 
		 */		
		public static function createSkillEft(eff:String, delay:int, scaleX:int, container:Sprite):void
		{
			var atkEft:SheetSprite = new SheetSprite(eff);
			new EffectMeditor(atkEft, 0, false, delay);
			atkEft.scaleX = scaleX;
			container.addChild(atkEft);
		}
		
	}
}