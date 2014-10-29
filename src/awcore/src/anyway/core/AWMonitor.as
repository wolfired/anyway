package anyway.core{
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import anyway.constant.AWMathConst;
	import anyway.geometry.AWMatrix;
	import anyway.shader.TextureShader;
	import anyway.utils.AWMathUtil;
	
	use namespace aw_ns;

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
		
		aw_ns function get camera():AWCamera {
			return _camera;
		}
		
		aw_ns function set camera(value:AWCamera):void{
			if (_camera == value)
				return;
			_camera = value;
			if(_camera == null){
				_context3D.dispose(false);
			}else{
				_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			}
		}
		
		aw_ns function render():void{
			_context3D.clear(0.94, 0.94, 0.94);
			
			
			_context3D.present();
		}
		
		private function perspectiveMatrix():AWMatrix {
			return AWMathUtil.perspectiveFieldOfViewLH(_camera._fovy * AWMathConst.DEG_2_RAD, _monitor_width / _monitor_height, _camera._zNear, _camera._zFar);
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