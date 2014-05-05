package anyway.manager.asset {

	import flash.net.URLRequest;

	public class AWAsset {
		private static const STATUS_NULL:uint = 0x1 << 0;
		private static const STATUS_FULL:uint = 0x1 << 1;

		public function AWAsset(url:String, type:String) {
			_status = STATUS_NULL;
			_url = url;
			_type = type;
			_callback_vec = new Vector.<Function>();
		}

		private var _counter:uint;
		private var _status:uint;
		private var _url:String;
		private var _type:String;
		private var _callback_vec:Vector.<Function>;
		private var _data:*;

		public function get isNull():Boolean {
			return STATUS_NULL == _status;
		}

		public function get isFull():Boolean {
			return STATUS_FULL == _status;
		}

		public function get url():String {
			return _url;
		}

		public function get type():String {
			return _type
		}

		public function get data():* {
			return _data;
		}

		/**
		 * @private
		 */
		internal function full():void {
			_status = STATUS_FULL;
		}

		/**
		 * @private
		 */
		internal function get urlRequest():URLRequest {
			return new URLRequest(_url);
		}

		/**
		 * @private
		 */
		internal function pushCallback(callback:Function):void {
			var idx:int = _callback_vec.indexOf(callback);

			if(idx == -1) {
				_callback_vec.push(callback);
			}
		}

		/**
		 * @private
		 */
		internal function invokeCallbacks():void {
			for each(var callback:Function in _callback_vec) {
				callback(this);
			}
		}

		/**
		 * @private
		 */
		internal function emptyCallbacks():void {
			_callback_vec.length = 0;
		}

		/**
		 * @private
		 */
		internal function setData(val:*):void {
			_data = val;
		}
	}
}
