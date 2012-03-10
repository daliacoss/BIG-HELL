package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class NPC extends Character
	{
		private var convos:Number = 4;
		private var lines:Number;
		
		// to determine whether player is near self
		public var near:Boolean;
		
		public var currentDialogue:Array;
		
		public function NPC(x:int, y:int, character:String, SimpleGraphic:Class=null)
		{
			super(x, y, character);
			
			for (x=0; x<(convos); x++)
			{
				dialogueArray[x] = new Array();
			}

		}
		
		override public function update():void{
			var player:Player = (FlxG.state as PlayState).player;
			var talking:Boolean = (FlxG.state as PlayState).talking;
			var level:int = (FlxG.state as PlayState).level;

			velocity.x = velocity.y = 0;
			

			super.update();
		}
		
		public function talk():void{
			
			var talking:Boolean = (FlxG.state as PlayState).talking;
			var boxDialogue:FlxText = (FlxG.state as PlayState).boxDialogue;
			var level:int = (FlxG.state as PlayState).level;
			var debug:FlxText = (FlxG.state as PlayState).debug;


			
			/*
			if (talking && near){
				boxDialogue.text = textArray[charIndex][level];
				debug.text = String(talking && near)
			}
			*/
		}
		
		//chooses dialogue from textArray and stores splits
		/*
		public function storeDialogue():void
		{
			if (character == "cool"){
				dialogueArray = textArray[0];
			}
			if (character == "old"){
				dialogueArray = textArray[1];
			}
			if (character == "southern"){
				dialogueArray = textArray[2];
			}
			if (character == "fat"){
				dialogueArray = textArray[3];
			}
			for (var i:int=0; i < dialogueArray.length; i++){
				selfDialogue[i] = dialogueArray[i].split("*")
			}
		}
		*/
	}
}