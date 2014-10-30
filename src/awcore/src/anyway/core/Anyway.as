package anyway.core {

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	use namespace ns_aw;

	public final class Anyway {
		private static var _instance:Anyway;

		public static function get ins():Anyway {
			if(null == _instance){
				_instance = new Anyway();
			}
			return _instance;
		}

		public function Anyway() {

		}
		
		public function setup(stage:Stage, screen_width:Number, screen_height:Number):Anyway {
			_stage = stage;
			_screen_width = screen_width;
			_screen_height = screen_height;
			
			return this;
		}
		
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

		private var _stage:Stage;
		private var _screen_width:Number;
		private var _screen_height:Number;

		private const _scenes:Vector.<AWScene> = new Vector.<AWScene>();
		private const _cameras:Vector.<AWCamera> = new Vector.<AWCamera>(4, true);
		private const _monitors:Vector.<AWMonitor> = new Vector.<AWMonitor>(4, true);

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
