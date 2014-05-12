package anyway.core {

	import com.adobe.utils.PerspectiveMatrix3D;
	import com.barliesque.shaders.macro.ColorSpace;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import anyway.events.AWEventRouter;
	import anyway.geometry.AWPoint;
	import anyway.manager.asset.AWAssetManager;
	import anyway.space.AWSpaceObjectContainer;

	public final class Anyway {
		private static var _instance:Anyway;

		public static function get sington():Anyway {
			return _instance;
		}

		public static function ready(stage:Stage, screen_width:Number, screen_height:Number):Anyway {
			var p:PerspectiveMatrix3D;
			var c:ColorSpace;
			
			new AWAssetManager();
			new AWEventRouter();
			new Anyway();

			_instance._stage = stage;
			_instance._screen_width = screen_width;
			_instance._screen_height = screen_height;

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

		private const _cameras:Vector.<AWCamera> = new Vector.<AWCamera>();
		private const _monitors:Vector.<AWMonitor> = new Vector.<AWMonitor>();
		
		private const _world:AWSpaceObjectContainer = new AWSpaceObjectContainer();

		public function go():void {
			_stage.align = StageAlign.TOP;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;

			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.addEventListener(Event.RESIZE, onResize);
			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

			_cameras.push(new AWCamera(new AWPoint(0, 0, 0), new AWPoint(0, 0, 1)));

			_monitors.push(new AWMonitor(_stage.stage3Ds[0], _screen_width, _screen_height));
			_monitors[0].connect(_cameras[0]);
			_monitors[0].poweron();
		}
		
		public function get world():AWSpaceObjectContainer{
			return _world;
		}

		private function onEnterFrame(event:Event):void {
			_monitors[0].refresh();
		}

		private function onResize(event:Event):void {
			_screen_width = _stage.width;
			_screen_height = _stage.height;
		}

		private function onMouseClick(event:MouseEvent):void {
		}

		private function onKeyDown(event:KeyboardEvent):void {
			if(event.ctrlKey && (Keyboard.NUMBER_2 == event.keyCode || Keyboard.NUMBER_3 == event.keyCode)) {

			}
		}

		private function onKeyUp(event:KeyboardEvent):void {
		}
	}
}
