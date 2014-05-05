package anyway.utils {

	import anyway.constant.AWCoordinateConst;
	import anyway.constant.AWMathConst;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;
	
	use namespace anyway_internal_geometry;

	public class AWMathUtil {
		/**
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}1 %26 0 %26 0 %26 0\\ 0 %26 1 %26 0 %26 0\\ 0 %26 0 %26 1 %26 0\\ tx %26 ty %26 tz %26 1\end{bmatrix}"/></p>
		 * @param tx
		 * @param ty
		 * @param tz
		 * @return 平移矩阵
		 */
		public static function makeTranslateMatrix(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
											   1, 0, 0, 0,
											   0, 1, 0, 0,
											   0, 0, 1, 0,
											   tx, ty, tz, 1]));
			return result;
		}

		/**
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}sx %26 0 %26 0 %26 0\\ 0 %26 sy %26 0 %26 0\\ 0 %26 0 %26 sz %26 0\\ 0 %26 0 %26 0 %26 1\end{bmatrix}"/></p>
		 * @param sx
		 * @param sy
		 * @param sz
		 * @return 缩放矩阵
		 */
		public static function makeScaleMatrix(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
											   sx, 0, 0, 0,
											   0, sy, 0, 0,
											   0, 0, sz, 0,
											   0, 0, 0, 1]));
			return result;
		}

		/**
		 * <p>X轴为旋转轴<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}1 %26 0 %26 0 %26 0\\ 0 %26 \cos\theta %26 \sin\theta %26 0\\ 0 %26 -\sin\theta %26 \cos\theta %26 0\\ 0 %26 0 %26 0 %26 1\end{bmatrix}"/></p>
		 * <p>Y轴为旋转轴<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}\cos\theta %26 0 %26 -\sin\theta %26 0\\ 0 %26 1 %26 0 %26 0\\ \sin\theta %26 0 %26 \cos\theta %26 0\\ 0 %26 0 %26 0 %26 1\end{bmatrix}"/></p>
		 * <p>Z轴为旋转轴<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}\cos\theta %26 \sin\theta %26 0 %26 0\\ -\sin\theta %26 \cos\theta %26 0 %26 0\\ 0 %26 0 %26 1 %26 0\\ 0 %26 0 %26 0 %26 1\end{bmatrix}"/></p>
		 * @param deg 角度
		 * @param axis 旋转轴
		 * @return 旋转矩阵
		 * @see anyway.constant.AWCoordinateConst
		 */
		public static function makeRotateMatrix(deg:Number = 0, axis:uint = 1):AWMatrix {
			var rad:Number = AWMathConst.DEG_2_RAD * deg;
			var result:AWMatrix = new AWMatrix();

			switch(axis) {
				case AWCoordinateConst.AXIS_Y: {
					result.copyRawData(Vector.<Number>([
													   Math.cos(rad), 0, -Math.sin(rad), 0,
													   0, 1, 0, 0,
													   Math.sin(rad), 0, Math.cos(rad), 0,
													   0, 0, 0, 1]));
					break;
				}
				case AWCoordinateConst.AXIS_Z: {
					result.copyRawData(Vector.<Number>([
													   Math.cos(rad), Math.sin(rad), 0, 0,
													   -Math.sin(rad), Math.cos(rad), 0, 0,
													   0, 0, 1, 0,
													   0, 0, 0, 1]));
					break;
				}
				default: {
					result.copyRawData(Vector.<Number>([
													   1, 0, 0, 0,
													   0, Math.cos(rad), Math.sin(rad), 0,
													   0, -Math.sin(rad), Math.cos(rad), 0,
													   0, 0, 0, 1]));
				}
			}
			return result;
		}
		
		public static function lookAtLH(eye_at_pos:AWPoint, look_at_pos:AWPoint, up_vec:AWVector):AWMatrix{
			var eye:AWVector = new AWVector(eye_at_pos.x, eye_at_pos.y, eye_at_pos.z);
			
			var zaxis:AWVector = AWMathUtil.makeVectorFromPoint(eye_at_pos, look_at_pos);
			zaxis.normalize();
			var xaxis:AWVector = AWMathUtil.vectorCrossProduct(up_vec, zaxis);
			xaxis.normalize();
			var yaxis:AWVector = AWMathUtil.vectorCrossProduct(zaxis, xaxis);
			var waxis:AWVector = new AWVector(-eye.dotProduct(xaxis), -eye.dotProduct(yaxis), -eye.dotProduct(zaxis));
			waxis._raw_data[3] = 1;
			
			var result:AWMatrix = new AWMatrix().identity();
			result.copyRowFrom(0, xaxis._raw_data);
			result.copyRowFrom(1, yaxis._raw_data);
			result.copyRowFrom(2, zaxis._raw_data);
			result.copyRowFrom(3, waxis._raw_data);
			return result;
		}
		
		public static function perspectiveFieldOfViewLH(fieldOfViewY:Number, 
												 aspectRatio:Number, 
												 zNear:Number, 
												 zFar:Number):AWMatrix {
			var yScale:Number = 1.0/Math.tan(fieldOfViewY/2.0);
			var xScale:Number = yScale / aspectRatio; 
			
			var result:AWMatrix = new AWMatrix().identity();
			result.copyRawData(Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zFar-zNear), 1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]));
			return result;
		}
		
		public static function perspectiveFieldOfViewRH(fieldOfViewY:Number, 
												 aspectRatio:Number, 
												 zNear:Number, 
												 zFar:Number):AWMatrix {
			var yScale:Number = 1.0/Math.tan(fieldOfViewY/2.0);
			var xScale:Number = yScale / aspectRatio; 
			
			var result:AWMatrix = new AWMatrix().identity();
			result.copyRawData(Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zNear-zFar), -1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]));
			return result;
		}

		public static function makeVectorFromPoint(from:AWPoint, to:AWPoint):AWVector{
			return new AWVector(to._raw_data[0] - from._raw_data[0], to._raw_data[1] - from._raw_data[1], to._raw_data[2] - from._raw_data[2]);
		}
		
		public static function vectorNormalize(target:AWVector):AWVector {
			var len:Number = target.length;
			return new AWVector(target._raw_data[0] / len, target._raw_data[1] / len, target._raw_data[2] / len);
		}
		
		public static function vectorAddition(left:AWVector, right:AWVector):AWVector {
			return new AWVector(left._raw_data[0] + right._raw_data[0], left._raw_data[1] + right._raw_data[1], left._raw_data[2] + right._raw_data[2]);
		}
		
		public static function vectorSubtraction(left:AWVector, right:AWVector):AWVector {
			return new AWVector(left._raw_data[0] - right._raw_data[0], left._raw_data[1] - right._raw_data[1], left._raw_data[2] - right._raw_data[2]);
		}
		
		public static function vectorCrossProduct(left:AWVector, right:AWVector):AWVector {
			var x:Number = left._raw_data[1] * right._raw_data[2] - right._raw_data[1] * left._raw_data[2];
			var y:Number = -left._raw_data[0] * right._raw_data[2] + right._raw_data[0] * left._raw_data[2];
			var z:Number =  left._raw_data[0] * right._raw_data[1] - right._raw_data[0] * left._raw_data[1];
			return new AWVector(x, y, z);
		}
	}
}
