package org.jhbf.tetris.box
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author JHBF
	 */
	public class TetrisBox extends Box 
	{
		private var _state:int = 0;
		
		public function TetrisBox(point:Point) 
		{
			super();
			this.x = point.x;
			this.y = point.y;
		}
		//--------------------------------------------------------------------------
		//
		//  Getters&setters
		//
		//--------------------------------------------------------------------------
		public function getState():int
		{
			return _state;
		}
		
		public function setAddCell():void
		{
			this.gotoAndStop(2);
			_state = 1;
		}
		
		public function setRemoveCell():void
		{
			this.gotoAndStop(1);
			_state = 0;
		}
		
	}

}