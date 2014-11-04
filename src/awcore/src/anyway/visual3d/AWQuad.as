package anyway.visual3d{
	import flash.display.BitmapData;
	
	import anyway.core.ns_aw;
	
	use namespace ns_aw;

	public class AWQuad extends AWVisualObject{
		ns_aw var _vertexData:Vector.<Number>;
		ns_aw var _indexData:Vector.<uint>;
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
	}
}