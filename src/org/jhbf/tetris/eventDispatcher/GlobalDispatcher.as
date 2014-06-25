package org.jhbf.tetris.eventDispatcher
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class GlobalDispatcher 
	{
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _masDispatcher:Array = [];
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		public static function dispatcher(event:GameEvent):void 
		{
			_dispatcher.dispatchEvent(event);
		}
		
		public static function listen(type:String, handler:Function):void
		{
			_dispatcher.addEventListener(type, handler);
			_masDispatcher.push( {type:type, handler:handler } );
		}
		
		public static function remove(type:String, handler:Function):void
		{
			_dispatcher.removeEventListener(type, handler);
		}
		
	}

}