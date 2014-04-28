package anyway.core {

	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import anyway.constant.AWCoordinateConst;
	import anyway.constant.AWMathConst;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;

	public class Anyway {
		private var _stage:Stage;
		
		private var _main_monitor:AWMonitor;
		
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
			
			_main_monitor = new AWMonitor();
			_main_monitor.poweron(_stage.stage3Ds[0]);
		}
		
		private function onEnterFrame(event:Event):void {
			_main_monitor.refresh();
		}
		private function onMouseClick(event:MouseEvent):void{
		}
		private function onKeyDown(event:KeyboardEvent):void{
		}
		private function onKeyUp(event:KeyboardEvent):void{
		}
	}
}
