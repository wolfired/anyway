package anyway.display {

	import anyway.core.ns.anyway_internal_display;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWVector;

	use namespace anyway_internal_geometry;
	use namespace anyway_internal_display;

	public class AWDisplayObject {

		public function AWDisplayObject() {
		}

		protected const _position:AWVector = new AWVector();

		anyway_internal_display var _parent:AWDisplayObjectContainer;
		anyway_internal_display var _index:uint;

		public function get x():Number {
			return _position._raw_data[0];
		}

		public function set x(value:Number):void {
			_position._raw_data[0] = value;
		}

		public function get y():Number {
			return _position._raw_data[1];
		}

		public function set y(value:Number):void {
			_position._raw_data[1] = value;
		}

		public function get z():Number {
			return _position._raw_data[2];
		}

		public function set z(value:Number):void {
			_position._raw_data[2] = value;
		}
	}
}
