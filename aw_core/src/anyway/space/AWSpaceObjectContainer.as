package anyway.space {
	import anyway.core.ns.anyway_internal_space;

	use namespace anyway_internal_space;
	
	public class AWSpaceObjectContainer extends AWSpaceObject {

		public function AWSpaceObjectContainer() {
		}

		private const _children:Array = new Array();

		public function addChild(child:AWSpaceObject):uint {
			null != child._parent && child._parent.delChild(child);
			return _children.push(child);
		}
		
		public function delChild(child:AWSpaceObject):void{
			if(this == child._parent){
				child._parent = null;
				delete _children[child._index];
			}
		}
	}
}
