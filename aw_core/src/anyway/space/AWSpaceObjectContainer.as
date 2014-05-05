package anyway.space {

	public class AWSpaceObjectContainer extends AWSpaceObject {

		public function AWSpaceObjectContainer() {
		}

		private const _children:Vector.<AWSpaceObject> = new Vector.<AWSpaceObject>();

		public function addChild(target:AWSpaceObject):AWSpaceObject {

			return target;
		}
		
		public function delChild(target:AWSpaceObject):AWSpaceObject{
			
			return target;
		}
	}
}
