package com.projects.limagamejam.games.defenderinfection.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Carlos Piñan
	 */
	public class Utils
	{
		
		public function Utils()
		{
		
		}
		
		public static function disabledBtn($btn:SimpleButton, $b:Boolean = false):void
		{
			$btn.mouseEnabled = $b;
		}
		
		public static function disabledButton($btn:*, $b:Boolean = false):void
		{
			if ($btn is MovieClip)
			{
				MovieClip($btn).mouseEnabled = $b;
			}
			else if ($btn is Sprite)
			{
				Sprite($btn).mouseEnabled = $b;
			}
			else if ($btn is SimpleButton)
			{
				SimpleButton($btn).mouseEnabled = $b;
			}
		}
		/**
		 * http://snipplr.com/view/11342/
		 * @param	$bmp
		 * @return
		 */
		public static function duplicateBitmap($bmp:Bitmap):Bitmap
		{
			var orginal:Bitmap = $bmp;
			var duplicate:Bitmap = new Bitmap();
			duplicate.bitmapData = orginal.bitmapData;
			
			return duplicate;
		}
		
		//public static function drawPhoto($mc:AbstractUI):Bitmap
		//{
			//var bmd:BitmapData = new BitmapData($mc.width, $mc.height); //400 328
			//bmd.draw($mc, null, $mc.transform.colorTransform);
			//var bm:Bitmap = new Bitmap(bmd);
			//bm.smoothing = true;
			//
			//return bm;
		//}
		
		public static function drawPhotoMC($mc:MovieClip,$w:Number=0,$h:Number=0):Bitmap
		{
			var bmd:BitmapData = new BitmapData($w, $h); //400 328
			bmd.draw($mc, null, $mc.transform.colorTransform);
			var bm:Bitmap = new Bitmap(bmd);
			bm.smoothing = true;
			
			return bm;
		}
		
		public static function domainLocal():Boolean
		{
			var lc:LocalConnection = new LocalConnection();
			trace("domain ", lc.domain);
			if (lc.domain == 'localhost')
			{
				return true;
			}
			return false;
		}
		
		public static function copyBitmap($bitmap:Bitmap):Bitmap
		{
			var bmp:BitmapData = $bitmap.bitmapData.clone();
			var bm:Bitmap = new Bitmap(bmp);
			bm.smoothing = true;
			return bm;
		}
		
		public static function mouseEvents($clip:MovieClip):void
		{
			$clip.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent)
				{
					$clip.alpha = 0.7;
				});
			
			$clip.addEventListener(MouseEvent.ROLL_OUT, function(evt:MouseEvent)
				{
					$clip.alpha = 1;
				});
		}
		
		public static function forInObject($obj:Object):void
		{
			for (var s:Object in $obj)
			{
				//trace(s + " = >" + $obj[s]);
				for (var sa:Object in s)
				{
					//trace(sa + " == >" + s[sa]);
				}
			}
		}
		
		//public static function clearString($txt:String):String
		//{
			//var _s:String = "";
			//
			//return _s;
		//}
		
		public static function sinAcentos(textoConAcentos:String):String 
		{
			var texto1:String=trim(textoConAcentos);
			var texto2:String=trimAll(texto1);
			texto1=texto2.toLocaleUpperCase();
			
			//texto1=textoConAcentos.toLowerCase();
			var acentos:Array=new Array("á","é","í","ó","ú","Á","É","Í","Ó","Ú");
			var sinAcentos:Array=new Array("a","e","i","o","u","A","E","I","O","U");
			
			function quitarAcentos(texto:String,letraSplit:String,letraCambio:String)
			{
				var letras:Array=texto.split(letraSplit);
				var nuevoTexto:String=new String();
				for (var i:int=0;i < letras.length;i++) {
				nuevoTexto+=letras[i];
				nuevoTexto+=letraCambio;
			}
			nuevoTexto=nuevoTexto.substring(0,nuevoTexto.length-1);
			return nuevoTexto;
			}
			for (var i:int=0; i < acentos.length; i++)
			{
				texto1=quitarAcentos(texto1,acentos[i],sinAcentos[i]);
			}
			return texto1;
		}
		public static function trim(str:String):String
		{
			return str.replace(/^\s*(.*?)\s*$/g, "$1");
		}
		public static function trimAll(str:String):String
		{
			var s:Array=str.split("");
			var aux:String="";
			
			for (var i:int=0; i < s.length; i++)
			{
				if(s[i]!=" ")
				{
					aux+=s[i];
				}
			}
			return aux;
		}
		
		public static function generateVersion($version:String="1.0"):TextField
		{
			 var my_fmt:TextFormat = new TextFormat();
			 my_fmt.color = 0x000000;
			 //my_txt.defaultTextFormat = my_fmt;
	 
			var result:TextField = new TextField();
            result.x = 0;
            result.y = 0;
            result.width = 100;
            result.height = 30;
            result.border = true;
			result.defaultTextFormat = my_fmt;
			result.text = "VERSION " + $version;
			result.alpha = 0.7;
            return result;
		}
	}

}