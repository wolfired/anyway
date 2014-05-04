package anyway.events {

	public class AWEventRouter {

		public static var _instance:AWEventRouter;

		public static function get instance():AWEventRouter {
			return _instance;
		}

		public function AWEventRouter() {
			SWITCH::debug{
				if(null != _instance){
					throw new Error("Duplicate instance AWEventRouter");
				}
			}
			
			_event_map = {};

			_instance = this;
		}

		private var _event_map:Object;

		public function addEventListener(eventType:String, listener:Function):void {
			if(null == _event_map[eventType]) {
				_event_map[eventType] = new Vector.<Function>();
			}

			var listener_vec:Vector.<Function> = _event_map[eventType] as Vector.<Function>;

			var idx:int = listener_vec.indexOf(listener);

			if(-1 == idx) {
				listener_vec.push(listener);
			}
		}

		public function delEventListener(eventType:String, listener:Function):void {
			if(null == _event_map[eventType]) {
				return;
			}

			var listener_vec:Vector.<Function> = _event_map[eventType] as Vector.<Function>;

			var idx:int = listener_vec.indexOf(listener);

			if(-1 == idx) {
				return;
			}

			listener_vec.splice(idx, 1);
		}

		public function delEventListeners(eventType:String):void {
			if(null == _event_map[eventType]) {
				return;
			}

			delete _event_map[eventType];
		}

		public function routeEvent(event:AWEvent):void {
			if(null == _event_map[event.eventType]) {
				return;
			}

			var listener_vec:Vector.<Function> = _event_map[event.eventType] as Vector.<Function>;

			for each (var listener:Function in listener_vec){
				listener(event);
			}
		}
	}
}
