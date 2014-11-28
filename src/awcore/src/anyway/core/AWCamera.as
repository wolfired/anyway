package anyway.core {

	import anyway.constant.AWMathConst;
	import anyway.face.AWITranslateable;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWQuaternion;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	public final class AWCamera implements AWITranslateable{
		ns_aw var _screen_width:Number;
		ns_aw var _screen_height:Number;
		ns_aw var _aspectRatio:Number;
		
		ns_aw var _fovx_deg:Number = 90.0;
		ns_aw var _near:Number = 0.01;
		ns_aw var _far:Number = 1000;
		
		ns_aw var _camera_place_at:AWVector = new AWVector(0.0, 0.0, 0.0);
		ns_aw var _camera_point_to:AWVector = new AWVector(0.0, 0.0, 1.0);
		ns_aw var _camera_up_vector:AWVector = new AWVector(0.0, 1.0, 0.0);
		
		
		ns_aw var _cameraMatrix:AWMatrix = new AWMatrix();
		ns_aw var _cameraMatrixDirty:Boolean = true;
		ns_aw var _perspectiveMatrix:AWMatrix = new AWMatrix();
		ns_aw var _perspectiveMatrixDirty:Boolean = true;
		ns_aw var _screenMatrix:AWMatrix = new AWMatrix();
		ns_aw var _screenMatrixDirty:Boolean = true;
		
		public function AWCamera() {
		}

		public function setup(screen_width:Number, screen_height:Number, fovx_deg:Number = 90.0, near:Number = 0.01, far:Number = 1000.0):AWCamera{
			_screen_width = screen_width;
			_screen_height = screen_height;
			_aspectRatio = _screen_width / _screen_height;
			
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
		
		public function translate(tx:Number, ty:Number, tz:Number):void{
			_camera_place_at.x += tx;
			_camera_place_at.y += ty;
			_camera_place_at.z += tz;
			
			_camera_point_to.x += tx;
			_camera_point_to.y += ty;
			_camera_point_to.z += tz;
			
			_cameraMatrixDirty = true;
		}
		
		public function rotate(angle_deg:Number, x:Number, y:Number, z:Number):void{
			var n:AWVector = _camera_point_to.copy.subtraction(_camera_place_at).normalize();
			var u:AWVector = _camera_up_vector.copy.crossProduct(n).normalize();
			
			var r:AWVector = new AWVector(x, y, z);
			if(n.dotProduct(_camera_up_vector) > 0.999 && r.dotProduct(u) < 0){
				return;
			}
			
			if(n.dotProduct(_camera_up_vector) < -0.999 && r.dotProduct(u) > 0){
				return;
			}
			
			var half_angle_rad:Number = angle_deg / 2.0 * AWMathConst.DEG_2_RAD;
			var sin_:Number = Math.sin(half_angle_rad);
			var cos_:Number = Math.cos(half_angle_rad);
			var rotate_quaternion:AWQuaternion = new AWQuaternion();
			var rotate_quaternion_:AWQuaternion;
			
			var point_quaternion:AWQuaternion = new AWQuaternion();
			var result_quaternion:AWQuaternion;
			
			
			rotate_quaternion.reset(sin_ * r.x, sin_ * r.y, sin_ * r.z, cos_);
			rotate_quaternion_ = rotate_quaternion.copy.inverse();
			
			_camera_place_at.subtraction(_camera_point_to);
			point_quaternion = point_quaternion.reset(_camera_place_at._raw_data[0], _camera_place_at._raw_data[1], _camera_place_at._raw_data[2], 0);
			result_quaternion = rotate_quaternion.copy;
			result_quaternion.multiply(point_quaternion.multiply(rotate_quaternion_));
			_camera_place_at.copyFromRawData(result_quaternion._raw_data);
			_camera_place_at.w = 1;
			_camera_place_at.addition(_camera_point_to);
			
			_cameraMatrixDirty = true;
		}
		
		public function screen2projection(target:AWVector):AWVector{
			target.x = (target.x / _screen_width * 2 - 1);
			target.y = ((_screen_height - target.y) / _screen_height * 2 - 1);
			
			return target;
		}
		
		public function projection2camera(target:AWVector):AWVector{
			var d_mat:AWMatrix = new AWMatrix();
			d_mat.copyRowFrom(0, target._raw_data);
			
			d_mat.multiply(this.getCameraMatrix().copy.transpose());
			
			d_mat.copyRowTo(0, target._raw_data);
			
			return target;
		}
		
		public function getCameraMatrix():AWMatrix {
			if(_cameraMatrixDirty){
				_cameraMatrixDirty = false;
				
				AWMathUtil.makeUVNMatrix(_camera_place_at, _camera_point_to, _camera_up_vector).copyToMatrix(_cameraMatrix);
			}
			return _cameraMatrix;
		}
		
		public function getPerspectiveMatrix():AWMatrix {
			if(_perspectiveMatrixDirty){
				_perspectiveMatrixDirty = false;
				AWMathUtil.makeProjectionMatrix(_fovx_deg, _aspectRatio, _near, _far).copyToMatrix(_perspectiveMatrix);
			}
			return _perspectiveMatrix;
		}
		
		public function getScreenMatrix():AWMatrix{
			if(_screenMatrixDirty){
				_screenMatrixDirty = false;
				AWMathUtil.makeScreenMatrix(_screen_width, _screen_width, _screen_height, _screen_height, _aspectRatio).copyToMatrix(_screenMatrix);
			}
			return _screenMatrix;
		}
	}
}
