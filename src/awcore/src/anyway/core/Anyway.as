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
		
		private var _stage:Stage;

		public function Anyway() {

		}
		
		public function setup(stage:Stage):void {
			_stage = stage;
			_stage.align = StageAlign.TOP;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(Event.RESIZE, onResize);
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			
		}

		private function onKeyUp(event:KeyboardEvent):void {
			
		}

		private function onMouseClick(event:MouseEvent):void {
			
		}

		private function onResize(event:Event):void {
			
		}

		private function onEnterFrame(event:Event):void {
			
		}
	}
}
