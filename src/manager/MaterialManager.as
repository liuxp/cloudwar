package manager
{
	import component.load.XMLEditor;
	
	import core.view.ViewBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedSuperclassName;
	
	import model.config.sheet.CharacterMaterial;
	import model.config.sheet.CharacterXMLCfg;
	import model.config.sheet.GameMaterial;
	import model.config.sheet.SheetXMLCfg;
	
	import mx.core.SpriteAsset;
	
	public class MaterialManager
	{
		private static var _instance : MaterialManager;

		public function MaterialManager(instance : SingleTon)
		{
			this.symbolCfg = {};
			this.sheetXMLDict = new Dictionary();
			this.assetsDict = new Dictionary();
		}
		public static function getInstance():MaterialManager
		{
			if(_instance == null) 
				_instance = new MaterialManager(new SingleTon);
				
			return _instance;
		}
		//素材库
		public var sheetXMLDict : Dictionary ;
		//素材配置
		public var symbolCfg:Object;
		//添加素材
		public var assetsDict:Dictionary; 
		 
		/**
		 * 得到sheet位图序列xml配置
		 * @param type
		 * @param name
		 * @return 
		 * 
		 */		
		public function getSheetMaterialInfos(type:String, name:String=null):Vector.<XML>
		{
			if(name == null)
			{
				if(!sheetXMLDict[type])
				{
					var xmlClass:Class = SheetXMLCfg[type];
					var xml:XML = XML(new xmlClass);
					var lis:Vector.<XML> = XMLEditor.getSheetLisByItemStr(type,xml)
					sheetXMLDict[type] = lis;
				}
				
				return sheetXMLDict[type];
			}else{
				//
				if(!sheetXMLDict[type]) sheetXMLDict[type] = new Dictionary;
				if(!sheetXMLDict[type][name]){
					try{
					xmlClass = SheetXMLCfg[type];
					xml = XML(new xmlClass);
					lis = XMLEditor.getSheetLisByItemStr(name,xml)
					sheetXMLDict[type][name] = lis;
					}catch(e:TypeError)
					{
						trace(e.message);
					}
				}
				
				return sheetXMLDict[type][name];
			}
			
		}
		public function getCharacterSheetXML(type:String, name:String):Vector.<XML>
		{
			//
			if(!sheetXMLDict[type]) sheetXMLDict[type] = new Dictionary;
			if(!sheetXMLDict[type][name]){
				try{
					var xmlClass :Class = CharacterXMLCfg[type];
					var xml:XML = XML(new xmlClass);
					var lis:Vector.<XML> = XMLEditor.getSheetLisByItemStr(name,xml)
					sheetXMLDict[type][name] = lis;
				}catch(e:TypeError)
				{
					trace(e.message);
				}
			}
			
			return sheetXMLDict[type][name];
			
			
		}
		/**
		 *得到角色 序列位图
		 * @param type
		 * @return 
		 * 
		 */		
		public function getCharacterSheetMaterial(type:String):BitmapData
		{
			if(!this.assetsDict['sheet']) this.assetsDict['sheet'] = new Dictionary();
			if(!this.assetsDict['sheet'][type])
			{
				var bitClass :Class = CharacterMaterial[type];
				if(!bitClass) throw Error('no material: '+ type);
				var bit:Bitmap = new bitClass();
				this.assetsDict['sheet'][type] = bit.bitmapData;
			}
			return this.assetsDict['sheet'][type];
		}
		
		/**
		 * 得到一整张序列的位图
		 * @param type
		 * @return 
		 * 
		 */		
		public function getSheetMaterial(type:String):BitmapData
		{
			if(!this.assetsDict['sheet']) this.assetsDict['sheet'] = new Dictionary();
			if(!this.assetsDict['sheet'][type])
			{
				var bitClass :Class = GameMaterial[type];
				var bit:Bitmap = new bitClass();
				this.assetsDict['sheet'][type] = bit.bitmapData;
			}
			return this.assetsDict['sheet'][type];
		}
		/**
		 * 删除整张序列位图
		 * @param type
		 * 
		 */		
		public function disposeSheetMaterial(type:String):void
		{
			if( ! this.assetsDict['sheet'] 
				|| !this.assetsDict['sheet'][type]) return; 
			
			var bit:BitmapData = this.assetsDict['sheet'][type];
			bit.dispose();
			
			this.assetsDict['sheet'][type] = null;
			delete this.assetsDict['sheet'][type];
		}
		/**
		 * 得到UI组件实例
		 * @param type
		 * @return 
		 * 
		 */		
		public function getViewMaterial(type:String):*
		{
			var classObj:Class = this.symbolCfg['asset'][type];
			var view:*  = new classObj();
			
			/*var xml:XML = flash.utils.describeType(view);
			var superName:String = flash.utils.getQualifiedSuperclassName(view);*/ 
			return view;
		} 
		
		public function getViewClass(type:String):Class
		{
			var classObj:Class = this.symbolCfg['asset'][type];
			return classObj;
		} 
		
		public function getBtnMaterial(type:String):SimpleButton
		{
			var classObj:Class = this.symbolCfg['asset'][type];
			var _view:SimpleButton = new classObj();
			return _view;
		}
		/**
		 * 得到地图图片实例
		 * @param type
		 * @return 
		 * 
		 */		
		public function getMapMaterial(type:String):Bitmap
		{
			try{
				var classObj:Class = this.symbolCfg['asset'][type];
				var map:Bitmap = new classObj();
			}catch(e:TypeError){
				trace('未找到素材：', type)
			}
			return map;
		}
		
	}
}

	class SingleTon {}
