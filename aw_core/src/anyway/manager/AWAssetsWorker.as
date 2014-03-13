package anyway.manager{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import anyway.events.AWAssetsEvent;
	import anyway.events.AWEventRouter;

	public class AWAssetsWorker{
		private static const STATUS_IDLE:uint = 1 << 0;
		private static const STATUS_BUSY:uint = 1 << 1;
		
		public function AWAssetsWorker(){
			_status = STATUS_IDLE;
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private var _status:uint;
		private var _urlLoader:URLLoader;
		private var _assets:AWAssets;
		
		public function get isIdle():Boolean{
			return STATUS_IDLE == _status;
		}
		
		public function workhard(assets:AWAssets):void{
			_assets = assets;
			_urlLoader.load(_assets.urlRequest);
		}
		
		private function onProgress(event:ProgressEvent):void {
			var evt:AWAssetsEvent = new AWAssetsEvent(AWAssetsEvent.EVT_PROGRESS, _assets);
			AWEventRouter.instance.routeEvent(evt);
		}
		
		private function onComplete(event:Event):void {
			var evt:AWAssetsEvent = new AWAssetsEvent(AWAssetsEvent.EVT_COMPLETE, _assets);
			AWEventRouter.instance.routeEvent(evt);
		}
	}
}