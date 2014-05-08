package anyway.core {

	import anyway.core.ns.anyway_internal;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace anyway_internal;

	use namespace anyway_internal_geometry;

	public final class AWCamera {

		public function AWCamera(place_at:AWPoint, point_to:AWPoint) {
			_camera_place_at.copyRawData(place_at._raw_data);
			_camera_point_to.copyRawData(point_to._raw_data);
		}

		private var _valid:Boolean = false;
		private const _camera_place_at:AWPoint = new AWPoint();
		private const _camera_point_to:AWPoint = new AWPoint();
		private const _camera_matrix:AWMatrix = new AWMatrix();

		public function set place_at(value:AWPoint):void{
			_camera_place_at.copyRawData(value._raw_data);
			_valid = false;
		}
		
		public function set point_to(value:AWPoint):void{
			_camera_point_to.copyRawData(value._raw_data);
			_valid = false;
		}

		public function get matrix():AWMatrix {
			if(!_valid){
				_valid = true;
				_camera_matrix.copyRawData(AWMathUtil.lookAtLH(_camera_place_at, _camera_point_to, new AWVector(0, 1, 0))._raw_data);
			}
			return _camera_matrix;
		}
	}
}
