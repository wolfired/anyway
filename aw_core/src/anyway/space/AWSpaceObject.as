package anyway.space {

	import anyway.core.ns.anyway_internal_geometry;
	import anyway.core.ns.anyway_internal_space;
	import anyway.geometry.AWPoint;
	import anyway.model.AWModelStruct;

	use namespace anyway_internal_geometry;
	use namespace anyway_internal_space;

	public class AWSpaceObject {

		public function AWSpaceObject() {
		}

		public var _model:AWModelStruct;
		protected const _position:AWPoint = new AWPoint();

		anyway_internal_space var _parent:AWSpaceObjectContainer;
		anyway_internal_space var _index:uint;

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
