package anyway.core{
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import anyway.display.AWQuad;
	import anyway.geometry.AWMatrix;
	import anyway.shader.TexturedRender;
	import anyway.utils.AWMathUtil;
	
	use namespace ns_aw;

	public final class AWMonitor{
		
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		private var _monitor_width:Number;
		private var _monitor_height:Number;
		
		private var _camera:AWCamera;
		
		public function AWMonitor(stage3D:Stage3D, monitor_width:Number, monitor_height:Number){
			_stage3D = stage3D;
			_monitor_width = monitor_width;
			_monitor_height = monitor_height;
			
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
		}
		
		ns_aw function get camera():AWCamera {
			return _camera;
		}
		
		ns_aw function set camera(value:AWCamera):void{
			if (_camera == value)
				return;
			_camera = value;
			if(_camera == null){
				_context3D.dispose(false);
			}else{
				_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			}
		}
		
		private var sh:TexturedRender = new TexturedRender();
		
		ns_aw function render():void{
			_context3D.clear(0.94, 0.94, 0.94);
			
			var q:AWQuad = _camera.scene.getChildAt(0) as AWQuad;
			
			sh.upload(_context3D);
			sh.setGeometry(q._vertexData, q._indexData, q.ttt);
			
//			var t:AWMatrix = new AWMatrix();
//			t.identity();
//			t.multiply(q.transform);
//			t.multiply(_camera.cameraMatrix());
//			t.multiply(perspectiveMatrix());
			var mw:AWMatrix = q.transform.transpose();
			var c:AWMatrix = _camera.cameraMatrix().transpose();
			var p:AWMatrix = perspectiveMatrix().transpose();
			
			sh.render(mw._raw_data, c._raw_data, p._raw_data);
			_context3D.present();
		}
		
		private function perspectiveMatrix():AWMatrix {
			return AWMathUtil.makeProjectionMatrix(_camera._fovx_deg, _monitor_width / _monitor_height, _camera._near, _camera._far);
		}
		
		private function screenMatrix():AWMatrix{
			return AWMathUtil.makeScreenMatrix(_monitor_width, _monitor_width, _monitor_height, _monitor_height, _monitor_width / _monitor_height);
		}
		
		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_monitor_width, _monitor_height, 8);
		}
		
		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}