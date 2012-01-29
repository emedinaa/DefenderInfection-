package com.projects.limagamejam.games.defenderinfection.view.mediator 
{
	import com.facebook.graph.FacebookDesktop;
	import com.projects.core.iview.AbstractMediator;
	import com.projects.limagamejam.games.defenderinfection.utils.FacebookUtils;
	import com.projects.limagamejam.games.defenderinfection.utils.NetLoader;
	import com.projects.limagamejam.games.defenderinfection.utils.Utils;
	import com.projects.limagamejam.games.defenderinfection.view.ClientContext;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author emedinaa
	 */
	public class GOWinMediator extends AbstractMediator 
	{
		static public const APP_ID:String = "272829062782839";
		static public const APP_ORIGIN:String = "http://apps.facebook.com/infectiondefender";
		private var mview:WinView;
		private var data:*;
		
		private var context:ClientContext;
		private var tocken:*;
		
		public function GOWinMediator($view:Sprite,$data:*) 
		{
			super($view);
			mview = (WinView)($view);
			data = $data;
			context = $data.context;
			initView();
			/**
			 * 	
			InfectionDefender
			App ID:	272829062782839
			App Secret:	1db800496524b6d31a2218d0c516d797(reiniciar)

			(edit icon)

			 */
		}
		override public function initView():void 
		{
			super.initView();
			events();
			initAppFacebook();
		}
		
		private function initAppFacebook():void 
		{
			FacebookDesktop.init(APP_ID, onInit);
		}
		
		private function onInit(result:Object, fail:Object):void 
		{
			if (result) { //already logged in because of existing session
				//outputTxt.text = "onInit, Logged In\n";
				//loginToggleBtn.label = "Log Out";
			//	trace("onInit result ",JSON.encode(result));
			} else {
				//outputTxt.text = "onInit, Not Logged In\n";
				//trace("onInit fail ",JSON.encode(fail));
			}
			//FacebookDesktop.logout(handleLogoutInit, APP_ORIGIN);
			LogoutDesktop();
		}
		
		private function LogoutDesktop($exit:Boolean=false):void 
		{
			 var uri:String = APP_ORIGIN;
			  var params:URLVariables = new URLVariables();
			  params.next = uri;
			  params.access_token = tocken;

			  var req:URLRequest = new URLRequest("https://www.facebook.com/logout.php");
			  req.method = URLRequestMethod.GET;
			  req.data = params;

			  var netLoader:NetLoader = new NetLoader();
			  netLoader.load(req);

			//FacebookDesktop.logout(handler, uri);
			if (!$exit) {
				FacebookDesktop.logout(handleLogoutInit, uri) 
				} else
			{
				FacebookDesktop.logout(handleLogout, uri);
			}
		}
		
		private function handleLogoutInit($success:Boolean):void 
		{
			trace("logout >>> ");
			loginDesktop();
		}
		protected function loginDesktop():void
		{
			var permissions:Array = ["user_photos","publish_stream","email","read_stream"];
			FacebookDesktop.login(onLoginDesktop, permissions);
		}
		
		protected function onLoginDesktop(result:Object, fail:Object):void 
		{
			if (result) 
			{ 
				//trace("login >> result ", JSON.encode(result));
				//Singleton.getInstance().token = result['accessToken'];
				tocken = result['accessToken'];
				sendFacebookDesktop();
				//showLog("login >> result "+ JSON.encode(result));
				//successfully logged in
				//outputTxt.appendText("Logged In\n");
				//loginToggleBtn.label = "Log Out";
			} else {
				trace("login fail >>> ", fail);
				//showMessage("Logueate en Facebook ...");
				Utils.disabledBtn(mview.btnShare, true);
				//showLog("login fail >>> " +JSON.encode(fail) );
				//outputTxt.appendText("Login Failed\n");				
			}
		}
		
		private function sendFacebookDesktop():void 
		{
			//showMessage(MESSAGE_OK_FB);
			var $url:String = "http://globalgamejam.org/2012/infection-defender"
			var nUser:String = "";
			var $msg:String = "Lima Game Jam Infected Defender "
			var bmd:BitmapData = generatePhoto();
			var $bm:Bitmap = new Bitmap(bmd, "auto", true);
			var fb:FacebookUtils = new FacebookUtils("272829062782839", "");
			
			//mview.addChild($bm);
			//return;
			
			fb.shareWallPhotoDesktop($url, $msg, $bm,tocken, UpdateFacebook);
			
			//fb.sharePhotoFP(null);
		}
		
		private function UpdateFacebook($obj:*):void 
		{
			
		}
		override public function events():void 
		{
			super.events();
			mview.btnRetry.addEventListener(MouseEvent.CLICK, CLICK_handler);
			mview.btnFacebook.addEventListener(MouseEvent.CLICK, fAcebook_handler);
		}
		
		private function generatePhoto():BitmapData 
		{
			//var bmd:Bitmap = Utils.copyBitmap(Bitmap(data));
			var bmd:Bitmap = Utils.drawPhotoMC(mview['picture'], 455.35, 341.50);
			return bmd.bitmapData;
		}
		
		private function fAcebook_handler(e:MouseEvent):void 
		{
			//loginDesktop()
			initAppFacebook()
		}
		
		protected function handleLogout(success:Boolean):void {
			trace("logout >>> ", success);
			
			NativeApplication.nativeApplication.exit();
			//Singleton.getInstance().context.changeView("login", null);
			
		}
		
		private function CLICK_handler(e:MouseEvent):void 
		{
			destroy();
			context.changeView("home", data) ;
			
		}
		override public function destroy():void 
		{
			super.destroy();
			mview.btnRetry.removeEventListener(MouseEvent.CLICK, CLICK_handler);
		}
	}

}