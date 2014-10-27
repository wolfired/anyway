package anyway.display {

	import anyway.constant.AWCoordinateConst;
	import anyway.core.ns.anyway_internal_display;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;

	use namespace anyway_internal_display;

	use namespace anyway_internal_geometry;

	public class AWDisplayObject {

		public function AWDisplayObject() {
		}

		protected var _rx:Number = 0.0;
		protected var _ry:Number = 0.0;
		protected var _rz:Number = 0.0;
		protected var _x:Number = 0.0;
		protected var _y:Number = 0.0;
		protected var _z:Number = 0.0;
		protected var _sx:Number = 1.0;
		protected var _sy:Number = 1.0;
		protected var _sz:Number = 1.0;

		anyway_internal_display var _parent:AWDisplayObjectContainer;
		anyway_internal_display var _index:uint;
		anyway_internal_display const _transform:AWMatrix = new AWMatrix();
		anyway_internal_display var _transformDirty:Boolean = true;

		public function get rx():Number {
			return _rx;
		}

		public function set rx(value:Number):void {
			if(_rx == value)
				return;
			_rx = value;

			_transformDirty = true;
		}

		public function get ry():Number {
			return _ry;
		}

		public function set ry(value:Number):void {
			if(_ry == value)
				return;
			_ry = value;

			_transformDirty = true;
		}

		public function get rz():Number {
			return _rz;
		}

		public function set rz(value:Number):void {
			if(_rz == value)
				return;
			_rz = value;

			_transformDirty = true;
		}

		public function get x():Number {
			return _x;
		}

		public function set x(value:Number):void {
			if(_x == value)
				return;
			_x = value;

			_transformDirty = true;
		}

		public function get y():Number {
			return _y;
		}

		public function set y(value:Number):void {
			if(_y == value)
				return;
			_y = value;

			_transformDirty = true;
		}

		public function get z():Number {
			return _z;
		}

		public function set z(value:Number):void {
			if(_z == value)
				return;
			_z = value;

			_transformDirty = true;
		}

		public function get sx():Number {
			return _sx;
		}

		public function set sx(value:Number):void {
			if(_sx == value)
				return;
			_sx = value;

			_transformDirty = true;
		}

		public function get sy():Number {
			return _sy;
		}

		public function set sy(value:Number):void {
			if(_sy == value)
				return;
			_sy = value;

			_transformDirty = true;
		}

		public function get sz():Number {
			return _sz;
		}

		public function set sz(value:Number):void {
			if(_sz == value)
				return;
			_sz = value;

			_transformDirty = true;
		}

		public final function get transform():AWMatrix {
			if(_transformDirty) {
				_transformDirty = false;
				_transform.identity();
				_transform.rotate(_rx, AWCoordinateConst.AXIS_X).rotate(_ry, AWCoordinateConst.AXIS_Y).rotate(_rz, AWCoordinateConst.AXIS_Z).translate(_x, _y, _z).scale(_sx, _sy, _sz);
			}
			return _transform;
		}
	}
}
