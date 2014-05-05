package anyway.geometry {

	import anyway.core.ns.anyway_internal_geometry;
	import anyway.utils.AWMathUtil;
	import anyway.utils.format;

	use namespace anyway_internal_geometry;

	/**
	 * 4X4矩阵使用一维数组保存，对于矩阵
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{12} %26 m_{13} %26 m_{14}\\ m_{21} %26 m_{22} %26 m_{23} %26 m_{24}\\ m_{31} %26 m_{32} %26 m_{33} %26
	 * m_{34}\\ m_{41} %26 m_{42} %26 m_{43} %26 m_{44}\end{bmatrix}"/></p>
	 * <p>D3D使用行主序保存为<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{12} %26 m_{13} %26 m_{14} %26 m_{21} %26 m_{22} %26 m_{23} %26 m_{24} %26 m_{31} %26 m_{32}
	 * %26 m_{33} %26 m_{34} %26 m_{41} %26 m_{42} %26 m_{43} %26 m_{44}\end{bmatrix}"/></p>
	 * <p>OGL使用列主序保存为<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{21} %26 m_{31} %26 m_{41} %26 m_{12} %26 m_{22} %26 m_{32} %26 m_{42} %26 m_{13} %26 m_{23}
	 * %26 m_{33} %26 m_{43} %26 m_{14} %26 m_{24} %26 m_{34} %26 m_{44}\end{bmatrix}"/></p>
	 */
	public class AWMatrix {
		public function AWMatrix() {
		}

		anyway_internal_geometry const _raw_data:Vector.<Number> = new Vector.<Number>(16, true);

		/**
		 * <p>1, 0, 0, 0</p>
		 * <p>0, 1, 0, 0</p>
		 * <p>0, 0, 1, 0</p>
		 * <p>0, 0, 0, 1</p>
		 */
		public function identity():AWMatrix {
			this.copyRawData(Vector.<Number>([
											 1, 0, 0, 0,
											 0, 1, 0, 0,
											 0, 0, 1, 0,
											 0, 0, 0, 1]));
			return this;
		}

		/**
		 * 矩阵转置
		 */
		public function transpose():AWMatrix {
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
			return this;
		}

		/**
		 * 平移
		 * @param tx
		 * @param ty
		 * @param tz
		 */
		public function translate(tx:Number = 0.0, ty:Number = 0.0, tz:Number = 0.0):AWMatrix {
			return this.multiply(AWMathUtil.makeTranslateMatrix(tx, ty, tz));
		}

		/**
		 * 缩放
		 * @param sx
		 * @param sy
		 * @param sz
		 */
		public function scale(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):AWMatrix {
			return this.multiply(AWMathUtil.makeScaleMatrix(sx, sy, sz));
		}

		/**
		 * 旋转
		 * @param deg 角度
		 * @param axis 旋转轴
		 * @see anyway.constant.AWCoordinateConst
		 */
		public function rotate(deg:Number = 0.0, axis:uint = 1):AWMatrix {
			return this.multiply(AWMathUtil.makeRotateMatrix(deg, axis));
		}

		public function multiply(left:AWMatrix):AWMatrix {
			var temp:Vector.<Number> = new Vector.<Number>();
			var sum:Number;

			for(var row:int = 0; row < 4; ++row) {
				for(var cloumn:int = 0; cloumn < 4; ++cloumn) {
					sum = 0.0;

					for(var i:int = 0; i < 4; ++i) {
						sum += _raw_data[row * 4 + i] * left._raw_data[cloumn + i * 4];
					}
					temp.push(sum);
				}
			}
			this.copyRawData(temp);
			return this;
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

		public function copyColumnTo(cloumn:uint, raw_data:Vector.<Number>):void {
			for(var row:int = 0; row < 4; ++row) {
				raw_data[row] = _raw_data[cloumn + row * 4];
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
	}
}
