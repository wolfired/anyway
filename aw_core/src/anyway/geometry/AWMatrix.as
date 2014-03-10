package anyway.geometry {

	import anyway.utils.AWMatrixUtil;
	import anyway.utils.format;

	public class AWMatrix {
		public function AWMatrix() {
			this.identity();
		}

		private const _raw_data:Vector.<Number> = new Vector.<Number>(16, true);

		public function multiply(target:AWMatrix):AWMatrix {
			var temp:Vector.<Number> = new Vector.<Number>();
			var sum:Number;

			for(var row:int = 0; row < 4; ++row) {
				for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
					sum = 0.0;

					for(var i:int = 0; i < 4; ++i) {
						sum += _raw_data[row * 4 + i] * target._raw_data[cloumn + i * 4];
					}
					temp.push(sum);
				}
			}
			var result:AWMatrix = new AWMatrix();
			result.copyRawData(temp);
			return result;
		}

		/**
		 * <p>1, 0, 0, 0</p>
		 * <p>0, 1, 0, 0</p>
		 * <p>0, 0, 1, 0</p>
		 * <p> 0, 0, 0, 1</p>
		 */
		public function identity():void {
			this.copyRawData(Vector.<Number>([
											 1, 0, 0, 0,
											 0, 1, 0, 0,
											 0, 0, 1, 0,
											 0, 0, 0, 1]));
		}

		/**
		 * 矩阵转置
		 */
		public function transpose():void {
			var temp:Number;

			for(var row:int = 0; row < 4; ++row) {
				for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
					if(row < cloumn) {
						temp = _raw_data[row * 4 + cloumn];
						_raw_data[row * 4 + cloumn] = _raw_data[row + cloumn * 4];
						_raw_data[row + cloumn * 4] = temp;
					}
				}
			}
		}

		/**
		 * 平移
		 * @param tx
		 * @param ty
		 * @param tz
		 */
		public function translate(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):void {
			this.copyRawData(this.multiply(AWMatrixUtil.makeTranslateMatrix(tx, ty, tz))._raw_data);
		}

		/**
		 * 缩放
		 * @param sx
		 * @param sy
		 * @param sz
		 */
		public function scale(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):void {
			this.copyRawData(this.multiply(AWMatrixUtil.makeScaleMatrix(sx, sy, sz))._raw_data);
		}

		/**
		 * 旋转
		 * @param deg 角度
		 * @param axis 旋转轴
		 * @see anyway.constant.AWCoordinateConst
		 */
		public function rotate(deg:Number = 0.0, axis:uint = 1):void {
			this.copyRawData(this.multiply(AWMatrixUtil.makeRotateMatrix(deg, axis))._raw_data);
		}

		public function copyRawData(raw_data:Vector.<Number>):void {
			for(var i:int = 0; i < 16; ++i) {
				_raw_data[i] = raw_data[i];
			}
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

		public function toString():String {
			var result:Vector.<String> = new Vector.<String>();

			var temp:Vector.<String>;

			for(var row:int = 0; row < 4; ++row) {
				temp = new Vector.<String>();

				for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
					temp.push(format(_raw_data[row * 4 + cloumn]));
				}
				result.push("[" + temp.join(", ") + "]");
			}

			return result.join("\n");
		}

		public function print():void {
			trace(this.toString());
		}
	}
}
