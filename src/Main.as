package 
{
	import org.jhbf.tetris.box.TetrisBox;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.jhbf.tetris.gameScreen.NewGameScreen;
	import org.jhbf.tetris.eventDispatcher.*;
	import org.jhbf.tetris.tetrisField.KeyBoard;
	import org.jhbf.tetris.tetrisField.TetrisField;
	//import flash.geom.Point;
	
	/**
	 * ...
	 * @author JHBF
	 */
	public class Main extends Sprite 
	{
		public static var STAGE_LINK:Stage;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//--------------------------------------------------------------------------
		//
		//  Events handlers
		//
		//--------------------------------------------------------------------------
		private function init(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			STAGE_LINK = stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var gameScreen:NewGameScreen = new NewGameScreen();
			GlobalDispatcher.listen(EventConstants.START_GAME, startGameHandler);
			//var test = new NewClass();
		}
		
		private function startGameHandler(event:GameEvent):void 
		{
			var tetrisField:TetrisField = new TetrisField();
			var keyBoard:KeyBoard = new KeyBoard();
		}
		
	}
	
}