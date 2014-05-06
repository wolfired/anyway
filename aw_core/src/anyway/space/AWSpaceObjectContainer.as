package anyway.space {

	import anyway.core.ns.anyway_internal_space;

	use namespace anyway_internal_space;

	public class AWSpaceObjectContainer extends AWSpaceObject {

		public function AWSpaceObjectContainer() {
		}

		anyway_internal_space const _children:Vector.<AWSpaceObject> = new Vector.<AWSpaceObject>();

//		public function addChild(child:AWSpaceObject):void {
//			if(null == child._parent) {
//				child._parent = this;
//				child._index = _children.push(child);
//			} else if(this != child._parent) {
//				child._parent._children.splice(child._index, 1);
//				child._parent = this;
//				child._index = _children.push(child);
//			} else if(_children.length - 1 != child._index) {
//				_children.splice(child._index, 1);
//				child._index = _children.push(child);
//			}
//		}

		public function addChildAt(child:AWSpaceObject, index:uint = uint.MAX_VALUE):void {
			if(_children.length <= index) {
				index = _children.length;
			}

			if(null == child._parent) {
				child._parent = this;
				_children.splice(index, 0, child);
			} else if(this != child._parent) {
				child._parent._children.splice(child._index, 1);
				child._parent = this;
				_children.splice(index, 0, child);
			} else if(index != child._index) {
				_children.splice(child._index, 1);
				_children.splice(index, 0, child);
			}

			child._index = index;
		}

//		public function delChild(child:AWSpaceObject):void {
//			if(this == child._parent) {
//				_children.splice(child._index, 1)[0]._parent = null;
//			}
//		}

		public function delChildAt(index:uint = uint.MAX_VALUE):void {
			if(_children.length <= index) {
				_children.pop()._parent = null;
			} else {
				_children.splice(index, 1)[0]._parent = null;
			}
		}

		public function getChildAt(index:uint = uint.MAX_VALUE):AWSpaceObject {
			if(_children.length <= index) {
				index = _children.length - 1;
			}
			return _children[index];
		}

		public function get numChildren():uint {
			return _children.length;
		}
	}
}
