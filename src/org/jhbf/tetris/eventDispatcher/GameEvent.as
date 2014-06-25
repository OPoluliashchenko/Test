package org.jhbf.tetris.eventDispatcher 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class GameEvent extends Event
	{
		public var param:Array;
		
		public function GameEvent(type:String, par:Array = null, bubbles:Boolean = false, concelable:Boolean = false) 
		{
			param = par;
			super(type, bubbles, concelable);
		}
		
	}

}