package anyway.utils{
	import flash.utils.ByteArray;
	
	import anyway.core.aw_ns;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;

	public class AWFormatUtil{
		private static const MARK:uint = 10;
		
		use namespace aw_ns;
		
		public static function format_number(number:Number):String {
			var temp:Array = number.toFixed(MARK).split(/\./g);
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes("          .0000000000");
			
			bytes.position = MARK - temp[0].length;
			bytes.writeUTFBytes(temp[0]);
			bytes.position = MARK + 1;
			
			if(temp.length > 0) {
				bytes.writeUTFBytes(temp[1]);
			}
			
			bytes.position = 0;
			return bytes.readUTFBytes(bytes.bytesAvailable);
		}
		
		public static function format_vector(vector:AWVector):String {
			return "<" + format_number(vector._raw_data[0]) + ", " + format_number(vector._raw_data[1]) + ", " + format_number(vector._raw_data[2]) + ">";
		}
		
		public static function format_matrix(matrix:AWMatrix):String {
			var result:Vector.<String> = new Vector.<String>();
			
			var temp:Vector.<String>;
			
			for(var row:int = 0; row < 4; ++row) {
				temp = new Vector.<String>();
				
				for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
					temp.push(format_number(matrix._raw_data[row * 4 + cloumn]));
				}
				result.push("[" + temp.join(", ") + "]");
			}
			
			return result.join("\n");
		}
	}
}