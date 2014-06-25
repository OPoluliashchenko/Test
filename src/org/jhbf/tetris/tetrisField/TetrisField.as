package org.jhbf.tetris.tetrisField 
{
	import org.jhbf.tetris.box.TetrisBox;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.jhbf.tetris.eventDispatcher.*;
	import org.jhbf.tetris.gameScreen.GameOver;
	import org.jhbf.tetris.tetrisShape.*;
	/**
	 * ...
	 * @author JHBF
	 */
	public class TetrisField extends Field 
	{
		private var _arrBoxes:Array = []; /* of TetrisBox */
		private var _arrCurrentShape:Array = []; /* of Point */
		private var _timerToMove:Timer = new Timer(500);
		private var _shape:IShape;
		private var _score:Number = 0;
		private var _gameOver:GameOver;
		private var _ranomId:int = 1;
		
		public  function TetrisField() 
		{
			super();
			this.x = 175;
			this.y = 50;
			Main.STAGE_LINK.addChild(this);
			GlobalDispatcher.listen(EventConstants.LEFT, leftHandler);
			GlobalDispatcher.listen(EventConstants.RIGHT, rightHandler);
			GlobalDispatcher.listen(EventConstants.DOWN, downHandler);
			GlobalDispatcher.listen(EventConstants.UP, upHandler);
			startBtn.addEventListener(MouseEvent.CLICK, startBtnHandler);
			nextShape.visible = false;
		}
		//--------------------------------------------------------------------------
		//
		//  Getters&setters
		//
		//--------------------------------------------------------------------------
		private function getIdShape():int 
		{
			return Math.floor(1 + Math.random() * 7);
		}
		//--------------------------------------------------------------------------
		//
		//  Events handlers
		//
		//--------------------------------------------------------------------------
		private function startBtnHandler(event:MouseEvent):void 
		{
			startBtn.removeEventListener(MouseEvent.CLICK, startBtnHandler);
			this.removeChild(startBtn);
			_ranomId = getIdShape();
			nextShape.visible = true;
			addBox();
		}
		
		private function timerToMoveHandler(event:TimerEvent):void 
		{
			removeShape();
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++) 
			{
				q = _arrCurrentShape[i].x;
				w = _arrCurrentShape[i].y + 1;
				if ((_arrBoxes[q].length) <= w || _arrBoxes[q][w].getState() == 1) 
				{
					_timerToMove.removeEventListener(TimerEvent.TIMER, timerToMoveHandler);
					_timerToMove.stop();
					drawShape();
					_arrCurrentShape.splice(0);
					verificationOFResult();
					_timerToMove.addEventListener(TimerEvent.TIMER, timerToMoveHandler);
					_timerToMove.start();
					createShape();
					return;
				}
			}
			for (i = 0; i < n; i++) 
			{
				_arrCurrentShape[i].y += 1;
			}
			drawShape();
		}
		
		private function leftHandler(event:GameEvent):void 
		{
			moveForPresKey(-1);
		}
		
		private function rightHandler(event:GameEvent):void 
		{
			moveForPresKey(1);
		}
		
		private function downHandler(event:GameEvent):void 
		{
			timerToMoveHandler(null);
		}
		
		private function upHandler(event:GameEvent):void 
		{
			removeShape();
			if (_shape.getCurrentStates() < _shape.getNumStates()) 
			{
				addShape(_shape.getCurrentStates() + 1);
			}
			else
			{
				addShape(2);
			}
		}
		
		private function restartHandler(event:GameEvent):void 
		{
			for (var i:int = 0; i < _arrBoxes.length; i++) 
			{
				for (var j:int = 0; j < _arrBoxes[i].length; j++)
				{
					this.removeChild(_arrBoxes[i][j]);
				}
			}
			_arrBoxes.splice(0);
			_arrCurrentShape.splice(0);
			_shape = null;
			_score = 0;
			scoreTxt.text = String(0);
			this.removeChild(_gameOver);
			_gameOver = null;
			GlobalDispatcher.listen(EventConstants.LEFT, leftHandler);
			GlobalDispatcher.listen(EventConstants.RIGHT, rightHandler);
			GlobalDispatcher.listen(EventConstants.DOWN, downHandler);
			GlobalDispatcher.listen(EventConstants.UP, upHandler);
			GlobalDispatcher.remove(EventConstants.RESTART, restartHandler);
			startBtn.addEventListener(MouseEvent.CLICK, startBtnHandler);
			nextShape.visible = false;
			this.addChild(startBtn);
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		private function addBox():void 
		{
			for (var i:int = 0; i < 10; i++) 
			{
				var arrBoxesInLine:Array = [];
				for (var j:int = 0; j < 15; j++) 
				{
					var tetrisBox:TetrisBox = new TetrisBox(new Point(i * 20, j * 20));
					this.addChild(tetrisBox);
					arrBoxesInLine.push(tetrisBox);
				}
				_arrBoxes[i] = arrBoxesInLine;
			}
			createShape();
			_timerToMove.addEventListener(TimerEvent.TIMER, timerToMoveHandler);
			_timerToMove.start();
			
		}
		
		private function createShape():void 
		{
			switch(_ranomId)
			{
				case 1:
					_shape = new Shape_1();
					break;
				case 2:
					_shape = new Shape_2();
					break;
				case 3:
					_shape = new Shape_3();
					break;
				case 4:
					_shape = new Shape_4();
					break;
				case 5:
					_shape = new Shape_5();
					break;
				case 6:
					_shape = new Shape_6();
					break;
				case 7:
					_shape = new Shape_7();
					break;
			}
			_ranomId = getIdShape();
			nextShape.gotoAndStop(_ranomId);
			addShape();
		}
		
		private function addShape(id:int = 1):void 
		{
			var arrId:Array = _shape.getIdCells(id);
			if (id == 1)
			{
				_arrCurrentShape.splice(0);
				_arrCurrentShape = arrId.slice(0);
				if (stopGame() == true)
				{
					removeAllHandler();
					return;
				}
			}
			else 
			{
				var n:int = _arrCurrentShape.length;
				var q:int;
				var w:int;
				for (var i:int = 0; i < n; i++) 
				{
					q = _arrCurrentShape[i].x + arrId[i].x;
					w = _arrCurrentShape[i].y + arrId[i].y;
					if (q < 0) 
					{
						helpWithRotationShape(id, true);
						return;
					}
					if (q > _arrBoxes.length - 1) 
					{
						helpWithRotationShape(id, false, true);
						return;
					}
					try{
						if (_arrBoxes[q][w].getState() == 1) 
						{
							if (q < _arrCurrentShape[i].x)
							{
								helpWithRotationShape(id, true);
							}
							if (q > _arrCurrentShape[i].x)
							{
								helpWithRotationShape(id, false, true);
							}
							return;
						}
					}
					catch (e:*) 
					{
						drawShape();
						return;
					}
				}
				for (i = 0; i < n; i++) 
				{
					_arrCurrentShape[i].x += arrId[i].x;
					_arrCurrentShape[i].y += arrId[i].y;
				}
			}
			_shape.setStates(id);
			drawShape(); 
		}
		
		private function stopGame():Boolean 
		{
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++) 
			{
				q = _arrCurrentShape[i].x;
				w = _arrCurrentShape[i].y;
				if (_arrBoxes[q][w].getState() == 1) 
				{
					return true;
				}
			}
			return false;
		}
		
		private function helpWithRotationShape(id:int, toRight:Boolean = false, toLeft:Boolean = false):void
		{
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++)
			{
				w = _arrCurrentShape[i].y;
				if (toRight) 
				{
					q = _arrCurrentShape[i].x + 1;
					try
					{
						if (_arrBoxes[q][w].getState() == 1) 
						{
							drawShape();
							return;
						}
					}
					catch (e:*) 
					{
						drawShape();
						return;
					}
				}
				if (toLeft) 
				{
					q = _arrCurrentShape[i].x - 1;
					try
					{
						if (_arrBoxes[q][w].getState() == 1) 
						{
							drawShape();
							return;
						}
					}
					catch (e:*) 
					{
						drawShape();
						return;
					}
				}
			}
			for (i = 0; i < n; i++) 
			{
				if (toRight) 
				{
					_arrCurrentShape[i].x += 1;
				}
				if (toLeft) 
				{
					_arrCurrentShape[i].x -= 1;
				}
			}
			addShape(id);
		}
		
		private function drawShape():void 
		{
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++) 
			{
				q = _arrCurrentShape[i].x;
				w = _arrCurrentShape[i].y;
				_arrBoxes[q][w].setAddCell();
			}
		}
		
		private function removeShape():void 
		{
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++) 
			{
				q = _arrCurrentShape[i].x;
				w = _arrCurrentShape[i].y;
				_arrBoxes[q][w].setRemoveCell();
			}
		}
		
		private function verificationOFResult():void 
		{
			var countRemoveString:Number = 0;
			var countForGeomProgress:Number = 50;
			var scoreInRaund:Number = 0;
			for (var i:int = 0; i < _arrBoxes[0].length ; i++) 
			{
				var countCellsInLine:int = 0;
				for (var j:int = 0; j < _arrBoxes.length; j++) 
				{
					if (_arrBoxes[j][i].getState() == 1)
					{
						countCellsInLine++;
					}
				}
				if (countCellsInLine == _arrBoxes.length) 
				{
					for (j = 0; j < _arrBoxes.length; j++) 
					{
						_arrBoxes[j][i].setRemoveCell();
					}
					shiftCells(i);
					countRemoveString++;
				}
			}
			for (i = 0; i < countRemoveString; i++) 
			{
				countForGeomProgress = countForGeomProgress * 2;
				scoreInRaund += countForGeomProgress;
			}
			_score += scoreInRaund;
			scoreTxt.text = String(_score);
		}
		
		private function shiftCells(numString:int):void 
		{
			for (var i:int = numString - 1; i > -1 ; i--) 
			{
				for (var j:int = 0; j < _arrBoxes.length; j++) 
				{
					if (_arrBoxes[j][i].getState() == 1) 
					{
						_arrBoxes[j][i].setRemoveCell();
						_arrBoxes[j][i + 1].setAddCell();
					}
				}
			}
		}
		
		private function moveForPresKey(a:int = 0):void 
		{
			removeShape();
			var n:int = _arrCurrentShape.length;
			var q:int;
			var w:int;
			for (var i:int = 0; i < n; i++)
			{
				if (_arrCurrentShape[i].x + a > -1 && _arrCurrentShape[i].x + a < _arrBoxes.length) 
				{
					q = _arrCurrentShape[i].x + a;
				}
				else 
				{
					q = _arrCurrentShape[i].x;
					drawShape();
					return;
				}
				w = _arrCurrentShape[i].y;
				if (_arrBoxes[q][w].getState() == 1) 
				{
					drawShape();
					return;
				}
			}
			for (i = 0; i < n; i++) 
			{
				if (_arrCurrentShape[i].x + a > -1 && _arrCurrentShape[i].x + a < _arrBoxes.length) 
				{
					_arrCurrentShape[i].x += a;
				}
			}
			drawShape();
		}
		
		private function removeAllHandler():void 
		{
			_timerToMove.removeEventListener(TimerEvent.TIMER, timerToMoveHandler);
			_timerToMove.stop();
			GlobalDispatcher.remove(EventConstants.LEFT, leftHandler);
			GlobalDispatcher.remove(EventConstants.RIGHT, rightHandler);
			GlobalDispatcher.remove(EventConstants.DOWN, downHandler);
			GlobalDispatcher.remove(EventConstants.UP, upHandler);
			GlobalDispatcher.listen(EventConstants.RESTART, restartHandler);
			_gameOver = new GameOver();
			this.addChild(_gameOver);
		}
		
	}

}