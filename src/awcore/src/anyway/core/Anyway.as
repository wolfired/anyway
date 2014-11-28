package anyway.core {

	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import anyway.face.controller.AWITranslateController;
	import anyway.geometry.AWVector;
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
		
		private var _total_time:Number = 0.0;
		private var _frame_rate:Number = 0.0;
		
		private var _collector:AWCollector;
		private var _scene:AWScene;
		private var _camera:AWCamera;
		private var _translateController:AWITranslateController;
		
		private var tr:TexturedRender = new TexturedRender();
		
		public function Anyway() {
		}
		
		public function setup(stage:Stage, frame_rate:Number = 1 / 24):void {
			_stage = stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.quality = StageQuality.BEST;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_frame_rate = frame_rate;
			
			_collector = new AWCollector().setup(_stage);
			_scene = new AWScene();
			_camera = new AWCamera().setup(stage.stageWidth, stage.stageHeight);
			_translateController = new AWTranslateController();
			
			_stage.addEventListener(Event.RESIZE, onResize);
			
			_stage3D = _stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
			
			_stage3D.requestContext3D();
		}
		
		public function get controller():AWCollector{
			return _collector;
		}
		
		public function get scene():AWScene{
			return _scene;
		}
		
		public function get camera():AWCamera{
			return _camera;
		}
		
		public function get translateController():AWITranslateController{
			return _translateController;
		}
		
		private function onResize(event:Event):void {
			this.reset3DContext();
		}

		private function onEnterFrame(event:Event):void {
			_context3D.clear(0.94, 0.94, 0.94);
			
			var n:AWVector = _camera._camera_point_to.copy.subtraction(_camera._camera_place_at).normalize();
			var u:AWVector = _camera._camera_up_vector.copy.crossProduct(n).normalize();
			if(_collector.isKeyDonw(Keyboard.A) && _collector.isKeyDonw(Keyboard.D)){
				
			}else if(_collector.isKeyDonw(Keyboard.A)){
				u.zoom(-1 / 60);
				_translateController.translate(u.x, u.y, u.z);
			}else if(_collector.isKeyDonw(Keyboard.D)){
				u.zoom(1 / 60);
				_translateController.translate(u.x, u.y, u.z);
			}
			
			var pt:AWVector;
			var pt_y:AWVector;
			if(_collector.isKeyDonw(Keyboard.W) && _collector.isKeyDonw(Keyboard.S)){
				
			}else if(_collector.isKeyDonw(Keyboard.W)){
				pt = _camera._camera_point_to.copy.subtraction(_camera._camera_place_at);
				pt_y = new AWVector(0, pt.dotProduct(new AWVector(0, 1, 0)), 0);
				pt.subtraction(pt_y);
				pt.normalize();
				
				_translateController.translate(pt._raw_data[0] / 60, pt._raw_data[1] / 60, pt._raw_data[2] / 60);
			}else if(_collector.isKeyDonw(Keyboard.S)){
				pt = _camera._camera_point_to.copy.subtraction(_camera._camera_place_at);
				pt_y = new AWVector(0, pt.dotProduct(new AWVector(0, 1, 0)), 0);
				pt.subtraction(pt_y);
				pt.normalize();
				_translateController.translate(-pt._raw_data[0] / 60, -pt._raw_data[1] / 60, -pt._raw_data[2] / 60);
			}
			
			if(_collector.isKeyDonw(Keyboard.Q) && _collector.isKeyDonw(Keyboard.E)){
				
			}else if(_collector.isKeyDonw(Keyboard.Q)){
				_camera.rotate(.8, 0, 1, 0);
			}else if(_collector.isKeyDonw(Keyboard.E)){
				_camera.rotate(.8, 0, -1, 0);
			}
			
			_scene.foreach(function(vo:AWVisualObject):void{
				var q:AWQuad = vo as AWQuad;
				tr.setGeometry(q._vertexData, q._indexData, q.ttt);
				tr.preRender(q.transform.copy.transpose()._raw_data, 
					_camera.getCameraMatrix().copy.transpose()._raw_data, 
					_camera.getPerspectiveMatrix().copy.transpose()._raw_data,
					Vector.<Number>([1, 1, 1, 1]));
				tr.render();
			});
			
			_context3D.present();
		}
		
		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.setCulling(Context3DTriangleFace.BACK);
			_context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			
			tr.upload(_context3D);
			
			this.reset3DContext();
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function reset3DContext():void{
			_context3D.configureBackBuffer(_stage.stageWidth, _stage.stageHeight, 0);
		}
		
		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}
