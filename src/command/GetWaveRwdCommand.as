
package command
{
	import control.view.popUI.WaveRwdUIMeditor;
	
	import events.MeditorEvent;
	
	import flash.utils.Dictionary;
	
	import flashx.textLayout.debug.assert;
	
	import manager.CommandManager;
	import manager.UIManager;
	
	import model.config.AssetsCfg;
	import model.config.StaticConfig;
	import model.config.UICfg;
	import model.vo.UserVO;
	
	import net.SendAndSelect;
	import net.SendServiceAMFFun;
	
	import utils.ObjToModelUtil;
	
	
	/**
	 *波结算 
	 * @author Administrator
	 * 
	 */
	public class GetWaveRwdCommand extends CommandBase
	{
		
		private var _user:UserVO;
		
		public function GetWaveRwdCommand()
		{
			super();
		}
		
		override public function execute(params:Object=null):void
		{
			
				getRwd();
				
			
		}
		
		private function getRwd(isBoss:Boolean=false):void
		{
			_user = _ML.user.getVO() as UserVO;
			 
			var tip:String = '获得波奖励：';
			
			if(isBoss){
				return;
				CommandManager.ChangeScene(StaticConfig.Scene_Chapter);
				tip = '领取关底奖励';
				CommandManager.clearWave();
			}else {
				
				CommandManager.createMession();
			}
			
			
			clear();
			
//			SendServiceAMFFun.sendService_pk_done(pkDone,{diff:diff,isBoss:isBoss});
		}
		
		private function pkDone(data:Object):void
		{
			var isBoss:Boolean = (data.data.random_reward_list as Array).length>0?true:false;//data.params.isBoss
			_ML.reward = data;
//			var heros:Object = data.heros;
			//更新英雄数据
         
//			var myHeroLis:Object = _user.mHero;
//			for(var id:String in myHeroLis)
//			{
//				var rwd:Object = heros[id];
//				if(!rwd) continue;
//				
//			}
			//提示
			//this.dispatchMeditorEvent(new MeditorEvent(MeditorEvent.FlyTip, 
				//{type:StaticConfig.FlyTip_PK_Reward, data:data } ));
			
			//
			if(isBoss){
				CommandManager.ChangeScene(StaticConfig.Scene_Chapter);
				trace('领取关底奖励');
				CommandManager.clearWave();
			}
			else {
				
				CommandManager.createMession();
			}
            clear();
		}
		
		override public function clear():void
		{
			super.clear();
			this._user = null;
		}
	}
}