package anyway.core {

	import anyway.constant.AWMathConst;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWQuaternion;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	public final class AWCamera {
		ns_aw var _fovx_deg:Number = 90.0;
		ns_aw var _near:Number = 0.01;
		ns_aw var _far:Number = 1000;
		
		ns_aw const _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		ns_aw const _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		ns_aw const _camera_up_vector:AWVector = new AWVector(0.0, 1.0, 0.0);
		ns_aw const _cameraMatrix:AWMatrix = new AWMatrix();
		ns_aw var _cameraMatrixDirty:Boolean = true;
		
		public function AWCamera() {
		}

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
		
		public function rotate(angle_deg:Number, x:Number, y:Number, z:Number):void{
			var half_angle_rad:Number = angle_deg / 2.0 * AWMathConst.DEG_2_RAD;
			var sin_:Number = Math.sin(half_angle_rad);
			var cos_:Number = Math.cos(half_angle_rad);
			var rotate_vector:AWVector = new AWVector(x, y, z).normalize();
			var rotate_quaternion:AWQuaternion = new AWQuaternion(sin_ * rotate_vector._raw_data[0], sin_ * rotate_vector._raw_data[1], sin_ * rotate_vector._raw_data[2], cos_);
			var rotate_quaternion_:AWQuaternion = rotate_quaternion.inverse();
			
			var point_quaternion:AWQuaternion = new AWQuaternion();
			var result_quaternion:AWQuaternion;
			
			point_quaternion = point_quaternion.reset(_camera_place_at._raw_data[0], _camera_place_at._raw_data[1], _camera_place_at._raw_data[2], 0);
			result_quaternion = rotate_quaternion.copy;
			result_quaternion.multiply(point_quaternion.multiply(rotate_quaternion_));
			_camera_place_at.copyFromRawData(result_quaternion._raw_data);
			_camera_place_at.w = 1;
			
			point_quaternion = point_quaternion.reset(_camera_point_to._raw_data[0], _camera_point_to._raw_data[1], _camera_point_to._raw_data[2], 0);
			result_quaternion = rotate_quaternion.copy;
			result_quaternion.multiply(point_quaternion.multiply(rotate_quaternion_));
			_camera_point_to.copyFromRawData(result_quaternion._raw_data);
			_camera_point_to.w = 1;
			
			point_quaternion = point_quaternion.reset(_camera_up_vector._raw_data[0], _camera_up_vector._raw_data[1], _camera_up_vector._raw_data[2], 0);
			result_quaternion = rotate_quaternion.copy;
			result_quaternion.multiply(point_quaternion.multiply(rotate_quaternion_));
			_camera_up_vector.copyFromRawData(result_quaternion._raw_data);
			_camera_up_vector.w = 0;
			
			_cameraMatrixDirty = true;
		}
		
		public function getCameraMatrix():AWMatrix {
			if(_cameraMatrixDirty){
				_cameraMatrixDirty = false;
				
				AWMathUtil.makeUVNMatrix(_camera_place_at, _camera_point_to, _camera_up_vector).copyToMatrix(_cameraMatrix);
			}
			return _cameraMatrix;
		}
	}
}
