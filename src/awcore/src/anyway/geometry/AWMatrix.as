package anyway.geometry {

	import anyway.core.aw_ns;
	import anyway.utils.AWFormatUtil;
	import anyway.utils.AWMathUtil;

	use namespace aw_ns;

	/**
	 * 4X4矩阵使用一维数组保存
	 */
	public class AWMatrix {
		aw_ns const _raw_data:Vector.<Number> = new Vector.<Number>(16, true);
		
		public function AWMatrix() {
			this.identity();
		}

		public function identity():void {
			_raw_data[0] = 1;
			_raw_data[1] = 0;
			_raw_data[2] = 0;
			_raw_data[3] = 0;
			
			_raw_data[4] = 0;
			_raw_data[5] = 1;
			_raw_data[6] = 0;
			_raw_data[7] = 0;
			
			_raw_data[8] = 0;
			_raw_data[9] = 0;
			_raw_data[10] = 1;
			_raw_data[11] = 0;
			
			_raw_data[12] = 0;
			_raw_data[13] = 0;
			_raw_data[14] = 0;
			_raw_data[15] = 1;			
		}

		public function transpose():void {
		}

		public function translate(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			return this.multiply(AWMathUtil.makeTranslateMatrix(tx, ty, tz));
		}

		public function scale(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):AWMatrix {
			return this.multiply(AWMathUtil.makeScaleMatrix(sx, sy, sz));
		}

		public function rotate(deg:Number = 0.0, axis:uint = 1):AWMatrix {
			return this.multiply(AWMathUtil.makeRotateMatrix(deg, axis));
		}

		public function multiply(right:AWMatrix):AWMatrix {
			
			return this;
		}

		public function copyRawData(raw_data:Vector.<Number>):void {
			_raw_data[0] = raw_data[0];
			_raw_data[1] = raw_data[1];
			_raw_data[2] = raw_data[2];
			_raw_data[3] = raw_data[3];
			_raw_data[4] = raw_data[4];
			_raw_data[5] = raw_data[5];
			_raw_data[6] = raw_data[6];
			_raw_data[7] = raw_data[7];
			_raw_data[8] = raw_data[8];
			_raw_data[9] = raw_data[9];
			_raw_data[10] = raw_data[10];
			_raw_data[11] = raw_data[11];
			_raw_data[12] = raw_data[12];
			_raw_data[13] = raw_data[13];
			_raw_data[14] = raw_data[14];
			_raw_data[15] = raw_data[15];
		}

		public function copyRowFrom(row:uint, raw_data:Vector.<Number>):void {
			for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
				_raw_data[row * 4 + cloumn] = raw_data[cloumn];
			}
		}

		public function copyRowTo(row:uint, raw_data:Vector.<Number>):void {
			for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
				raw_data[cloumn] = _raw_data[row * 4 + cloumn];
			}
		}

		public function copyColumnFrom(cloumn:uint, raw_data:Vector.<Number>):void {
			for(var row:int = 0; row < 4; ++row) {
				_raw_data[cloumn + row * 4] = raw_data[row];
			}
		}

		public function copyColumnTo(cloumn:uint, raw_data:Vector.<Number>):void {
			for(var row:int = 0; row < 4; ++row) {
				raw_data[row] = _raw_data[cloumn + row * 4];
			}
		}

		public function toString():String {
			return AWFormatUtil.format_matrix(this);
		}
	}
}
