package org.jhbf.tetris.tetrisShape 
{
	
	/**
	 * ...
	 * @author JHBF
	 */
	public interface IShape 
	{
		function getIdCells(id:int = 1):Array;
		function getNumStates():int;
		function getCurrentStates():int;
		function getId():int;
		function setStates(id:int = 1):void;
	}
	
}