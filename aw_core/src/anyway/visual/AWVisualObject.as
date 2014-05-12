package anyway.visual {

	import anyway.core.ns.anyway_internal_visual;
	import anyway.geometry.AWVector;

	use namespace anyway_internal_visual;

	public class AWVisualObject {

		public function AWVisualObject() {
			_anchor = new AWVector();
			_position = new AWVector();
		}

		anyway_internal_visual var _parent:AWVisualObjectContainer;

		anyway_internal_visual var _anchor:AWVector;
		anyway_internal_visual var _position:AWVector;

		public function get x():Number {
			return _position.x;
		}

		public function set x(value:Number):void {
			_position.x = value;
		}

		public function get y():Number {
			return _position.y;
		}

		public function set y(value:Number):void {
			_position.y = value;
		}
	}
}
