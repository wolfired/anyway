package anyway.core {

	import anyway.core.ns.anyway_internal;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace anyway_internal_geometry;
	use namespace anyway_internal;

	public final class AWCamera {

		public function AWCamera() {
			init();
		}

		anyway_internal var _fovy:Number;
		anyway_internal var _zNear:Number;
		anyway_internal var _zFar:Number;
		anyway_internal var _scene:AWScene;

		private const _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		private const _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		
		public function init(fovy:Number = 90.0, zNear:Number = 1.0, zFar:Number = 1000.0):AWCamera{
			_fovy = fovy;
			_zNear = zNear;
			_zFar = zFar;
			
			return this;
		}
		
		public function place_at(place_at:AWVector):AWCamera {
			_camera_place_at.copyRawData(place_at._raw_data);
			
			return this;
		}
		public function point_to(point_to:AWVector):AWCamera {
			_camera_point_to.copyRawData(point_to._raw_data);
			
			return this;
		}
		
		public function get scene():AWScene { 
			return _scene;
		}
		
		public function set scene(value:AWScene):void{
			if (_scene == value){
				return;
			}
			_scene = value;
		}
		
		private function cameraMatrix():AWMatrix {
			return AWMathUtil.lookAtLH(_camera_place_at, _camera_point_to, new AWVector(0.0, 1.0, 0.0));
		}
	}
}
