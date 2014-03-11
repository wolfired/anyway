package anyway.events {

	public class AWEventRouter {

		public static var _instance:AWEventRouter;

		public static function get instance():AWEventRouter {
			return _instance;
		}

		public function AWEventRouter() {
			_event_map = {};

			_instance = this;
		}

		private var _event_map:Object;

		public function addEventListener(eventType:String, listener:Function):void {
			if(_event_map[eventType] == null) {
				_event_map[eventType] = new Vector.<Function>();
			}

			var listener_vec:Vector.<Function> = _event_map[eventType] as Vector.<Function>;

			var idx:int = listener_vec.indexOf(listener);

			if(idx == -1) {
				listener_vec.push(listener);
			}
		}

		public function delEventListener(eventType:String, listener:Function):void {
			if(_event_map[eventType] == null) {
				return;
			}

			var listener_vec:Vector.<Function> = _event_map[eventType] as Vector.<Function>;

			var idx:int = listener_vec.indexOf(listener);

			if(idx == -1) {
				return;
			}

			listener_vec.splice(idx, 1);
		}

		public function delEventListeners(eventType:String):void {
			if(_event_map[eventType] == null) {
				return;
			}

			delete _event_map[eventType];
		}

		public function routeEvent(event:AWEvent):void {
			if(_event_map[event.eventType] == null) {
				return;
			}

			var listener_vec:Vector.<Function> = _event_map[event.eventType] as Vector.<Function>;

			for(var i:int = 0; i < listener_vec.length; ++i) {
				listener_vec[i](event);
			}
		}
	}
}
