package anyway.model.obj {

	import flash.utils.ByteArray;
	import anyway.model.AWModelParser;

	public class AWModelParser4Obj extends AWModelParser {
		/*This code gen by AWToolUtil::genSignCode()*/
		private static const SIGN_CR:uint = 13; //\r
		private static const SIGN_LF:uint = 10; //\n
		private static const SIGN_SPACE:uint = 10; //space
		private static const SIGN_POUND:uint = 35; //#
		private static const SIGN_MINUS:uint = 45; //-
		private static const SIGN_POINT:uint = 46; //.
		private static const SIGN_V:uint = 118; //v
		private static const SIGN_T:uint = 116; //t
		private static const SIGN_N:uint = 110; //n
		private static const SIGN_F:uint = 102; //f

		public function AWModelParser4Obj() {
		}

		/*------------------------------------------*/

		private const _struct:AWModelStruct4Obj = new AWModelStruct4Obj();

		override public function parser(bytes:ByteArray):void {
			_bytes = bytes;
			_bytes.position = 0;

			var byte:uint = 0;

			while(_bytes.bytesAvailable > 0) {
				byte = _bytes.readUnsignedByte();

				switch(byte) {
					case SIGN_V: {
						this.handler_vertex();
						break;
					}
					case SIGN_F: {
						this.handler_face();
						break;
					}
					default: {
						this.fastForward();
						break;
					}
				}
			}
		}

		private function handler_vertex():void {
			var byte:uint = 0;

			while(true) {
				byte = _bytes.readUnsignedByte();
			}
		}

		private function handler_face():void {
			var begin:uint = _bytes.position;

			while(!this.endline()) {
			}

			var end:uint = _bytes.position;

			_bytes.position = begin;
			trace(_bytes.readUTFBytes(end - begin));
			_bytes.position = end;
		}

		private function fastForward():void {
			while(!this.endline()) {
			}
		}

		private function endline():Boolean {
			var byte:uint = _bytes.readUnsignedByte();

			if(SIGN_LF == byte) {
				return true;
			} else if(SIGN_CR == byte) {
				_bytes.readUnsignedByte();
				return true;
			}
			return false;
		}
	}
}
