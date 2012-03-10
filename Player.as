package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	
	public class Player extends Character
	{
		public var wallDirection:String = new String;
		public var debug:String = new String;
		//public var character:String = new String;
		
		public function Player(x:int, y:int, character:String, SimpleGraphic:Class=null)
		{
			super(x, y, character);
			
			//super(x, y, SimpleGraphic);

			addAnimation("idle", [0]);
			addAnimation("walk", [1, 2], 10, false);

			maxVelocity.x = 60;
			maxVelocity.y = 30;
			acceleration.x = 1000;
			drag.x = drag.y = 400;
		}
		
		override public function update():void{
			var level:FlxSprite = (FlxG.state as PlayState).houseInside;
			var talking:Boolean = (FlxG.state as PlayState).talking;

			acceleration.x = 0;
			
			if (! talking){
				if((FlxG.keys.A || FlxG.keys.LEFT)){
					facing = LEFT;
					play("walk");
					velocity.x = -maxVelocity.x;
				}
				else if((FlxG.keys.D || FlxG.keys.RIGHT)){
					facing = RIGHT;
					play("walk");
					velocity.x = maxVelocity.x;
				}
				if((FlxG.keys.W || FlxG.keys.UP)){
					//facing = UP;
					play("walk");
					velocity.y = -maxVelocity.y;
				}
				else if((FlxG.keys.S || FlxG.keys.DOWN)){
					//facing = DOWN;
					play("walk");
					velocity.y = maxVelocity.y;
				}
			}
			else{
				play("idle");
			} 
			//debug = String(FlxG.keys.A);
			
			super.update();
		}
	}
}