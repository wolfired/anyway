package anyway.model {

	import flash.utils.ByteArray;

	public class AWModelParser {

		public function AWModelParser() {
		}

		protected var _bytes:ByteArray;

		public function parser(bytes:ByteArray):void {
			SWITCH::debug {
				throw new Error("override by subclass");
			}
		}
	}
}
