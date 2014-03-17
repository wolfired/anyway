package anyway.core {

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class Anyway {
		private var _stage:Stage;
		
		private var _monitor:AWMonitor;
		
		public function Anyway() {
		}

		public function boot(stage:Stage):void {
			_stage = stage;
			
			_stage.align = StageAlign.TOP;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			_monitor = new AWMonitor();
			_monitor.poweron(_stage.stage3Ds[0]);
		}
		
		private function onEnterFrame(event:Event):void {
			_monitor.refresh();
		}
		private function onMouseClick(event:MouseEvent):void{
		}
		private function onKeyDown(event:KeyboardEvent):void{
		}
		private function onKeyUp(event:KeyboardEvent):void{
		}
	}
}
