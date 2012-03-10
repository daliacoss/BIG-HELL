package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	
	public class TextBox extends FlxGroup
	{
		public var debug:FlxText = new FlxText(2, 20, 100);

		
		public function TextBox(MaxSize:uint=0)
		{
			super(MaxSize);
			
		}
		
		override public function update():void{
			var talking:Boolean = (FlxG.state as PlayState).talking;
			
			if (talking) this.visible = true;
			else this.visible = false;
			
			// DEBUG
			debug.text = String(visible);
			add(debug)
		}

	}
}