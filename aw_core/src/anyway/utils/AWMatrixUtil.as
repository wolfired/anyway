package anyway.utils{
	import anyway.constant.AWCoordinate;
	import anyway.constant.AWMath;
	import anyway.geometry.AWMatrix;

	public class AWMatrixUtil{
		/**
		 * 1, 0, 0, tx
		 * 0, 1, 0, ty
		 * 0, 0, 1, tz
		 * 0, 0, 0,  1
		 */
		public static function makeTranslateMatrix(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([1, 0, 0, tx, 0, 1, 0, ty, 0, 0, 1, tz, 0, 0, 0, 1]));
			return result;
		}
		
		/**
		 * sx, 	0, 	0, 0
		 * 	0, sy, 	0, 0
		 * 	0, 	0, sz, 0
		 * 	0, 	0, 	0, 1
		 */
		public static function makeScaleMatrix(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([sx, 0, 0, 0, 0, sy, 0, 0, 0, 0, sz, 0, 0, 0, 0, 1]));
			return result;
		}
		
		public static function makeRotateMatrix(deg:Number = 0, axis:uint = AWCoordinate.AXIS_X):AWMatrix {
			var rad:Number = AWMath.DEG_2_RAD * deg;
			var result:AWMatrix = new AWMatrix();
			switch (axis) {
				case AWCoordinate.AXIS_Y:  {
					result.copyRawData(Vector.<Number>([Math.cos(rad), 0, Math.sin(rad), 0, 0, 1, 0, 0, -Math.sin(rad), 0, Math.cos(rad), 0, 0, 0, 0, 1]));
					break;
				}
				case AWCoordinate.AXIS_Z:  {
					result.copyRawData(Vector.<Number>([Math.cos(rad), -Math.sin(rad), 0, 0, Math.sin(rad), Math.cos(rad), 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]));
					break;
				}
				default:  {
					result.copyRawData(Vector.<Number>([1, 0, 0, 1, 0, Math.cos(rad), -Math.sin(rad), 0, 0, Math.sin(rad), Math.cos(rad), 0, 0, 0, 0, 1]));
				}
			}
			return result;
		}
		
		public static function makePerspectiveMatrix(width:Number, 
													 height:Number, 
													 zNear:Number, 
													 zFar:Number):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
				2.0*zNear/width, 0.0, 0.0, 0.0,
				0.0, 2.0*zNear/height, 0.0, 0.0,
				0.0, 0.0, zFar/(zFar-zNear), 1.0,
				0.0, 0.0, zNear*zFar/(zNear-zFar), 0.0
			]));
			return result;
		}
		
		public static function makeOrthoMatrix(width:Number,
											   height:Number,
											   zNear:Number,
											   zFar:Number):AWMatrix {
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(Vector.<Number>([
				2.0/width, 0.0, 0.0, 0.0,
				0.0, 2.0/height, 0.0, 0.0,
				0.0, 0.0, 1.0/(zFar-zNear), 0.0,
				0.0, 0.0, zNear/(zNear-zFar), 1.0
			]));
			return result;
		}
	}
}