package anyway.geometry {

	import anyway.core.ns_aw;
	import anyway.utils.AWFormatUtil;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	/**
	 * 4X4矩阵使用一维数组保存
	 */
	public final class AWMatrix {
		ns_aw const _raw_data:Vector.<Number> = new Vector.<Number>(16, true);
		
		public function AWMatrix() {
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

		public function transpose():AWMatrix {
			var temp:Number = 0.0;
			
			temp = _raw_data[1];
			_raw_data[1] = _raw_data[4];
			_raw_data[4] = temp;
			
			temp = _raw_data[2];
			_raw_data[2] = _raw_data[8];
			_raw_data[8] = temp;
			
			temp = _raw_data[3];
			_raw_data[3] = _raw_data[12];
			_raw_data[12] = temp;
			
			temp = _raw_data[6];
			_raw_data[6] = _raw_data[9];
			_raw_data[9] = temp;
			
			temp = _raw_data[7];
			_raw_data[7] = _raw_data[13];
			_raw_data[13] = temp;
			
			temp = _raw_data[11];
			_raw_data[11] = _raw_data[14];
			_raw_data[14] = temp;
			
			return this;
		}

		public function translate(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			this.multiply(AWMathUtil.makeTranslateMatrix(tx, ty, tz));
			
			return this;
		}

		public function scale(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):AWMatrix {
			this.multiply(AWMathUtil.makeScaleMatrix(sx, sy, sz));
			
			return this;
		}

		public function rotate(deg:Number = 0.0, axis:uint = 1):AWMatrix {
			this.multiply(AWMathUtil.makeRotateMatrix(deg, axis));
			
			return this;
		}

		public function multiply(right:AWMatrix):void {
			this.copyRawData(Vector.<Number>([
				_raw_data[0] * right._raw_data[0] + _raw_data[1] * right._raw_data[4] + _raw_data[2] * right._raw_data[8] + _raw_data[3] * right._raw_data[12],
				_raw_data[0] * right._raw_data[1] + _raw_data[1] * right._raw_data[5] + _raw_data[2] * right._raw_data[9] + _raw_data[3] * right._raw_data[13],
				_raw_data[0] * right._raw_data[2] + _raw_data[1] * right._raw_data[6] + _raw_data[2] * right._raw_data[10] + _raw_data[3] * right._raw_data[14],
				_raw_data[0] * right._raw_data[3] + _raw_data[1] * right._raw_data[7] + _raw_data[2] * right._raw_data[11] + _raw_data[3] * right._raw_data[15],
				
				_raw_data[4] * right._raw_data[0] + _raw_data[5] * right._raw_data[4] + _raw_data[6] * right._raw_data[8] + _raw_data[7] * right._raw_data[12],
				_raw_data[4] * right._raw_data[1] + _raw_data[5] * right._raw_data[5] + _raw_data[6] * right._raw_data[9] + _raw_data[7] * right._raw_data[13],
				_raw_data[4] * right._raw_data[2] + _raw_data[5] * right._raw_data[6] + _raw_data[6] * right._raw_data[10] + _raw_data[7] * right._raw_data[14],
				_raw_data[4] * right._raw_data[3] + _raw_data[5] * right._raw_data[7] + _raw_data[6] * right._raw_data[11] + _raw_data[7] * right._raw_data[15],
				
				_raw_data[8] * right._raw_data[0] + _raw_data[9] * right._raw_data[4] + _raw_data[10] * right._raw_data[8] + _raw_data[11] * right._raw_data[12],
				_raw_data[8] * right._raw_data[1] + _raw_data[9] * right._raw_data[5] + _raw_data[10] * right._raw_data[9] + _raw_data[11] * right._raw_data[13],
				_raw_data[8] * right._raw_data[2] + _raw_data[9] * right._raw_data[6] + _raw_data[10] * right._raw_data[10] + _raw_data[11] * right._raw_data[14],
				_raw_data[8] * right._raw_data[3] + _raw_data[9] * right._raw_data[7] + _raw_data[10] * right._raw_data[11] + _raw_data[11] * right._raw_data[15],
				
				_raw_data[12] * right._raw_data[0] + _raw_data[13] * right._raw_data[4] + _raw_data[14] * right._raw_data[8] + _raw_data[15] * right._raw_data[12],
				_raw_data[12] * right._raw_data[1] + _raw_data[13] * right._raw_data[5] + _raw_data[14] * right._raw_data[9] + _raw_data[15] * right._raw_data[13],
				_raw_data[12] * right._raw_data[2] + _raw_data[13] * right._raw_data[6] + _raw_data[14] * right._raw_data[10] + _raw_data[15] * right._raw_data[14],
				_raw_data[12] * right._raw_data[3] + _raw_data[13] * right._raw_data[7] + _raw_data[14] * right._raw_data[11] + _raw_data[15] * right._raw_data[15]
			]));
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
			var idx:uint = row * 4;
			_raw_data[idx + 0] = raw_data[0];
			_raw_data[idx + 1] = raw_data[1];
			_raw_data[idx + 2] = raw_data[2];
			_raw_data[idx + 3] = raw_data[3];
		}

		public function copyRowTo(row:uint, raw_data:Vector.<Number>):void {
			var idx:uint = row * 4;
			raw_data[0] = _raw_data[idx + 0];
			raw_data[1] = _raw_data[idx + 1];
			raw_data[2] = _raw_data[idx + 2];
			raw_data[3] = _raw_data[idx + 3];
		}

		public function copyColumnFrom(cloumn:uint, raw_data:Vector.<Number>):void {
			_raw_data[cloumn + 0] = raw_data[0];
			_raw_data[cloumn + 4] = raw_data[1];
			_raw_data[cloumn + 8] = raw_data[2];
			_raw_data[cloumn + 12] = raw_data[3];
		}

		public function copyColumnTo(cloumn:uint, raw_data:Vector.<Number>):void {
			raw_data[0] = _raw_data[cloumn + 0];
			raw_data[1] = _raw_data[cloumn + 4];
			raw_data[2] = _raw_data[cloumn + 8];
			raw_data[3] = _raw_data[cloumn + 12];
		}

		public function format():void {
			trace(AWFormatUtil.format_matrix(this));
		}
	}
}
