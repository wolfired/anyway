package anyway.manager {

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	[Event(name="EVT_COMPLETE", type="anyway.events.AWAssetsEvent")]
	[Event(name="EVT_PROGRESS", type="anyway.events.AWAssetsEvent")]
	public class AWAssetsManager {
		private static var _instance:AWAssetsManager;

		private static const STATUS_IDLE:uint = 1 << 0;
		private static const STATUS_BUSY:uint = 1 << 1;

		public static function get instance():AWAssetsManager {
			return _instance;
		}

		public function AWAssetsManager() {
			_status = STATUS_IDLE;

			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);

			_task_queue = new Vector.<AWAssets>();

			_assets_map = {};

			_instance = this;
		}

		private var _status:uint;
		private var _urlLoader:URLLoader;
		private var _task_queue:Vector.<AWAssets>;
		private var _assets_map:Object;

		public function fetch(url:String, callback:Function = null, type:String = URLLoaderDataFormat.TEXT):AWAssets {
			var task:AWAssets = _assets_map[url] as AWAssets;

			if(null == task) {
				task = new AWAssets(url, type);
			}

			if(null != callback && null != task.data) {
				callback(task);
			}

			_task_queue.push();

			if(STATUS_IDLE == _status) {
				_status = STATUS_BUSY;
				this.loop();
			}

			return task;
		}

		private function loop():void {
			if(0 < _task_queue.length) {
				_urlLoader.dataFormat = _task_queue[0].type;
				_urlLoader.load(_task_queue[0].urlRequest);
			} else {
				_status = STATUS_IDLE;
			}
		}

		private function onProgress(event:ProgressEvent):void {

		}

		private function onComplete(event:Event):void {
			var task:AWAssets = _task_queue.shift();
			task._status =  AWAssets.STATUS_DONE;
			task._data = _urlLoader.data;

			_assets_map[task._url] = task;

			this.loop();
		}
	}
}
