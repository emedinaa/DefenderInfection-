package com.projects.limagamejam.games.defenderinfection.utils 
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	import com.facebook.graph.FacebookDesktop;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.system.LoaderContext;
	import flash.system.Security;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class FacebookUtils 
	{
		private var _f:Function;
		
		private var _APP_ID:String;
		private var _permission:String;
		
		public function FacebookUtils($appID:String,$permission:String) 
		{
			_APP_ID = $appID;
			_permission = $permission;
		}
		
		public  function shareWallPhoto($url:String,$msg:String,$bm:Bitmap,$token:*,$f:Function):void
		{
			_f = $f;
			Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
			Security.allowDomain('http://hphotos-sjc1.fbcdn.net');
			
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;

			var bm:Bitmap = $bm;
			var texto:String = $url + " \n" + $msg;
			
			var timeStamp : String = String(new Date().getTime());
			var values : Object = { message:texto, fileName:'foto' + timeStamp, image: bm,
			access_token: $token};
			//access_token:Singleton.getInstance().token};
			
			Facebook.api('/me/photos', handleUploadComplete, values,'POST');
		}
		
		public  function shareWallPhotoDesktop($url:String,$msg:String,$bm:Bitmap,$token:*,$f:Function):void
		{
			_f = $f;
			//Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
			//Security.allowDomain('http://hphotos-sjc1.fbcdn.net');
			
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;

			var bm:Bitmap = $bm;
			var texto:String = $url + " \n" + $msg;
			
			var timeStamp : String = String(new Date().getTime());
			var values : Object = { message:texto, fileName:'foto' + timeStamp, image: bm,
			access_token:$token};
			
			FacebookDesktop.api('/me/photos', handleUploadComplete, values,'POST');
		}
		
		private function handleUploadComplete(result:Object, fail:Object):void 
		{
			if (result)
			{
				//var rs:String = String(result);

				//trace("Foto publicada correctamente ...", JSON.encode(result));
				//Utils.forInObject(result);
				_f.apply(null,["Foto publicada correctamente ..."]);
				
			}else if (fail)
			{
				//var rf:String = String(fail);
				_f.apply(null, ["Error publicando foto ..."]);
				//Utils.forInObject(fail);
				//trace("Error publicando foto ...", JSON.encode(fail));
			}
			//Utils.disabledBtn(btnCompartir, true);
		}
		
		public function sharePhotoFP($obj:Object):void
		{
			var access_token:String = "AAAEetLbq0XkBAH88i1nsTTCaoLHVCSrlMLA9LeeNvuZBB3iOr0dTq5kSKHSAF7y5TMRDwMlKZB865NC5vUm6dr3tmlCcl7myt7CYZCnwCv96NRnKr36";
			var params:Object = {};
			params.access_token = access_token;

			//$accounts = $facebook->api('/1420838501/accounts', 'GET', $params);
			FacebookDesktop.api('/1420838501/accounts', handleAPIComplete, params, 'GET');
			//'me/accounts', getPageAccessToken, null, 'GET'
		}
		
		private function handleAPIComplete(result:Object, fail:Object):void 
		{
			trace("handleAPIComplete ", JSON.encode(result), " ", JSON.encode(fail));
			//trace("handleAPIComplete ", result, " ",fail);
			var fanpage:String = '166047936825803';
			var album_id:String = '193979824032614';
			
			/*$args = array(
			   'message' => 'This photo was uploaded via QuickDev.in',
			   'image' => '@' . $img,
			   'aid' => $album_id,
			   'no_story' => 1,
			   'access_token' => $fanpage_token
			  );*/
			var access_token:String = "AAAEetLbq0XkBAH88i1nsTTCaoLHVCSrlMLA9LeeNvuZBB3iOr0dTq5kSKHSAF7y5TMRDwMlKZB865NC5vUm6dr3tmlCcl7myt7CYZCnwCv96NRnKr36";
			
			var bmd:BitmapData = new BitmapData(100, 100, false, 0xff00ff);
			var bm2:Bitmap = new Bitmap(bmd);
			trace("1 ");
			var params:Object = { }
			params.message = "message";
			params.image = bm
			params.aid = album_id;
			params.access_token = access_token;
			trace("2 ");
			var option:String = "/" + album_id +"/photos";
			trace("3 ");
			
			//FacebookDesktop.api(option, handleAlbumComplete, params, 'POST');
			//FacebookDesktop.api('/1420838501/accounts', handleAPIComplete, null, 'GET');
			
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;

			var bm:Bitmap = bm2;
			var texto:String =  "message";
			
			var timeStamp : String = String(new Date().getTime());
			var values : Object = { message:texto, fileName:'foto' + timeStamp, image: bm,
			access_token:access_token};
			
			FacebookDesktop.api(option, handleAlbumComplete, values,'POST');
		}
		
		private function handleAlbumComplete(result:Object, fail:Object):void 
		{
			trace("4");
			trace("handleAlbumComplete ", JSON.encode(result), " ", JSON.encode(fail));
			//trace("handleAlbumComplete ", fail);
		}
	
		
		public function get APP_ID():String 
		{
			return _APP_ID;
		}
		
		public function set APP_ID(value:String):void 
		{
			_APP_ID = value;
		}
		
		public function get permission():String 
		{
			return _permission;
		}
		
		public function set permission(value:String):void 
		{
			_permission = value;
		}
		
	}

}