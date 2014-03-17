package anyway.geometry {

	import anyway.core.aw_ns_private;
	import anyway.utils.format;

	use namespace aw_ns_private;
	
	public class AWPoint {
		public function AWPoint(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0) {
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = 1.0;
		}

		aw_ns_private const _raw_data:Vector.<Number> = new Vector.<Number>(4, true);

		public function copyFrom(raw_data:Vector.<Number>):void {
			for(var i:int = 0; i < 4; ++i) {
				_raw_data[i] = raw_data[i];
			}
		}

		public function toString():String {
			return "(" + format(_raw_data[0]) + ", " + format(_raw_data[1]) + ", " + format(_raw_data[2]) + ")";
		}

		public function get x():Number {
			return _raw_data[0];
		}

		public function set x(value:Number):void {
			if(_raw_data[0] == value)
				return;
			_raw_data[0] = value;
		}

		public function get y():Number {
			return _raw_data[1];
		}

		public function set y(value:Number):void {
			if(_raw_data[1] == value)
				return;
			_raw_data[1] = value;
		}

		public function get z():Number {
			return _raw_data[2];
		}

		public function set z(value:Number):void {
			if(_raw_data[2] == value)
				return;
			_raw_data[2] = value;
		}
	}
}
