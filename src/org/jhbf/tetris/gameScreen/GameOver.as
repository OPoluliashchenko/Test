package org.jhbf.tetris.gameScreen 
{
	import flash.events.MouseEvent;
	import org.jhbf.tetris.eventDispatcher.*;
	/**
	 * ...
	 * @author JHBF
	 */
	public class GameOver extends McGameOver 
	{
		
		public function GameOver() 
		{
			super();
			toMenu.addEventListener(MouseEvent.CLICK, toMenuHandler);
		}
		//--------------------------------------------------------------------------
		//
		//  Getters&setters
		//
		//--------------------------------------------------------------------------
		private function toMenuHandler(event:MouseEvent):void 
		{
			toMenu.removeEventListener(MouseEvent.CLICK, toMenuHandler);
			GlobalDispatcher.dispatcher(new GameEvent(EventConstants.RESTART));
		}
		
	}

}