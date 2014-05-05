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

		public function AWCamera(place_at:AWPoint, point_at:AWPoint) {
			_camera_place_at.copyRawData(place_at._raw_data);
			_camera_point_at.copyRawData(point_at._raw_data);
		}

		anyway_internal var _valid:Boolean = false;
		private const _camera_place_at:AWPoint = new AWPoint();
		private const _camera_point_at:AWPoint = new AWPoint();

		public function invalid():void {
			_valid = false;
		}

		public function get matrix():AWMatrix {
			return AWMathUtil.lookAtLH(_camera_place_at, _camera_point_at, new AWVector(0, 1, 0));
		}
	}
}
