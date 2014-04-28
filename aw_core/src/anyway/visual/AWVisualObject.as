package anyway.visual{
	import anyway.core.ns.anyway_internal_visual;
	import anyway.geometry.AWPoint;
	
	use namespace anyway_internal_visual;
	
	public class AWVisualObject{
		anyway_internal_visual var _parent:AWVisualObjectContainer;
		
		anyway_internal_visual var _anchor:AWPoint;
		anyway_internal_visual var _position:AWPoint;
		
		public function AWVisualObject(){
			_anchor = new AWPoint();
			_position = new AWPoint();
		}
		
		public function get x():Number{
			return _position.x;
		}
		public function set x(value:Number):void{
			_position.x = value;
		}
		
		public function get y():Number{
			return _position.y;
		}
		public function set y(value:Number):void{
			_position.y = value;
		}
	}
}