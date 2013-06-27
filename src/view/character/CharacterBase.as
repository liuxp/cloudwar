package view.character
{
	import component.RadiusShape;
	
	import flash.display.Sprite;
	
	import utils.GlobalUtil;
	
	import view.component.ProcessBar;
	import view.component.Zone;

	public class CharacterBase extends SheetSprite 
	{
		public var barHp : ProcessBar;
		public var zone:Zone;
		public var armyType:String;
		public var camp:int;
		public var container_bottom:Sprite;
		public var container_top:Sprite;
		public var container_temp:Sprite;
		
		public function CharacterBase(type:String, armyType:String, camp:int)
		{
			this.armyType = armyType
			this.camp = camp;
			super(type);
			
		}
		
		override protected function initView():void
		{
			container_bottom = GlobalUtil.createContainer(this,false,false);
			
			this.initBitmap();
			
			container_top = GlobalUtil.createContainer(this,false,false);
			
			container_temp = GlobalUtil.createContainer(this,false,false);
		}
		
		public function setHp(cur:int, max:int):void
		{
			if(!barHp)
			{
				barHp = new ProcessBar();
//				addChild(barHp);
				if(cur==max || cur==0) barHp.visible = false;
				barHp.setProcess(cur, max, this.camp);
				barHp.x = - barHp.width*0.5;
			}else{
				if(cur!=max && !barHp.visible ) barHp.visible = true;
				barHp.setProcess(cur, max, this.camp);
			}
 
		}
		public function setZone(range:int):void
		{
			/*if(!zone)
			{
				zone = new Zone(range);
				this.container_zone.addChild(zone);
			}
			zone.draw();
			zone.visible = false;*/
		}
		
		public function showZone():void
		{
			//zone.visible = !zone.visible;
		}
	}
}