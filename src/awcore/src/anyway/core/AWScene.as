package anyway.core {
	import anyway.visual3d.AWVisualContainer;
	
	use namespace ns_aw;

	public final class AWScene extends AWVisualContainer{
		private static var IDX:uint = 0;
		
		private const _idx:uint = ++IDX;
		private const _cameras:Array = [];
		
		public function AWScene() {
		}
		
		public function get idx():uint{
			return _idx;
		}
		
		public function connect(camera:AWCamera):uint{
			var idx:uint = camera.idx;
			_cameras[idx] = camera;
			return idx;
		}
		
		public function disconnect(idx:uint):AWCamera{
			var camera:AWCamera = _cameras[idx];
			delete _cameras[idx];
			return camera;
		}
		
		public function foreachCamera(handler:Function):void{
			for each (var camera:AWCamera in _cameras) {
				camera.foreachMonitor(handler, camera);
			}
		}
	}
}
