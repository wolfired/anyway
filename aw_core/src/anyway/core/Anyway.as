package anyway.core {

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.geometry.AWPoint;

	public final class Anyway {
		private static var _instance:Anyway;
		
		public static function get instance():Anyway {
			return _instance;
		}
		
		private var _stage:Stage;
		private var _screen_width:Number;
		private var _screen_height:Number;
		
		private const _monitors:Vector.<AWMonitor> = new Vector.<AWMonitor>();
		private const _cameras:Vector.<AWCamera> = new Vector.<AWCamera>();
		
		public function Anyway() {
			SWITCH::debug{
				if(null != _instance){
					throw new Error("Duplicate instance Anyway");
				}
			}
			
			_instance = this;
		}
		
		public function boot(stage:Stage, screen_width:Number, screen_height:Number):void {
			_stage = stage;
			_screen_width = screen_width;
			_screen_height = screen_height;
			
			_stage.align = StageAlign.TOP;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.addEventListener(Event.RESIZE, onResize);
			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			_cameras.push(new AWCamera(new AWPoint(0,0,0), new AWPoint(0,0,1)));
			
			_monitors.push(new AWMonitor(_screen_width, _screen_height));
			_monitors[0]._camera = _cameras[0];
			_monitors[0].poweron(_stage.stage3Ds[0]);
		}
		
		private function onEnterFrame(event:Event):void {
			_monitors[0].refresh();
		}
		
		private function onResize(event:Event):void {
			
		}
		
		private function onMouseClick(event:MouseEvent):void{
		}
		
		private function onKeyDown(event:KeyboardEvent):void{
		}
		
		private function onKeyUp(event:KeyboardEvent):void{
		}
	}
}
