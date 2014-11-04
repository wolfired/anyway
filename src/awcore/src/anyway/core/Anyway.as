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
	import anyway.visual3d.AWVisualObject;
	
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
		
		public const _scenes:Array = [];
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
			var idx:uint = scene.idx;
			_scenes[idx] = scene;
			return idx;
		}
		
		public function delScene(idx:uint):AWScene{
			var scene:AWScene = _scenes[idx];
			delete _scenes[idx];
			return scene;
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
			
			var q:AWQuad;
			for each (var scene:AWScene in _scenes) {
				scene.foreachCamera(function(monitor:AWMonitor, camera:AWCamera):void{
					scene.foreach(function(vo:AWVisualObject):void{
						q = vo as AWQuad;
						
						tr.setGeometry(q._vertexData, q._indexData, q.ttt);
						tr.render(q.transform.copy.transpose()._raw_data, 
							camera.getCameraMatrix().copy.transpose()._raw_data, 
							monitor.getPerspectiveMatrix(camera).copy.transpose()._raw_data,
							Vector.<Number>([_stage.stageWidth / q.original_width, _stage.stageHeight / q.original_height, 1, 1]));
					});
				});
			}
			
			_context3D.present();
		}
		
		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			tr.upload(_context3D);
			
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
