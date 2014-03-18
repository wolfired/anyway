package anyway.utils {

	import anyway.constant.AWCoordinateConst;
	import anyway.constant.AWMathConst;
	import anyway.core.anyway_internal;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;
	
	use namespace anyway_internal;

	public class AWMathUtil {
		/**
		 * <p> 1, 0, 0, tx</p>
		 * <p> 0, 1, 0, ty</p>
		 * <p> 0, 0, 1, tz</p>
		 * <p> 0, 0, 0, 1 </p>
		 * @param tx
		 * @param ty
		 * @param tz
		 * @return 平移矩阵
		 */
		public static function makeTranslateMatrix(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
											   1, 0, 0, tx,
											   0, 1, 0, ty,
											   0, 0, 1, tz,
											   0, 0, 0, 1]));
			return result;
		}

		/**
		 * <p>sx, 0 , 0 , 0</p>
		 * <p>0 , sy, 0 , 0</p>
		 * <p>0 , 0 , sz, 0</p>
		 * <p>0 , 0 , 0 , 1</p>
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
													   Math.cos(rad), 0, Math.sin(rad), 0,
													   0, 1, 0, 0,
													   -Math.sin(rad), 0, Math.cos(rad), 0,
													   0, 0, 0, 1]));
					break;
				}
				case AWCoordinateConst.AXIS_Z: {
					result.copyRawData(Vector.<Number>([
													   Math.cos(rad), -Math.sin(rad), 0, 0,
													   Math.sin(rad), Math.cos(rad), 0, 0,
													   0, 0, 1, 0,
													   0, 0, 0, 1]));
					break;
				}
				default: {
					result.copyRawData(Vector.<Number>([
													   1, 0, 0, 1,
													   0, Math.cos(rad), -Math.sin(rad), 0,
													   0, Math.sin(rad), Math.cos(rad), 0,
													   0, 0, 0, 1]));
				}
			}
			return result;
		}

		public static function makeVector(from:AWPoint, to:AWPoint):AWVector{
			return new AWVector(to._raw_data[0] - from._raw_data[0], to._raw_data[1] - from._raw_data[1], to._raw_data[2] - from._raw_data[2]);
		}
	}
}
