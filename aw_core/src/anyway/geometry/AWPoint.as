package anyway.geometry {

	import anyway.core.ns.anyway_internal_geometry;
	import anyway.utils.format;

	use namespace anyway_internal_geometry;
	
	public final class AWPoint {
		public function AWPoint(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0) {
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = 1.0;
		}

		anyway_internal_geometry const _raw_data:Vector.<Number> = new Vector.<Number>(4, true);

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
		public function isCongruent(target:AWPoint):Boolean{
			if(this == target){
				return true;
			}
			if(_raw_data[0] != target._raw_data[0]){
				return false;
			}
			if(_raw_data[1] != target._raw_data[1]){
				return false;
			}
			if(_raw_data[2] != target._raw_data[2]){
				return false;
			}
			return true;
		}

		public function toString():String {
			return "(" + format(_raw_data[0]) + ", " + format(_raw_data[1]) + ", " + format(_raw_data[2]) + ")";
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
	}
}
