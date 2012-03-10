package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	[SWF(width="443", height="340", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class big_hell extends FlxGame
	{
		public function big_hell()
		{
			super(443, 340, PlayState);
		}
	}
}