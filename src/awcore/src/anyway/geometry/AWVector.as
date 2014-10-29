package anyway.geometry {

	import anyway.core.aw_ns;
	import anyway.utils.AWFormatUtil;

	use namespace aw_ns;

	/**
	 * 向量
	 */
	public final class AWVector {
		public function AWVector(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0, w:Number = 0.0) {
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = w;
		}

		aw_ns const _raw_data:Vector.<Number> = new Vector.<Number>(4, true);

		/**
		 * 向量长度（模）
		 * @return
		 */
		public function get length():Number {
			var result:Number = 0.0;

			result += Math.pow(_raw_data[0], 2);
			result += Math.pow(_raw_data[1], 2);
			result += Math.pow(_raw_data[2], 2);

			return Math.sqrt(result);
		}

		/**
		 * 归一化
		 */
		public function normalize():AWVector {
			var len:Number = this.length;

			_raw_data[0] /= len;
			_raw_data[1] /= len;
			_raw_data[2] /= len;

			return this;
		}

		/**
		 * 向量加法
		 * @param target
		 * @return
		 */
		public function addition(right:AWVector):AWVector {
			_raw_data[0] += right._raw_data[0];
			_raw_data[1] += right._raw_data[1];
			_raw_data[2] += right._raw_data[2];
			return this;
		}

		/**
		 * 向量减法
		 * @param target
		 * @return
		 */
		public function subtraction(right:AWVector):AWVector {
			_raw_data[0] -= right._raw_data[0];
			_raw_data[1] -= right._raw_data[1];
			_raw_data[2] -= right._raw_data[2];
			return this;
		}

		/**
		 * 向量点积（数量积，内积）
		 * @param target
		 * @return
		 */
		public function dotProduct(right:AWVector):Number {
			var result:Number = 0.0;

			result += _raw_data[0] * right._raw_data[0];
			result += _raw_data[1] * right._raw_data[1];
			result += _raw_data[2] * right._raw_data[2];

			return result;
		}

		/**
		 * 向量叉积（向量积）
		 * @param target
		 */
		public function crossProduct(right:AWVector):AWVector {
			var x:Number = _raw_data[1] * right._raw_data[2] - right._raw_data[1] * _raw_data[2];
			var y:Number = -_raw_data[0] * right._raw_data[2] + right._raw_data[0] * _raw_data[2];
			var z:Number = _raw_data[0] * right._raw_data[1] - right._raw_data[0] * _raw_data[1];
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			return this;
		}

		public function copyRawData(raw_data:Vector.<Number>):void {
			_raw_data[0] = raw_data[0];
			_raw_data[1] = raw_data[1];
			_raw_data[2] = raw_data[2];
			_raw_data[3] = raw_data[3];
		}

		/**
		 * 向量是否一致
		 * @param target
		 * @return
		 */
		public function isCongruent(target:AWVector):Boolean {
			if(this == target) {
				return true;
			}

			if(_raw_data[0] != target._raw_data[0]) {
				return false;
			}

			if(_raw_data[1] != target._raw_data[1]) {
				return false;
			}

			if(_raw_data[2] != target._raw_data[2]) {
				return false;
			}
			
			if(_raw_data[3] != target._raw_data[3]) {
				return false;
			}
			return true;
		}

		public function toString():String {
			return AWFormatUtil.format_vector(this);
		}

		public function get x():Number {
			return _raw_data[0];
		}

		public function set x(value:Number):void {
			_raw_data[0] = value;
		}

		public function get y():Number {
			return _raw_data[1];
		}

		public function set y(value:Number):void {
			_raw_data[1] = value;
		}

		public function get z():Number {
			return _raw_data[2];
		}

		public function set z(value:Number):void {
			_raw_data[2] = value;
		}
		
		public function get w():Number {
			return _raw_data[3];
		}

		public function set w(value:Number):void {
			_raw_data[3] = value;
		}
	}
}
