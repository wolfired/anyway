package anyway.utils {

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import anyway.events.AWAssetsEvent;
	import anyway.events.AWEventRouter;

	[Event(name="EVT_COMPLETE", type="anyway.events.AWAssetsEvent")]
	[Event(name="EVT_PROGRESS", type="anyway.events.AWAssetsEvent")]
	public class AWAssetsUtil {
		private static var _instance:AWAssetsUtil;

		private static const STATUS_IDLE:uint = 1 << 0;
		private static const STATUS_BUSY:uint = 1 << 1;

		public static function get instance():AWAssetsUtil {
			return _instance;
		}

		public function AWAssetsUtil() {
			_status = STATUS_IDLE;

			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);

			_task_queue = new Vector.<AWTask>();

			_assets_map = {};

			_instance = this;
		}

		private var _status:uint;
		private var _urlLoader:URLLoader;
		private var _task_queue:Vector.<AWTask>;
		private var _assets_map:Object;

		public function fetch(url:String, callback:Function = null, type:String = URLLoaderDataFormat.TEXT):AWTask {
			var task:AWTask = _assets_map[url] as AWTask;

			if(null == task) {
				task = new AWTask(url, callback, type);
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
			var evt:AWAssetsEvent = new AWAssetsEvent(AWAssetsEvent.EVT_PROGRESS, event);
			AWEventRouter.instance.routeEvent(evt);
		}

		private function onComplete(event:Event):void {
			var task:AWTask = _task_queue.shift();
			task.data = _urlLoader.data;

			_assets_map[task.url] = task;

			this.loop();
		}
	}
}
