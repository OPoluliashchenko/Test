package  
{
	/**
	 * ...
	 * @author JHBF
	 */
	public class NewClass 
	{
		
		public function NewClass() 
		{
			trace("START");
			var arr:Array = [2, 4, 3, 6, 1, 7, 5];
			for (var i = 0; i < arr.length; i++) {
				var minNumber:int = i;
				for (var j = i + 1; j < arr.length; j++) {
					if (arr[minNumber] > arr[j]) {
						minNumber = j;
					}
				}
				if (minNumber != i) {
					var currentNumber:Number = arr[minNumber];
					arr.splice(minNumber, 1);
					arr.splice(i, 0, currentNumber);
				}
			}
			for (i = 0; i < arr.length; i++) {
				trace(arr[i]);
			}
		}
		
	}

}