package anyway.utils {

	import anyway.constant.AWCoordinateConst;
	import anyway.constant.AWMathConst;
	import anyway.core.ns_aw;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;

	use namespace ns_aw;

	public class AWMathUtil {
		/**
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
			var rad:Number = deg * AWMathConst.DEG_2_RAD;
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

		public static function makeUVNMatrix(place_at:AWVector, point_to:AWVector, up_vector:AWVector):AWMatrix {
			var n:AWVector = new AWVector(point_to.x - place_at.x, point_to.y - place_at.y, point_to.z - place_at.z);
			n.normalize();
			
			var u:AWVector = new AWVector();
			u.copyRawData(up_vector._raw_data);
			u.crossProduct(n);
			u.normalize();
			
			var v:AWVector = new AWVector();
			v.copyRawData(n._raw_data);
			v.crossProduct(u);
			v.normalize();
			
			var t:AWVector = new AWVector(place_at.x, place_at.y, place_at.z);
			var tx:Number = - t.dotProduct(u);
			var ty:Number = - t.dotProduct(v);
			var tz:Number = - t.dotProduct(n);
			var tt:AWVector = new AWVector(tx, ty, tz, 1);
			
			var result:AWMatrix = new AWMatrix();
			
			result.copyColumnFrom(0, u._raw_data);
			result.copyColumnFrom(1, v._raw_data);
			result.copyColumnFrom(2, n._raw_data);
			result.copyRowFrom(3, tt._raw_data);
			
			return result;
		}

		public static function makeProjectionMatrix(fovx_deg:Number, aspectRatio:Number, near:Number, far:Number):AWMatrix {
			var zoom_x:Number = 1 / Math.tan(fovx_deg * AWMathConst.DEG_2_RAD / 2);
			var zoom_y:Number = aspectRatio * zoom_x;
			
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
				zoom_x, 0.0, 0.0, 0.0,
				0.0, zoom_y, 0.0, 0.0,
				0.0, 0.0, (far)/(far - near), 1.0,
				0.0, 0.0, (- far * near)/(far - near), 0.0
			]));
			
			return result;
		}
		
		public static function makeScreenMatrix(view_port_width:Number, view_port_original_width:Number, view_port_height:Number, view_port_original_height:Number, aspectRatio:Number):AWMatrix{
			var half_width:Number = (view_port_width - 1) / 2;
			var half_height:Number = (view_port_height - 1) / 2;
			
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
				half_width * view_port_original_width / view_port_width, 0.0, 0.0, 0.0,
				0.0, -half_height * view_port_original_height / (view_port_height * aspectRatio), 0.0, 0.0,
				0.0, 0.0, 1.0, 0.0,
				half_width, half_height, 0.0, 1.0
			]));
			
			return result;
		}
	}
}
