package org.jhbf.tetris.tetrisField 
{
	import flash.display.*;
	import flash.events.*;
	//import flash.ui.*;
	import org.jhbf.tetris.eventDispatcher.*;
	
	/**
	 * ...
	 * @author 
	 */
	public class KeyBoard extends Sprite
	{
		
		public function KeyBoard() 
		{
			Main.STAGE_LINK.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
		}
		//--------------------------------------------------------------------------
		//
		//  Events handlers
		//
		//--------------------------------------------------------------------------
		public function KeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 37)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.LEFT));
			}
			
			if (event.keyCode == 38)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.UP));
			}
			
			if (event.keyCode == 39)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.RIGHT));
			}
			
			if (event.keyCode == 40)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.DOWN));
			}
			
			if (event.keyCode == 65)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.LEFT));
			}
			
			if (event.keyCode == 87)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.UP));
			}
			
			if (event.keyCode == 68)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.RIGHT));
			}
			
			if (event.keyCode == 83)
			{
				GlobalDispatcher.dispatcher(new GameEvent(EventConstants.DOWN));
			}
		}
		
	}

}