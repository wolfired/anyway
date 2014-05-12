package anyway.manager.asset {

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import anyway.core.ns.anyway_internal_events;
	import anyway.events.AWAssetsEvent;
	import anyway.events.AWEventRouter;

	use namespace anyway_internal_events;

	public class AWAssetLoader {
		private static const STATUS_IDLE:uint = 0x1 << 0;
		private static const STATUS_BUSY:uint = 0x1 << 1;

		public function AWAssetLoader(asset_queue:Vector.<AWAsset>) {
			_status = STATUS_IDLE;

			_asset_queue = asset_queue;

			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
		}

		private var _status:uint;
		private var _asset_queue:Vector.<AWAsset>;
		private var _urlLoader:URLLoader;
		private var _asset:AWAsset;

		public function get isIdle():Boolean {
			return STATUS_IDLE == _status;
		}

		public function get isBusy():Boolean {
			return STATUS_BUSY == _status;
		}

		public function busy():void {
			_status = STATUS_BUSY;
		}

		public function load():void {
			if(_asset_queue.length > 0) {
				_asset = _asset_queue.shift();
				_urlLoader.load(_asset.urlRequest);
			} else {
				_status = STATUS_IDLE;
			}
		}

		private function onProgress(event:ProgressEvent):void {
			var evt:AWAssetsEvent = new AWAssetsEvent(AWAssetsEvent.EVT_PROGRESS, _asset);
			evt._bytesLoaded = event.bytesLoaded;
			evt._bytesTotal = event.bytesTotal;
			AWEventRouter.sington.routeEvent(evt);
		}

		private function onComplete(event:Event):void {
			_asset.setData(_urlLoader.data);
			_asset.full();
			_asset.invokeCallbacks();
			_asset.emptyCallbacks();

			var evt:AWAssetsEvent = new AWAssetsEvent(AWAssetsEvent.EVT_COMPLETE, _asset);
			AWEventRouter.sington.routeEvent(evt);

			load();
		}
	}
}
