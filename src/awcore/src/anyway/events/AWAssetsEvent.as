package anyway.events {

	import anyway.core.aw_ns;
	
	use namespace aw_ns;

	public class AWAssetsEvent extends AWEvent {
		public static const EVT_PROGRESS:String = "AWAssetsEvent_EVT_PROGRESS";
		public static const EVT_COMPLETE:String = "AWAssetsEvent_EVT_COMPLETE";

		public function AWAssetsEvent(eventType:String, payload:* = null) {
			super(eventType, payload);
		}

		aw_ns var _bytesLoaded:Number;
		aw_ns var _bytesTotal:Number;

		public function get bytesLoaded():Number {
			return _bytesLoaded;
		}

		public function get bytesTotal():Number {
			return _bytesTotal;
		}
	}
}
