package anyway.core {

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.events.AWEventRouter;
	import anyway.geometry.AWVector;
	import anyway.manager.asset.AWAssetManager;

	public final class Anyway {
		private static var _instance:Anyway;

		public static function get sington():Anyway {
			return _instance;
		}

		public static function ready(stage:Stage, screen_width:Number, screen_height:Number):Anyway {
			new AWAssetManager();
			new AWEventRouter();
			new Anyway();

			_instance._stage = stage;
			_instance._screen_width = screen_width;
			_instance._screen_height = screen_height;

			_instance._camera = new AWCamera(stage.stage3Ds[0], screen_width, screen_height);
			_instance._camera.setup(new AWVector(0, 0, 0), new AWVector(0, 0, 1));
			_instance._camera.action();

			return _instance;
		}

		public function Anyway() {
			SWITCH::debug {
				if(null != _instance) {
					throw new Error("Duplicate instance Anyway");
				}
			}

			_instance = this;
		}

		private var _stage:Stage;
		private var _screen_width:Number;
		private var _screen_height:Number;

		private var _camera:AWCamera;

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
			
			
			
		}
	}
}
