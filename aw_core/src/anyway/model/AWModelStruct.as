package anyway.model {
	import flash.display.BitmapData;

	public class AWModelStruct {

		public function AWModelStruct() {
		}

		public var vertexData:Vector.<Number>;
		public var indexData:Vector.<uint>;

		public var data32_per_vertex:uint;
		public var bitmapdata:BitmapData;
		
		public function get numVertices():uint{
			return vertexData.length / data32_per_vertex;
		}
		public function get numIndices():uint{
			return indexData.length;
		}
	}
}
