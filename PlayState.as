package
{
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		
		[Embed(source="img/home_outside.png")] private var houseOutsideSprite:Class;
		[Embed(source="img/home_inside.png")] private var houseInsideSprite:Class;
		[Embed(source="img/home_inside_outline.png")] private var houseInsideOutlineSprite:Class;
		[Embed(source="img/path.png")] private var pathSprite:Class;

		
		[Embed(source="sound/level0.mp3")] private var level0Music:Class;
		[Embed(source="sound/level1.mp3")] private var level1Music:Class;
		[Embed(source="sound/level2.mp3")] private var level2Music:Class;
		[Embed(source="sound/level3.mp3")] private var level3Music:Class;
		[Embed(source="sound/level4.mp3")] private var level4Music:Class;
		//[Embed(source="sound/voice1.mp3")] private var voice1:Class;

		// characters
		public var player:Player;
		public var npc1:NPC;
		public var npc2:NPC;
		public var npc3:NPC;
		public var npc4:NPC;
		public var npcGroup:FlxGroup = new FlxGroup;
		
		// level
		public var houseOutside:FlxSprite = new FlxSprite();
		public var houseInside:FlxSprite = new FlxSprite();
		public var houseInsideOutline:FlxSprite = new FlxSprite();
		public var path:FlxSprite = new FlxSprite();

		// dialogue box
		public var boxBG:FlxSprite;
		public var boxFrame:FlxSprite;
		public var boxDialogue:FlxText;
		public var boxOptions:FlxText;
		public var boxCoverAbove:FlxSprite;
		public var boxCoverBelow:FlxSprite;
		public var textbox:FlxGroup = new FlxGroup;
		
		// chapter text
		public var chapterText:FlxText;
		
		// screen frame
		public var frameTop:FlxSprite = new FlxSprite(0, 0);
		public var frameRight:FlxSprite = new FlxSprite(FlxG.width - 2, 0);
		public var frameBottom:FlxSprite = new FlxSprite(0, FlxG.height - 1);
		public var frameLeft:FlxSprite = new FlxSprite(0, 0);
		public var frame:FlxGroup = new FlxGroup();

		//fadeout box
		public var fadeScreen:FlxSprite = new FlxSprite(0, 0);
		
		//positioning
		public var spawnX:int = 32;
		public var spawnY:int = 264;
		public var boxWidth:Number = FlxG.width * .5;
		public var boxHeight:Number = boxWidth * .3;
		public var boxY:Number = 8;
		
		public var level:int = 0;
		public var talking:Boolean;
		public var near:Boolean;
		public var spawnTimer:Number = 0;
		public var chapterTimer:Number = 0;
		public var playingMusic:Boolean = false;
		public var playingSound:Boolean = false;

		
		public var debug:FlxText = new FlxText(FlxG.width - 100, 2, 100);
		public var credits1:FlxText = new FlxText(2, 2, 100);
		public var credits2:FlxText = new FlxText(2, FlxG.height - 30, 100);
		public var credits3:FlxText = new FlxText(FlxG.width - 100, FlxG.height - 50, 100);

		
		override public function create():void{
			//screen frame
			frameTop.makeGraphic(FlxG.width, 1);
			frameRight.makeGraphic(1, FlxG.height);
			frameBottom.makeGraphic(FlxG.width, 1);
			frameLeft.makeGraphic(1, FlxG.height);
			frame.add(frameTop); frame.add(frameRight); frame.add(frameBottom); frame.add(frameLeft);
			
			//level
			FlxG.bgColor = 0xff000000;
			houseOutside.loadGraphic(houseOutsideSprite);
			houseInside.loadGraphic(houseInsideSprite);
			houseInsideOutline.loadGraphic(houseInsideOutlineSprite);
			path.loadGraphic(pathSprite);

			// player
			player = new Player(spawnX, spawnY, "stock");
			
			// NPCs
			npc1 = new NPC(131 + (Math.floor(Math.random() * 1) + 5), 176 + (Math.floor(Math.random()) + 5), "old");
			npc4 = new NPC(300 + (Math.floor(Math.random() * 1) + 5), 175 + (Math.floor(Math.random()) + 5), "fat");
			npc3 = new NPC(209 + (Math.floor(Math.random() * 1) + 5), 149 + (Math.floor(Math.random()) + 5), "cool");
			npc2 = new NPC(222 + (Math.floor(Math.random() * 1) + 5), 222 + (Math.floor(Math.random()) + 5), "southern");
			
			npcGroup.add(npc1);
			npcGroup.add(npc2);
			npcGroup.add(npc3);
			npcGroup.add(npc4);
			
			// dialogue box
			boxFrame = new FlxSprite((FlxG.width/2) - (boxWidth/2), boxY);
			boxFrame.makeGraphic(boxWidth, boxHeight, 0xffffffff);
			boxBG = new FlxSprite(boxFrame.x + 2, boxFrame.y + 2);
			boxBG.makeGraphic(boxWidth - 4, boxHeight - 4, 0xff000000);
			boxDialogue = new FlxText(boxFrame.x + 4, boxFrame.y + 20, boxFrame.width - 8);
			boxDialogue.size = 12;
			boxCoverAbove = new FlxSprite((FlxG.width/2) - (boxWidth/2), boxY + boxFrame.height);
			boxCoverAbove.makeGraphic(boxWidth, FlxG.height - (boxFrame.height + boxFrame.y) - 1, 0xff000000);
			boxCoverBelow = new FlxSprite((FlxG.width/2) - (boxWidth/2), 1);
			boxCoverBelow.makeGraphic(boxWidth, boxBG.y - 2, 0xff000000);
			
			// chapter text
			chapterText = new FlxText(FlxG.width/2 - 100, 50, 250);
			chapterText.size = 16;
			
			//fadeout screen
			fadeScreen.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			fadeScreen.alpha = 0;
			
			// add stuff		
			textbox.add(boxFrame);
			textbox.add(boxBG);
			textbox.add(boxDialogue);
			textbox.add(boxCoverAbove);
			textbox.add(boxCoverBelow);
			add(textbox);
			add(houseInside);
			add(npcGroup);
			add(houseOutside);
			add(path);
			add(player);
			add(credits1);
			add(credits2);
			add(credits3);
			add(fadeScreen);
			add(frame);


			//DEBUG
			//add(debug);
			
			
		}
		
		override public function update():void{

			// visibility and collision
			//if ((player.x > 140) || player.y < 210) houseOutside.visible = false;
			if (FlxCollision.pixelPerfectCheck(player, houseOutside)) houseOutside.visible = path.visible = false;
			else houseOutside.visible = path.visible = true;
			if (houseOutside.visible == true){
				npcGroup.visible = false;
			}
			else npcGroup.visible = true;
			
			// graphic layers
			
			add(frame);
			add(textbox);
			add(path);
			add(houseInside);
			
			remove(houseOutside);
			remove(fadeScreen);
			for (var i:int = 0; i<npcGroup.members.length; i++){
				if (FlxCollision.pixelPerfectCheck(player, npcGroup.members[i])){
					remove(player);
					// if npc is behind player, add player on top
					if (npcGroup.members[i].y + npcGroup.members[i].height < player.y + player.height){
						remove(npcGroup.members[i])
						add(npcGroup.members[i]);
						add(player);
					}
					// if player is behind npc, add npc on top
					else{
						remove(npcGroup.members[i])
						add(player);
						add(npcGroup.members[i]);
					}
				}
			}
			add(houseOutside);
			add(fadeScreen);
			
			//start chapter
			chapterStart();
			
			detect();
			if (near) {
				textbox.visible = true;
				boxDialogue.text = "PRESS SPACE TO TALK";
				if (FlxG.keys.justPressed('SPACE') && talking == false) {
					
					talking = true;
					playingSound = true;
				}
				// scroll through text
				if (FlxG.keys.justPressed("SPACE") && talking == true) {
					boxDialogue.y = boxDialogue.y - 20;
				}
			}
			/*
			if (talking){
				if (! playingSound){
					FlxG.play(voice0, .2);
					playingSound = false;
				}
			}
			*/
			else textbox.visible = false;
			
			
			//choose whose dialogue to use
			for (var i:int = 0; i<npcGroup.members.length; i++){
				if (npcGroup.members[i].near && talking) boxDialogue.text = npcGroup.members[i].textArray[npcGroup.members[i].charIndex][level];
				//else if (level == 4 && near) boxDialogue.text = player.textArray[player.charIndex][4];
			}
			
			if (boxDialogue.y < -boxDialogue.height){
				killAll();
			}
			
			// frame collision
			FlxG.collide(player, frame);
			frameTop.y = 0;
			frameRight.x = FlxG.width - 1;
			frameBottom.y = FlxG.height - 1;
			frameLeft.x = 0; 
			for (var i:int = 0; i<frame.members.length; i++){
				frame.members[i].velocity.x = 0;
			}
			
			
			//music
			//DEBUG
			debug.text = String(int(player.x)) + "\n" + String(int(player.y)) ;
			credits1.text = "ZEKE VIRANT: graphics, writing, music";
			credits2.text = "DECKMAN COSS: programming" 
			credits3.text = "ERIC BERGEN: \nsound design, music, programming";
			super.update();
		}
		
		public function detect():void{
			for (var i:int = 0; i < 4; i++){
				if ((Math.abs(player.x - npcGroup.members[i].x) < 30 && Math.abs(player.y - npcGroup.members[i].y) < 15) && npcGroup.members[i].alive ){
					near = true;
					npcGroup.members[i].near = true;
					return;
				}
				
				//else if (level == 4 && (player.x > 160 && player.x > 200) && player.y < 210){
				//	near = true;
				//}
				else near = false;
				npcGroup.members[i].near = false;

			}
		}
		
		public function killAll():void{
			spawnTimer = spawnTimer + FlxG.elapsed;
			player.alpha = player.alpha - .1;
			if (player.alpha == 0) fadeScreen.alpha = fadeScreen.alpha + .01;
			//FlxG.music.volume = FlxG.music.volume - .05
			// after fadeout
			if (spawnTimer >= 3){
				spawnTimer = 0;
				// reset alphas
				fadeScreen.alpha = 0;
				player.alpha = 1;
				// reset text
				boxDialogue.y = boxFrame.y + 20;
				talking = false;
				boxDialogue.text = "PRESS SPACE TO TALK";
				// chapter text
				chapterTimer = 0;
				
				//end music
				FlxG.music.stop();
				playingMusic = false;
				//respawn player position and change character
				steal();
				player.x = spawnX;
				player.y = spawnY;
				// next level
				level = level + 1;
				if (level > 4) FlxG.resetGame();
			}
		}
		
		public function steal():void{
			// function to steal body from NPC, then 'kill' NPC
			for (var i:int = 0; i < 4; i++){
				if (npcGroup.members[i].near){
					
					if (npcGroup.members[i].character == "southern") {
						player.loadGraphic(player.southernSprite, true, true, 14, 32);
					}
					else if (npcGroup.members[i].character == "old") {
						player.loadGraphic(player.oldSprite, true, true, 13, 39);
						
					}
					else if (npcGroup.members[i].character == "cool") {
						player.loadGraphic(player.coolSprite, true, true, 16, 35);
						
					}
					else if (npcGroup.members[i].character == "fat") {
						player.loadGraphic(player.fatSprite, true, true, 19, 33);
						
					}
					// if before level 4 (chapter 3), kill character)
					if (level < 3)npcGroup.members[i].kill();
					// else make invisible
					else (npcGroup.members[i].alpha = 0);
				}
			}
		}
		
		public function chapterStart():void{
			var skip:Boolean;
			chapterTimer = chapterTimer + FlxG.elapsed;
			if (level == 0) {
				chapterText.text = 'PROLOGUE: DEATH\nYOU HAVE KILLED YOURSELF AGAINST YOUR WILL. YOU ARE IN BIG HELL.';
				if (! playingMusic){
					FlxG.playMusic(level0Music, .5);
					playingMusic = true;
				}
			}			
			else if (level == 1) {
				chapterText.text = 'CHAPTER 1: PAIN';
				if (! playingMusic){
					FlxG.playMusic(level1Music, .5);
					playingMusic = true;
				}
			}
			else if (level == 2) {
				chapterText.text = 'CHAPTER 2: HAPPINESS';
				if (! playingMusic){
					FlxG.playMusic(level2Music, .5);
					playingMusic = true;
				}
			}
			else if (level == 3) {
				chapterText.text = 'CHAPTER 3: NON SEQUITUR';
				if (! playingMusic){
					FlxG.playMusic(level3Music, .5);
					playingMusic = true;
				}
			}
			else if (level == 4){ 
				chapterText.text = 'CHAPTER 4: LONELINESS';
				if (! playingMusic){
					FlxG.playMusic(level4Music, .7);
					playingMusic = true;
				}
			}
			
			if (FlxG.keys.SPACE) skip = true;
			if (chapterTimer > 4){
				chapterText.alpha = 0;
			} 
			else chapterText.alpha = 1;

		}
		
	}
}