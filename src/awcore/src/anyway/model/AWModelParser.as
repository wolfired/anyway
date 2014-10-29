package anyway.model {

	import flash.utils.ByteArray;

	public class AWModelParser {

		public function AWModelParser() {
		}

		public function parser(bytes:ByteArray):AWModelStruct {
			SWITCH::debug {
				throw new Error("override by subclass");
			}
		}
	}
}
