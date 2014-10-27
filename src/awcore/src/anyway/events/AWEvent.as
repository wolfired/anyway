package anyway.events {

	public class AWEvent {
		public function AWEvent(eventType:String, payload:* = null) {
			_eventType = eventType;
			_payload = payload;
		}

		private var _eventType:String;
		private var _payload:*;

		public function get eventType():String {
			return _eventType;
		}

		public function set eventType(value:String):void {
			if(_eventType == value)
				return;
			_eventType = value;
		}

		public function get payload():* {
			return _payload;
		}

		public function set payload(value:*):void {
			if(_payload == value)
				return;
			_payload = value;
		}
	}
}
