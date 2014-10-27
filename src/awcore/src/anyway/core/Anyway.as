package anyway.core {

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.core.ns.anyway_internal;
	import anyway.events.AWEventRouter;
	
	use namespace anyway_internal;

	public final class Anyway {
		private static var _instance:Anyway;

		public static function get sington():Anyway {
			return _instance;
		}

		public static function ready(stage:Stage, screen_width:Number, screen_height:Number):Anyway {
			new AWEventRouter();
			new Anyway(new ForceSington(), stage, screen_width, screen_height);

			return _instance;
		}

		public function Anyway(fs:ForceSington, stage:Stage, screen_width:Number, screen_height:Number) {
			SWITCH::debug {
				if(null != _instance) {
					throw new Error("Duplicate instance: Anyway");
				}
				if(null == fs){
					throw new Error("Can not instance manually: Anyway");
				}
			}

			_stage = stage;
			_screen_width = screen_width;
			_screen_height = screen_height;
			
			_instance = this;
		}

		private var _stage:Stage;
		private var _screen_width:Number;
		private var _screen_height:Number;

		private const _scenes:Vector.<AWScene> = new Vector.<AWScene>();
		private const _cameras:Vector.<AWCamera> = new Vector.<AWCamera>(4, true);
		private const _monitors:Vector.<AWMonitor> = new Vector.<AWMonitor>(4, true);

		public function go():void {
			_stage.align = StageAlign.TOP;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;

			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(Event.RESIZE, onResize);
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function getCamera(camera_no:uint):AWCamera{
			if(null == _cameras[camera_no]){
				_cameras[camera_no] = new AWCamera();
			}
			
			return _cameras[camera_no];
		}
		
		public function getMonitor(monitor_no:uint):AWMonitor{
			if(null == _monitors[monitor_no]){
				_monitors[monitor_no] = new AWMonitor(_stage.stage3Ds[monitor_no], _screen_width, _screen_height);
			}
			
			return _monitors[monitor_no];
		}
		
		public function connect(monitor_no:uint, camera_no:uint):void{
			_monitors[monitor_no].camera = _cameras[camera_no];
		}
		
		public function disconnect(monitor_no:uint):void{
			_monitors[monitor_no].camera = null;
		}

		private function onMouseClick(event:MouseEvent):void {
		}

		private function onKeyUp(event:KeyboardEvent):void {
		}

		private function onKeyDown(event:KeyboardEvent):void {
		}

		private function onResize(event:Event):void {
			_screen_width = _stage.width;
			_screen_height = _stage.height;
		}

		private function onEnterFrame(event:Event):void {
			
			for (var i:uint = 0; i < _monitors.length; ++i) {
				if(null == _monitors[i] || null == _monitors[i].camera || null == _monitors[i].camera.scene){
					continue;
				}
				_monitors[i].render();
			}
			
		}
	}
}

class ForceSington {
	
}
