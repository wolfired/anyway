package anyway.model.obj {

	import flash.utils.ByteArray;
	
	import anyway.model.AWModelParser;
	import anyway.model.AWModelStruct;

	public class AWModelParser4Obj extends AWModelParser {
		
		private static const SIGN_CR:uint = 0xD; //\r
		private static const SIGN_LF:uint = 0xA; //\n
		private static const SIGN_SPACE:uint = 0x20; //space
		private static const SIGN_POUND:uint = 0x23; //#
		private static const SIGN_MINUS:uint = 0X2D; //-
		private static const SIGN_POINT:uint = 0x2E; //.
		private static const SIGN_V:uint = 0x76; //v
		private static const SIGN_T:uint = 0x74; //t

		private const _handler_map:Array = [];
		
		public function AWModelParser4Obj() {
			_handler_map[SIGN_V] = handler_vertex;
			_handler_map[SIGN_T] = handler_triangle;
		}

		override public function parser(bytes:ByteArray):AWModelStruct {
			var struct:AWModelStruct4Obj = new AWModelStruct4Obj();
			
			bytes.position = 0;

			var byte:uint = 0;
			var handler:Function;
			while(bytes.bytesAvailable > 0) {
				byte = bytes.readUnsignedByte();
				(handler = _handler_map[byte]) && handler(bytes, struct);
			}
			
			return struct;
		}

		private function handler_vertex(bytes:ByteArray, struct:AWModelStruct4Obj):void {
			var temp:ByteArray = new ByteArray();
			var byte:uint;
			while(true){
				byte = bytes.readUnsignedByte();
				if(SIGN_CR == byte || SIGN_LF == byte){
					break;
				}
				
				if(SIGN_SPACE == byte && 0 < temp.length){
					temp.position = 0;
					struct.vertexData.push(parseFloat(temp.readUTFBytes(temp.bytesAvailable)));
					temp.clear();
				}
				
				temp.writeByte(byte);
			}
			
			temp.position = 0;
			struct.vertexData.push(parseFloat(temp.readUTFBytes(temp.bytesAvailable)));
			temp.clear();
		}

		private function handler_triangle(bytes:ByteArray, struct:AWModelStruct4Obj):void {
			var temp:ByteArray = new ByteArray();
			var byte:uint;
			while(true){
				byte = bytes.readUnsignedByte();
				if(SIGN_CR == byte || SIGN_LF == byte){
					break;
				}
				
				if(SIGN_SPACE == byte && 0 < temp.length){
					temp.position = 0;
					struct.indexData.push(parseInt(temp.readUTFBytes(temp.bytesAvailable)));
					temp.clear();
				}
				
				temp.writeByte(byte);
			}
			
			temp.position = 0;
			struct.indexData.push(parseInt(temp.readUTFBytes(temp.bytesAvailable)));
			temp.clear();
		}
	}
}
