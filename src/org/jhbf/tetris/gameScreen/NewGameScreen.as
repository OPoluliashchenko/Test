package org.jhbf.tetris.gameScreen 
{
	import flash.events.MouseEvent;
	import org.jhbf.tetris.eventDispatcher.*;
	/**
	 * ...
	 * @author JHBF
	 */
	public class NewGameScreen extends GameScreen 
	{
		
		public function NewGameScreen() 
		{
			super();
			Main.STAGE_LINK.addChild(this);
			startBtn.addEventListener(MouseEvent.CLICK, onMouseClickHandler);
		}
		//--------------------------------------------------------------------------
		//
		//  Events handlers
		//
		//--------------------------------------------------------------------------
		private function onMouseClickHandler(event:MouseEvent):void 
		{
			this.gotoAndStop("game");
			GlobalDispatcher.dispatcher(new GameEvent(EventConstants.START_GAME));
		}
		
	}

}