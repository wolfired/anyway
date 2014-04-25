package anyway.core {
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;
	
	use namespace anyway_internal;

	public class AWCamera {
		public var _cm:AWMatrix;
		
		public function AWCamera() {
		}
		
		public function lookAtLH(eye_pos:AWPoint, at_pos:AWPoint, up_vec:AWVector):void{
			var eye:AWVector = new AWVector(eye_pos.x, eye_pos.y, eye_pos.z);
			
			var zaxis:AWVector = AWMathUtil.makeVectorFromPoint(eye_pos, at_pos);
			zaxis.normalize();
			var xaxis:AWVector = AWMathUtil.vectorCrossProduct(up_vec, zaxis);
			xaxis.normalize();
			var yaxis:AWVector = AWMathUtil.vectorCrossProduct(zaxis, xaxis);
			var waxis:AWVector = new AWVector(xaxis.dotProduct(eye), yaxis.dotProduct(eye), zaxis.dotProduct(eye));
			waxis._raw_data[3] = 1;
			
			_cm = new AWMatrix();
			_cm.copyColumnFrom(0, xaxis._raw_data);
			_cm.copyColumnFrom(1, yaxis._raw_data);
			_cm.copyColumnFrom(2, zaxis._raw_data);
			_cm.copyColumnFrom(3, waxis._raw_data);
//			_cm.copyRowFrom(0, xaxis._raw_data);
//			_cm.copyRowFrom(1, yaxis._raw_data);
//			_cm.copyRowFrom(2, zaxis._raw_data);
//			_cm.copyRowFrom(3, waxis._raw_data);
//			_cm.transpose();
		}
		
		public function perspectiveFieldOfViewLH(fieldOfViewY:Number, 
												 aspectRatio:Number, 
												 zNear:Number, 
												 zFar:Number):void {
			var yScale:Number = 1.0/Math.tan(fieldOfViewY/2.0);
			var xScale:Number = yScale / aspectRatio; 
			_cm = new AWMatrix();
			_cm.copyRawData(Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zFar-zNear), 1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]));
			_cm.transpose();
		}
	}
}
