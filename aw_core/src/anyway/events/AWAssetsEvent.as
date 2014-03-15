package anyway.events {

	public class AWAssetsEvent extends AWEvent {
		/**
		 * @see anyway.manager.asset.AWAssets
		 */		
		public static const EVT_PROGRESS:String = "AWAssetsEvent_EVT_PROGRESS";
		public static const EVT_COMPLETE:String = "AWAssetsEvent_EVT_COMPLETE";

		public function AWAssetsEvent(eventType:String, payload:* = null) {
			super(eventType, payload);
		}
		
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
	}
}
