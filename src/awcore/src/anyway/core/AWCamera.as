package anyway.core {

	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	public final class AWCamera {
		private static var IDX:uint = 0;
		
		public function AWCamera() {
		}

		ns_aw var _fovx_deg:Number = 90.0;
		ns_aw var _near:Number = 0.01;
		ns_aw var _far:Number = 1000;
		
		private const _idx:uint = ++IDX;
		private const _monitors:Array = [];
		private const _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		private const _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		private const _cameraMatrix:AWMatrix = new AWMatrix();
		private var _isCameraMatrixDirty:Boolean = true;
		
		public function setup(fovx_deg:Number = 90.0, near:Number = 0.01, far:Number = 1000.0):AWCamera{
			_fovx_deg = fovx_deg;
			_near = near;
			_far = far;
			
			return this;
		}
		
		public function get idx():uint{
			return _idx;
		}
		
		public function connect(monitor:AWMonitor):uint{
			var idx:uint = monitor.idx;
			_monitors[idx] = monitor;
			return idx;
		}
		
		public function disconnect(idx:uint):AWMonitor{
			var monitor:AWMonitor = _monitors[idx];
			delete _monitors[idx];
			return monitor;
		}
		
		public function place_at(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0):AWCamera {
			_camera_place_at.reset(x, y, z);
			
			return this;
		}
		
		public function point_to(x:Number = 0.0, y:Number = 0.0, z:Number = 1.0):AWCamera {
			_camera_point_to.reset(x, y, z);
			
			return this;
		}
		
		public function getCameraMatrix():AWMatrix {
			if(_isCameraMatrixDirty){
				_isCameraMatrixDirty = false;
				AWMathUtil.makeUVNMatrix(_camera_place_at, _camera_point_to, new AWVector(0.0, 1.0, 0.0)).copyToMatrix(_cameraMatrix);
			}
			return _cameraMatrix;
		}
		
		public function foreachMonitor(handler:Function, camera:AWCamera):void{
			for each (var monitor:AWMonitor in _monitors) {
				handler(monitor, camera);
			}
		}
	}
}
