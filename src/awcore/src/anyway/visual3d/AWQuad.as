package anyway.visual3d{
	import flash.display.BitmapData;
	
	import anyway.core.ns_aw;
	import anyway.face.AWIRotatable;
	import anyway.face.AWITranslateable;
	
	use namespace ns_aw;

	public class AWQuad extends AWVisualObject implements AWITranslateable, AWIRotatable{
		public var _vertexData:Vector.<Number>;
		public var _indexData:Vector.<uint>;
		public var ttt:BitmapData;
		
		public var original_width:Number = 400;
		public var original_height:Number = 400;
		
		public function AWQuad(){
			_indexData = Vector.<uint>([0, 1, 2, 0, 2, 3]);
		}
		
		public function setSize(w:Number, h:Number):void{
			w /= 2;
			h /= 2;
			_vertexData = Vector.<Number>([
				-w, -h, 0, 0, 0,
				-w, h, 0, 0, 1,
				w, h, 0, 1, 1,
				w, -h, 0, 1, 0
			]);
		}
		
		public function translate(tx:Number, ty:Number, tz:Number):void{
			this.x += tx;
			this.y += ty;
			this.z += tz;
		}
		
		public function rotate(angle_deg:Number, x:Number, y:Number, z:Number):void{
			
		}
	}
}