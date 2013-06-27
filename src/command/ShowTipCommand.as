package command
{
	import events.MeditorEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import manager.CommandManager;
	
	import model.vo.GeneralVO;
	
	import utils.EffectUtil;
	import utils.GlobalUtil;
	import utils.TextFieldUtil;
	
	public class ShowTipCommand extends CommandBase
	{
		public function ShowTipCommand()
		{
			super();
		}
		override public function execute(params:Object=null):void
		{
			var info:String = params as String;
			var txt:TextField = TextFieldUtil.create('');
			txt.defaultTextFormat = TextFieldUtil.createTextformat(0xff0000,30,'微软雅黑');
			txt.autoSize = TextFieldAutoSize.LEFT
			txt.multiline = true;	
			_ML.game.layer_tip.addChild(txt);
			//var str:String = TextFieldUtil.getHtmStr(info,'#ff0000',30,'黑体');
			txt.text = info;
			GlobalUtil.setCenterPos(_ML.game, txt);
			EffectUtil.fly(txt);
			
			
		}
	}
}