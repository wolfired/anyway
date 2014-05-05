package anyway.space{
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWPoint;
	
	use namespace anyway_internal_geometry;

	public class AWSpaceObject{
		private const _position:AWPoint = new AWPoint();
		
		public function AWSpaceObject(){
		}
		
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