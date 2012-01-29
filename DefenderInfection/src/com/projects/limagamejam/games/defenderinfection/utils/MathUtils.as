package com.projects.limagamejam.games.defenderinfection.utils 
{
	import flash.accessibility.Accessibility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Eduardo Medina Alfaro
	 */
	public class MathUtils
	{
		private static const TO_RADIANS:Number = Math.PI / 180;
		private static const TO_DEGREES:Number = 180 / Math.PI;
		private static const TWO_PI:Number = 2 * Math.PI;
		
		
		public function MathUtils() 
		{
			
		}
		
		public static function floor(value:Number):Number
		{
			return 0;
		}
		
		public static function random(value:Number):Number
		{
			return Math.random() * value;
		}
		
		public static function randRange(min:Number, max:Number):Number 
		{
			return min+((max-min)*Math.random());
		}
		
		public static function toDegrees(radians:Number):Number
		{
			return radians * TO_DEGREES;
		}

		public static function toRadians(degrees:Number):Number
		{
			return degrees * TO_RADIANS;
		}
		
		public static function getAngleBetweenTwoPoints(point1:Point, point2:Point):Number
		{
			//var angle:Number = Math.atan((point2.y - point1.y) / (point2.x - point1.x));
			//return angle;
			
			var dx:Number = point2.x - point1.x;
			var dy:Number = point2.y - point1.y;
			return -Math.atan2(dx, dy);
		}
		
		
		
		/**
		* Normalizes an angle to a relative angle.
		* The normalized angle will be in the range from -PI to PI, where PI
		* itself is not included.
		*
		* @param angle the angle to normalize (Radians)
		* @return the normalized angle that will be in the range of [-PI,PI] (Radians)
		*/
		public static function normalRelativeAngle(angle:Number):Number
		{
			var result:Number;
			
			if ( (angle % TWO_PI) >= 0)
			{
				if (angle < Math.PI)
					result = angle;
				else
					result = angle - TWO_PI;
				//endif;
			}
			else
			{
				if(angle >= -Math.PI)
					result = angle;
				else
					result = angle + TWO_PI;
				//endif;
			}
			
			return result;
		}
		
		public static function generateBitmap($mc:MovieClip ):Bitmap
		{
			var bmd:BitmapData = new BitmapData($mc.width, $mc.height);
			bmd.draw($mc);
			var bm:Bitmap = new Bitmap(bmd);
			return bm;
		}
		public static function copyBitmap($bm:Bitmap):Bitmap
		{
			var bmd:BitmapData = new BitmapData($bm.width, $bm.height);
			bmd.draw($bm);
			
			var bm:Bitmap = new Bitmap(bmd);
			return bm;
		}
		
		//max 4 números --------
		public static function posMax(arr:Array):int
		{
			var maxVal:int = 0;
			var count:int = 0;
			
			for each(var item:int in arr){
				maxVal = (item > maxVal) ? item : maxVal;
				
				count++
			}
			for (var i:int = 0; i < arr.length; i++) 
			{
				//maxVal = (item > maxVal) ? item : maxVal;
				if (arr[i] == maxVal)
				{
					return i;
				}
			}
			return count;
		}
		
		//public static function randomizeArray(array:Vector.<QuestionVo>):Vector.<QuestionVo> {
			//var newArray:Vector.<QuestionVo> = new Vector.<QuestionVo>();
			//while(array.length > 0){
				//var obj:Vector.<QuestionVo> = array.splice(Math.floor(Math.random()*array.length), 1);
				//newArray.push(obj[0]);
			//}
			//return newArray;
		//}		
		
		public static function randomizeArr(array:Array):Array{
			var newArray:Array = new Array();
			while(array.length > 0){
				var obj:Array = array.splice(Math.floor(Math.random()*array.length), 1);
				newArray.push(obj[0]);
			}
			return newArray;
		}
		
		public static function randomMinMax($min:Number,$max:Number):Number
		{
			return $min + ($max - $min) * Math.random();
		}
		
		
	}

}