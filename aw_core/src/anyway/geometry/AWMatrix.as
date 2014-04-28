package anyway.geometry {

	import anyway.core.ns.anyway_internal_geometry;
	import anyway.utils.AWMathUtil;
	import anyway.utils.format;
	
	use namespace anyway_internal_geometry;
	
	/**
	 * 4X4矩阵使用一维数组保存，对于矩阵
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{12} %26 m_{13} %26 m_{14}\\ m_{21} %26 m_{22} %26 m_{23} %26 m_{24}\\ m_{31} %26 m_{32} %26 m_{33} %26 m_{34}\\ m_{41} %26 m_{42} %26 m_{43} %26 m_{44}\end{bmatrix}"/></p>
	 * <p>D3D使用行主序保存为<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{12} %26 m_{13} %26 m_{14} %26 m_{21} %26 m_{22} %26 m_{23} %26 m_{24} %26 m_{31} %26 m_{32} %26 m_{33} %26 m_{34} %26 m_{41} %26 m_{42} %26 m_{43} %26 m_{44}\end{bmatrix}"/></p>
	 * <p>OGL使用列主序保存为<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\begin{bmatrix}m_{11} %26 m_{21} %26 m_{31} %26 m_{41} %26 m_{12} %26 m_{22} %26 m_{32} %26 m_{42} %26 m_{13} %26 m_{23} %26 m_{33} %26 m_{43} %26 m_{14} %26 m_{24} %26 m_{34} %26 m_{44}\end{bmatrix}"/></p>
	 */
	public class AWMatrix {
		private static const ROWS_COUNT:uint = 4;
		private static const COLUMNS_COUNT:uint = 4;
		
		
		public function AWMatrix() {
			this.identity();
		}

		anyway_internal_geometry const _raw_data:Vector.<Number> = new Vector.<Number>(ROWS_COUNT * COLUMNS_COUNT, true);

		public function multiply(target:AWMatrix):AWMatrix {
			var temp:Vector.<Number> = new Vector.<Number>();
			var sum:Number;

			for(var row:int = 0; row < ROWS_COUNT; ++row) {
				for(var cloumn:int = 0; cloumn < COLUMNS_COUNT; ++cloumn) {
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
		 * <p>0, 0, 0, 1</p>
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
			for(var row:int = 0; row < ROWS_COUNT; ++row) {
				for(var cloumn:int = 0; cloumn < COLUMNS_COUNT; ++cloumn) {
					if(row < cloumn) {
						temp = _raw_data[row * COLUMNS_COUNT + cloumn];
						_raw_data[row * COLUMNS_COUNT + cloumn] = _raw_data[row + cloumn * ROWS_COUNT];
						_raw_data[row + cloumn * ROWS_COUNT] = temp;
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
			this.copyRawData(this.multiply(AWMathUtil.makeTranslateMatrix(tx, ty, tz))._raw_data);
		}

		/**
		 * 缩放
		 * @param sx
		 * @param sy
		 * @param sz
		 */
		public function scale(sx:Number = 1.0, sy:Number = 1.0, sz:Number = 1.0):void {
			this.copyRawData(this.multiply(AWMathUtil.makeScaleMatrix(sx, sy, sz))._raw_data);
		}

		/**
		 * 旋转
		 * @param deg 角度
		 * @param axis 旋转轴
		 * @see anyway.constant.AWCoordinateConst
		 */
		public function rotate(deg:Number = 0.0, axis:uint = 1):void {
			this.copyRawData(this.multiply(AWMathUtil.makeRotateMatrix(deg, axis))._raw_data);
		}

		public function copyRawData(raw_data:Vector.<Number>):void {
			for(var i:int = 0; i < ROWS_COUNT * COLUMNS_COUNT; ++i) {
				_raw_data[i] = raw_data[i];
			}
		}

		public function copyRowFrom(row:uint, raw_data:Vector.<Number>):void {
			for(var cloumn:int = 0; cloumn < COLUMNS_COUNT; ++cloumn) {
				_raw_data[row * COLUMNS_COUNT + cloumn] = raw_data[cloumn];
			}
		}

		public function copyRowTo(row:uint, raw_data:Vector.<Number>):void {
			for(var cloumn:int = 0; cloumn < COLUMNS_COUNT; ++cloumn) {
				raw_data[cloumn] = _raw_data[row * COLUMNS_COUNT + cloumn];
			}
		}

		public function copyColumnFrom(cloumn:uint, raw_data:Vector.<Number>):void {
			for(var row:int = 0; row < ROWS_COUNT; ++row) {
				_raw_data[cloumn + row * COLUMNS_COUNT] = raw_data[row];
			}
		}
		
		public function copyColumnTo(cloumn:uint, raw_data:Vector.<Number>):void{
			for(var row:int = 0; row < ROWS_COUNT; ++row) {
				raw_data[row] = _raw_data[cloumn + row * COLUMNS_COUNT];
			}
		}

		public function toString():String {
			var result:Vector.<String> = new Vector.<String>();

			var temp:Vector.<String>;

			for(var row:int = 0; row < ROWS_COUNT; ++row) {
				temp = new Vector.<String>();

				for(var cloumn:int = 0; cloumn < COLUMNS_COUNT; ++cloumn) {
					temp.push(format(_raw_data[row * COLUMNS_COUNT + cloumn]));
				}
				result.push("[" + temp.join(", ") + "]");
			}

			return result.join("\n");
		}
	}
}
