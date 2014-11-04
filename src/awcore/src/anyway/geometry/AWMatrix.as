package anyway.geometry {

	import anyway.core.ns_aw;
	import anyway.utils.AWFormatUtil;
	import anyway.utils.AWMathUtil;

	use namespace ns_aw;

	/**
	 * 矩阵
	 */
	public final class AWMatrix {
		ns_aw const _raw_data:Vector.<Number> = new Vector.<Number>(16, true);
		
		public function AWMatrix() {
		}
		
		public function identity():AWMatrix {
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
			
			return this;
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

		public function multiply(right:AWMatrix):AWMatrix {
			var ma:Number, mb:Number, mc:Number, md:Number;
			
			ma = _raw_data[0] * right._raw_data[0] + _raw_data[1] * right._raw_data[4] + _raw_data[2] * right._raw_data[8] + _raw_data[3] * right._raw_data[12];
			mb = _raw_data[0] * right._raw_data[1] + _raw_data[1] * right._raw_data[5] + _raw_data[2] * right._raw_data[9] + _raw_data[3] * right._raw_data[13];
			mc = _raw_data[0] * right._raw_data[2] + _raw_data[1] * right._raw_data[6] + _raw_data[2] * right._raw_data[10] + _raw_data[3] * right._raw_data[14];
			md = _raw_data[0] * right._raw_data[3] + _raw_data[1] * right._raw_data[7] + _raw_data[2] * right._raw_data[11] + _raw_data[3] * right._raw_data[15];
			_raw_data[0] = ma;
			_raw_data[1] = mb;
			_raw_data[2] = mc;
			_raw_data[3] = md;
			
			ma = _raw_data[4] * right._raw_data[0] + _raw_data[5] * right._raw_data[4] + _raw_data[6] * right._raw_data[8] + _raw_data[7] * right._raw_data[12];
			mb = _raw_data[4] * right._raw_data[1] + _raw_data[5] * right._raw_data[5] + _raw_data[6] * right._raw_data[9] + _raw_data[7] * right._raw_data[13];
			mc = _raw_data[4] * right._raw_data[2] + _raw_data[5] * right._raw_data[6] + _raw_data[6] * right._raw_data[10] + _raw_data[7] * right._raw_data[14];
			md = _raw_data[4] * right._raw_data[3] + _raw_data[5] * right._raw_data[7] + _raw_data[6] * right._raw_data[11] + _raw_data[7] * right._raw_data[15];
			_raw_data[4] = ma;
			_raw_data[5] = mb;
			_raw_data[6] = mc;
			_raw_data[7] = md;
			
			ma = _raw_data[8] * right._raw_data[0] + _raw_data[9] * right._raw_data[4] + _raw_data[10] * right._raw_data[8] + _raw_data[11] * right._raw_data[12];
			mb = _raw_data[8] * right._raw_data[1] + _raw_data[9] * right._raw_data[5] + _raw_data[10] * right._raw_data[9] + _raw_data[11] * right._raw_data[13];
			mc = _raw_data[8] * right._raw_data[2] + _raw_data[9] * right._raw_data[6] + _raw_data[10] * right._raw_data[10] + _raw_data[11] * right._raw_data[14];
			md = _raw_data[8] * right._raw_data[3] + _raw_data[9] * right._raw_data[7] + _raw_data[10] * right._raw_data[11] + _raw_data[11] * right._raw_data[15];
			_raw_data[8] = ma;
			_raw_data[9] = mb;
			_raw_data[10] = mc;
			_raw_data[11] = md;
			
			ma = _raw_data[12] * right._raw_data[0] + _raw_data[13] * right._raw_data[4] + _raw_data[14] * right._raw_data[8] + _raw_data[15] * right._raw_data[12];
			mb = _raw_data[12] * right._raw_data[1] + _raw_data[13] * right._raw_data[5] + _raw_data[14] * right._raw_data[9] + _raw_data[15] * right._raw_data[13];
			mc = _raw_data[12] * right._raw_data[2] + _raw_data[13] * right._raw_data[6] + _raw_data[14] * right._raw_data[10] + _raw_data[15] * right._raw_data[14];
			md = _raw_data[12] * right._raw_data[3] + _raw_data[13] * right._raw_data[7] + _raw_data[14] * right._raw_data[11] + _raw_data[15] * right._raw_data[15];
			_raw_data[12] = ma;
			_raw_data[13] = mb;
			_raw_data[14] = mc;
			_raw_data[15] = md;
			
			return this;
		}

		public function copyFromRawData(raw_data:Vector.<Number>):void {
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
		
		public function copyToRawData(raw_data:Vector.<Number>):void {
			raw_data[0] = _raw_data[0];
			raw_data[1] = _raw_data[1];
			raw_data[2] = _raw_data[2];
			raw_data[3] = _raw_data[3];
			raw_data[4] = _raw_data[4];
			raw_data[5] = _raw_data[5];
			raw_data[6] = _raw_data[6];
			raw_data[7] = _raw_data[7];
			raw_data[8] = _raw_data[8];
			raw_data[9] = _raw_data[9];
			raw_data[10] = _raw_data[10];
			raw_data[11] = _raw_data[11];
			raw_data[12] = _raw_data[12];
			raw_data[13] = _raw_data[13];
			raw_data[14] = _raw_data[14];
			raw_data[15] = _raw_data[15];
		}
		
		public function copyFromMatrix(src:AWMatrix):void{
			_raw_data[0] = src._raw_data[0];
			_raw_data[1] = src._raw_data[1];
			_raw_data[2] = src._raw_data[2];
			_raw_data[3] = src._raw_data[3];
			_raw_data[4] = src._raw_data[4];
			_raw_data[5] = src._raw_data[5];
			_raw_data[6] = src._raw_data[6];
			_raw_data[7] = src._raw_data[7];
			_raw_data[8] = src._raw_data[8];
			_raw_data[9] = src._raw_data[9];
			_raw_data[10] = src._raw_data[10];
			_raw_data[11] = src._raw_data[11];
			_raw_data[12] = src._raw_data[12];
			_raw_data[13] = src._raw_data[13];
			_raw_data[14] = src._raw_data[14];
			_raw_data[15] = src._raw_data[15];
		}
		
		public function copyToMatrix(dst:AWMatrix):void{
			dst._raw_data[0] = _raw_data[0];
			dst._raw_data[1] = _raw_data[1];
			dst._raw_data[2] = _raw_data[2];
			dst._raw_data[3] = _raw_data[3];
			dst._raw_data[4] = _raw_data[4];
			dst._raw_data[5] = _raw_data[5];
			dst._raw_data[6] = _raw_data[6];
			dst._raw_data[7] = _raw_data[7];
			dst._raw_data[8] = _raw_data[8];
			dst._raw_data[9] = _raw_data[9];
			dst._raw_data[10] = _raw_data[10];
			dst._raw_data[11] = _raw_data[11];
			dst._raw_data[12] = _raw_data[12];
			dst._raw_data[13] = _raw_data[13];
			dst._raw_data[14] = _raw_data[14];
			dst._raw_data[15] = _raw_data[15];
		}
		
		public function get copy():AWMatrix{
			var dst:AWMatrix = new AWMatrix();
			this.copyToRawData(dst._raw_data);
			return dst;
		}

		public function copyRowFrom(row:uint, raw_data:Vector.<Number>):void {
			var mark:uint = row << 2;
			_raw_data[mark + 0] = raw_data[0];
			_raw_data[mark + 1] = raw_data[1];
			_raw_data[mark + 2] = raw_data[2];
			_raw_data[mark + 3] = raw_data[3];
		}

		public function copyRowTo(row:uint, raw_data:Vector.<Number>):void {
			var mark:uint = row << 2;
			raw_data[0] = _raw_data[mark + 0];
			raw_data[1] = _raw_data[mark + 1];
			raw_data[2] = _raw_data[mark + 2];
			raw_data[3] = _raw_data[mark + 3];
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
