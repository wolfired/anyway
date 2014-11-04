package anyway.core {
	import anyway.visual3d.AWVisualContainer;
	
	use namespace ns_aw;

	public final class AWScene extends AWVisualContainer{
		private static var IDX:uint = 0;
		
		ns_aw const _idx:uint = ++IDX;
		
		public function AWScene() {
		}
	}
}
