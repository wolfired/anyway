package anyway.core {

	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.shader.TexturedRender;
	import anyway.visual3d.AWQuad;
	
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
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		private const _scenes:Array = [];
		private const _cameras:Array = [];
		private const _monitors:Array = [];
		private var tr:TexturedRender = new TexturedRender();
		
		public function Anyway() {
		}
		
		public function setup(stage:Stage):void {
			_stage = stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_stage.addEventListener(Event.RESIZE, onResize);
			
			_stage3D = _stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
			
			_stage3D.requestContext3D();
		}
		
		public function addScene(scene:AWScene):uint{
			var idx:uint = scene._idx;
			_scenes[idx] = scene;
			return idx;
		}
		
		public function delScene(idx:uint):AWScene{
			var scene:AWScene = _scenes[idx];
			delete _scenes[idx];
			return scene;
		}
		
		public function addMonitor(monitor:AWMonitor):uint{
			var idx:uint = monitor._idx;
			_monitors[idx] = monitor;
			return idx;
		}
		
		public function delMonitor(idx:uint):AWMonitor{
			var monitor:AWMonitor = _monitors[idx];
			delete _monitors[idx];
			return monitor;
		}
		
		public function addCamera(camera:AWCamera):uint{
			var idx:uint = camera._idx;
			_cameras[idx] = camera;
			return idx;
		}
		
		public function delCamera(idx:uint):AWCamera{
			var camera:AWCamera = _cameras[idx];
			delete _cameras[idx];
			return camera;
		}

		
		private function onKeyDown(event:KeyboardEvent):void {
			
		}

		private function onKeyUp(event:KeyboardEvent):void {
			
		}

		private function onMouseClick(event:MouseEvent):void {
			
		}

		private function onResize(event:Event):void {
			this.reset3DContext();
		}

		private function onEnterFrame(event:Event):void {
			_context3D.clear(0.94, 0.94, 0.94);
			
			tr.render();
			
			_context3D.present();
		}
		
		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			tr.upload(_context3D);
			
			if(_scenes[1]){
				var s:AWScene = _scenes[1] as AWScene;
				var c:AWCamera = _cameras[1] as AWCamera;
				var m:AWMonitor = _monitors[1] as AWMonitor;
				
				var q:AWQuad = s.getChildAt(0) as AWQuad;
				tr.setGeometry(q._vertexData, q._indexData, q.ttt);
				tr.preRender(q.transform.copy.transpose()._raw_data, 
					c.getCameraMatrix().copy.transpose()._raw_data, 
					m.getPerspectiveMatrix(c).copy.transpose()._raw_data,
					Vector.<Number>([1, 1, 1, 1]));
			}
			
			this.reset3DContext();
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function reset3DContext():void{
			_context3D.configureBackBuffer(_stage.stageWidth, _stage.stageHeight, 8);
		}
		
		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}
