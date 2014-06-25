package org.jhbf.tetris.tetrisShape 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author JHBF
	 */
	public class Shape_3 implements IShape 
	{
		private const ARR_SHAPE_1:Array = [new Point(4, 0), new Point(4, 1), new Point(4, 2), new Point(5, 1)]; /* of Point */
		private const ARR_SHAPE_2:Array = [new Point(1, 1), new Point(0, 0), new Point( -1, -1), new Point( -1, 1)]; /* of Point */
		private const ARR_SHAPE_3:Array = [new Point(-1, 1), new Point(0, 0), new Point( 1, -1), new Point( -1, -1)]; /* of Point */		
		private const ARR_SHAPE_4:Array = [new Point( -1, -1), new Point(0, 0), new Point( 1, 1), new Point( 1, -1)]; /* of Point */
		private const ARR_SHAPE_5:Array = [new Point(1, -1), new Point(0, 0), new Point( -1, 1), new Point( 1, 1)]; /* of Point */
		private var _numStates:int = 5;
		private var _currentState:int = 1;
		private var _id:int = 3;
		
		public function Shape_3() 
		{
			
		}
				
		/* INTERFACE tetrisShape.IShape */
		//--------------------------------------------------------------------------
		//
		//  Getters&setters
		//
		//--------------------------------------------------------------------------
		public function getIdCells(id:int = 1):Array 
		{
			return this['ARR_SHAPE_' + id];
		}
		
		public function getNumStates():int 
		{
			return _numStates;
		}
		
		public function getId():int 
		{
			return _id;
		}
		
		public function getCurrentStates():int 
		{
			return _currentState;
		}
		
		public function setStates(value:int = 1):void 
		{
			_currentState = value;
		}
		
	}

}