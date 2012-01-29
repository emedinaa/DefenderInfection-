package com.projects.limagamejam.games.defenderinfection.view.mediator.characters 
{
	import com.projects.limagamejam.games.defenderinfection.utils.CharacterConstant;
	/**
	 * ...
	 * @author emedinaa
	 */
	public class FriendActions 
	{
		
		public function FriendActions() 
		{
			
		}
		
		public static function activeNormal($obj:FriendUI):void
		{
			$obj['mc1'].visible = false
			$obj['mc'].gotoAndPlay(CharacterConstant.FRIEND_INIT)
			$obj['mc'].visible = true
		}
			
		public static function activeWarrior($obj:FriendUI):void
		{
			$obj['mc'].visible = false
			$obj['mc1'].visible = true
		}
	}

}