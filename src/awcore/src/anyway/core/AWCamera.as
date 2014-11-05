package anyway.core {

	import anyway.constant.AWMathConst;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWQuaternion;
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
		
		ns_aw const _idx:uint = ++IDX;
		
		ns_aw const _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		ns_aw const _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		ns_aw const _cameraMatrix:AWMatrix = new AWMatrix();
		ns_aw var _cameraMatrixDirty:Boolean = true;
		
		public function setup(fovx_deg:Number = 90.0, near:Number = 0.01, far:Number = 1000.0):AWCamera{
			_fovx_deg = fovx_deg;
			_near = near;
			_far = far;
			
			return this;
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
			if(_cameraMatrixDirty){
				_cameraMatrixDirty = false;
				
				var c:Number = 90.0;
				var pp:AWQuaternion;
				var qq:AWQuaternion;
				var qq_:AWQuaternion;
				var vv:AWVector = new AWVector(1, 1, 1).normalize();
				
				pp = new AWQuaternion(_camera_place_at._raw_data[0], _camera_place_at._raw_data[1], _camera_place_at._raw_data[2], 0);
				qq = new AWQuaternion(Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[0], Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[1], Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[2], Math.cos(c / 2 * AWMathConst.DEG_2_RAD));
				qq_ = qq.inverse();
				qq.multiply(pp.multiply(qq_));
				_camera_place_at.copyFromRawData(qq._raw_data);
				_camera_place_at.w = 1;
//				_camera_place_at.format();
				
				pp = new AWQuaternion(_camera_point_to._raw_data[0], _camera_point_to._raw_data[1], _camera_point_to._raw_data[2], 0);
				qq = new AWQuaternion(Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[0], Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[1], Math.sin(c / 2 * AWMathConst.DEG_2_RAD) * vv._raw_data[2], Math.cos(c / 2 * AWMathConst.DEG_2_RAD));
				qq_ = qq.inverse();
				qq.multiply(pp.multiply(qq_));
				_camera_point_to.copyFromRawData(qq._raw_data);
				_camera_point_to.w = 1;
//				_camera_point_to.format();
				
				AWMathUtil.makeUVNMatrix(_camera_place_at, _camera_point_to, new AWVector(0.0, 1.0, 0.0)).copyToMatrix(_cameraMatrix);
			}
			return _cameraMatrix;
		}
	}
}
