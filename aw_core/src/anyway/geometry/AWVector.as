package anyway.geometry {

	import anyway.core.aw_ns_private;
	import anyway.utils.format;
	
	use namespace aw_ns_private;

	public class AWVector {
		public function AWVector(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0) {
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = 0.0;
		}

		aw_ns_private const _raw_data:Vector.<Number> = new Vector.<Number>(4, true);

		public function get length():Number {
			var result:Number = 0.0;

			for each(var component:Number in _raw_data) {
				result += Math.pow(component, 2);
			}

			return Math.sqrt(result);
		}

		public function normalize():AWVector {
			var len:Number = this.length;
			return new AWVector(_raw_data[0] / len, _raw_data[1] / len, _raw_data[2] / len);
		}

		public function addition(target:AWVector):AWVector {
			return new AWVector(_raw_data[0] + target._raw_data[0], _raw_data[1] + target._raw_data[1], _raw_data[2] + target._raw_data[2]);
		}

		public function subtraction(target:AWVector):AWVector {
			return new AWVector(_raw_data[0] - target._raw_data[0], _raw_data[1] - target._raw_data[1], _raw_data[2] - target._raw_data[2]);
		}

		public function dotProduct(target:AWVector):Number {
			var result:Number = 0.0;

			for(var i:int = 0; i < _raw_data.length; ++i) {
				result += _raw_data[i] * target._raw_data[i];
			}
			return result;
		}

		public function crossProduct(target:AWVector):AWVector {
			return new AWVector(
				_raw_data[1] * target._raw_data[2] - target._raw_data[1] * _raw_data[2], 
				-_raw_data[0] * target._raw_data[2] + target._raw_data[0] * _raw_data[2], 
				_raw_data[0] * target._raw_data[1] - target._raw_data[0] * _raw_data[1]);
		}

		public function toString():String {
			return "<" + format(_raw_data[0]) + ", " + format(_raw_data[1]) + ", " + format(_raw_data[2]) + ">";
		}
	}
}
