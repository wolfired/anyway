package anyway.events {

	import anyway.core.ns_aw;
	
	use namespace ns_aw;

	public class AWAssetsEvent extends AWEvent {
		public static const EVT_PROGRESS:String = "AWAssetsEvent_EVT_PROGRESS";
		public static const EVT_COMPLETE:String = "AWAssetsEvent_EVT_COMPLETE";

		public function AWAssetsEvent(eventType:String, payload:* = null) {
			super(eventType, payload);
		}

		ns_aw var _bytesLoaded:Number;
		ns_aw var _bytesTotal:Number;

		public function get bytesLoaded():Number {
			return _bytesLoaded;
		}

		public function get bytesTotal():Number {
			return _bytesTotal;
		}
	}
}
