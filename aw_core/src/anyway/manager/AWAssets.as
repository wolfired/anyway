package anyway.manager {

	import flash.net.URLRequest;

	public class AWAssets {
		internal static const STATUS_NULL:uint = 1 << 0;
		internal static const STATUS_DONE:uint = 1 << 1;

		public function AWAssets(url:String, type:String) {
			_status = STATUS_NULL;
			_url = url;
			_type = type;
		}

		internal var _status:uint;
		internal var _url:String;
		internal var _type:String;
		internal var _data:*;

		public function get urlRequest():URLRequest {
			return new URLRequest(_url);
		}
		
		public function get isDone():void{
			return _status == STATUS_DONE;
		}
		
		public function get data():*{
			return _data;
		}
	}
}
