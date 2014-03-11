package anyway.utils {

	import flash.net.URLRequest;

	public class AWTask {

		public function AWTask(url:String, callback:Function, type:String) {
			this.url = url;
//			this.callback = callback;
			this.type = type;
		}

		public var url:String;
		public var callback_vec:Vector.<Function>;
		public var type:String;
		public var data:*;

		public function get urlRequest():URLRequest {
			return new URLRequest(url);
		}
	}
}
