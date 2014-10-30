package anyway.core {

	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	public final class AWCamera {
		
		public function AWCamera() {
		}

		ns_aw var _fovx_deg:Number;
		ns_aw var _near:Number;
		ns_aw var _far:Number;
		ns_aw var _scene:AWScene;

		private const _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		private const _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		
		public function setup(fovx_deg:Number = 90.0, near:Number = 1.0, far:Number = 1000.0):AWCamera{
			_fovx_deg = fovx_deg;
			_near = near;
			_far = far;
			
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
			_scene = value;
		}
		
		public function cameraMatrix():AWMatrix {
			return AWMathUtil.makeUVNMatrix(_camera_place_at, _camera_point_to, new AWVector(0.0, 1.0, 0.0));
		}
	}
}
