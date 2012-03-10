package 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class Character extends FlxSprite
	{
		
		[Embed(source="img/southern_man.png")] public var southernSprite:Class;
		[Embed(source="img/old_man.png")] public var oldSprite:Class;
		[Embed(source="img/cool_dude.png")] public var coolSprite:Class;
		[Embed(source="img/fat_man.png")] public var fatSprite:Class;
		[Embed(source="img/stock_char.png")] public var stockSprite:Class;
		[Embed(source="txt/text0.txt", mimeType="application/octet-stream")] private var txt0:Class;
		[Embed(source="txt/text1.txt", mimeType="application/octet-stream")] private var txt1:Class;
		[Embed(source="txt/text2.txt", mimeType="application/octet-stream")] private var txt2:Class;
		[Embed(source="txt/text3.txt", mimeType="application/octet-stream")] private var txt3:Class;
		
		public var textArray:Array = new Array(4);
		public var npcArray:Array = new Array(4); 
		public var dialogueArray:Array = new Array(5);
		
		public var character:String = new String;
		public var charIndex:int;

		private var txt0Instance:Object = new txt0();
		public var txt0Converted:String = txt0Instance.toString();
		private var txt1Instance:Object = new txt1();
		public var txt1Converted:String = txt1Instance.toString();
		private var txt2Instance:Object = new txt2();
		public var txt2Converted:String = txt2Instance.toString();
		private var txt3Instance:Object = new txt3();
		public var txt3Converted:String = txt3Instance.toString();

		private var maxCharacters:Number = 100;

		public function Character(x:int, y:int, character:String, SimpleGraphic:Class=null)
		{
			super(x, y, SimpleGraphic);
			this.character = character;
			
			var npcGroup:Array = (FlxG.state as PlayState).npcGroup.members;
			for (var i:int = 0; i<4; i++){
				npcArray[i] = npcGroup[i];
			}
			
			if (character == "southern") {
				loadGraphic(southernSprite, true, true, 14, 32);
				charIndex = 2;
			}
			else if (character == "old") {
				loadGraphic(oldSprite, true, true, 13, 39);
				charIndex = 1;

			}
			else if (character == "cool") {
				loadGraphic(coolSprite, true, true, 16, 35);
				charIndex = 0;

			}
			else if (character == "fat") {
				loadGraphic(fatSprite, true, true, 19, 33);
				charIndex = 3;

			}
			else if (character == "stock") {
				loadGraphic(stockSprite, true, true, 13, 34);
			}

			addAnimation("idle", [0]);
			
			// WRITTEN BY ERIC:
			textArray[0] = txt0Converted.split("&");
			textArray[1] = txt1Converted.split("&");
			textArray[2] = txt2Converted.split("&");
			textArray[3] = txt3Converted.split("&");

		}
		
		override public function update():void{
			super.update();	
		}
		
		

	}
}