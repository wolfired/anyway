package anyway.visual{
	import anyway.core.anyway_internal_visual;
	import anyway.exception.AWVisualException;
	
	use namespace anyway_internal_visual;
	
	public class AWVisualObjectContainer extends AWVisualObject{
		
		anyway_internal_visual var _visual_list:Vector.<AWVisualObject>;
		
		public function AWVisualObjectContainer(){
			super();
			
			_visual_list = new Vector.<AWVisualObject>();
		}
		
		public function addChild(child:AWVisualObject):void{
			if(null == child._parent){
				child._parent = this;
			}else if(this == child._parent){
				var temp_index:Number = _visual_list.indexOf(child);
				_visual_list.splice(temp_index, 1);
			}else{
				child._parent.delChild(child);
				child._parent = this;
			}
			_visual_list.push(child);
		}
		public function addChildAt(child:AWVisualObject, index:uint = uint.MAX_VALUE):void{
			if(index >= _visual_list.length){
				index = _visual_list.length;
			}
			
			if(null == child._parent){
				child._parent = this;
			}else if(this == child._parent){
				var temp_index:Number = _visual_list.indexOf(child);
				_visual_list.splice(temp_index, 1);
			}else{
				child._parent.delChild(child);
				child._parent = this;
			}
			_visual_list.splice(index, 0, child);
		}
		
		public function delChild(child:AWVisualObject):void{
			var index:Number = _visual_list.indexOf(child);
			if(index < 0){
				throw new AWVisualException(AWVisualException.NOT_A_CHILD);
			}
			_visual_list.splice(index, 1)[0]._parent = null;
		}
		public function delChildAt(index:uint = 0):void{
			if(index >= _visual_list.length){
				throw new AWVisualException(AWVisualException.INDEX_OUTOF_RANGE);
			}
			_visual_list.splice(index, 1)[0]._parent = null;
		}
	}
}