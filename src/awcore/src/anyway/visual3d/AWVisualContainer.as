package anyway.visual3d {

	import anyway.core.ns_aw;

	use namespace ns_aw;

	public class AWVisualContainer extends AWVisualObject {
		ns_aw var _count:uint = 0;

		public function AWVisualContainer() {
			_pre = _nxt = this;
		}
		
		public function addChild(child:AWVisualObject):void{
			child.delSelf();
			
			child._parent = this;
			
			child._pre = _pre;
			child._nxt = this;
			
			_pre._nxt = child;
			_pre = child;
			
			++_count;
		}

		public function addChildAt(child:AWVisualObject, idx:uint = uint.MAX_VALUE):void {
			child.delSelf();
			
			var target:AWVisualObject;
			if(0 < _count && idx < _count){
				this.forward(function(member:AWVisualObject):Boolean{
					if(0 == idx--){
						target = member;
						return true;
					}
					return false;
				});
			}else{
				target = this;
			}
			
			child._parent = this;
			child._pre = target._pre;
			child._nxt = target;
			
			target._pre._nxt = child;
			target._pre = child;
			
			++_count;
		}
		
		public function delChild(child:AWVisualObject):void{
			SWITCH::debug{
				if(child._parent == null || child._parent != this){
					throw new Error("");
				}
			}
			child._pre._nxt = child._nxt;
			child._nxt._pre = child._pre;
			
			child._parent = null;
			child._pre = null;
			child._nxt = null;
			
			--_count;
		}

		public function delChildAt(idx:uint = uint.MAX_VALUE):AWVisualObject {
			var child:AWVisualObject = null;
			if(0 < _count){
				if(idx < _count){
					this.forward(function(member:AWVisualObject):Boolean{
						if(0 == idx--){
							child = member;
							return true;
						}
						return false;
					});
				}else{
					child = _pre;
				}
				
				child._pre._nxt = child._nxt;
				child._nxt._pre = child._pre;
				
				child._parent = null;
				child._pre = null;
				child._nxt = null;
			}
			
			return child;
		}
		
		public function swapChild(fst:AWVisualObject, snd:AWVisualObject):void{
			SWITCH::debug{
				if(fst == snd || fst._parent != this || snd._parent != this){
					throw new Error("");
				}
			}
				
			var fst_pre:AWVisualObject = fst._pre;
			var fst_nxt:AWVisualObject = fst._nxt;
			
			var snd_pre:AWVisualObject = snd._pre;
			var snd_nxt:AWVisualObject = snd._nxt;
			
			fst_pre._nxt = snd;
			snd._pre = fst_pre;
			if(fst_nxt == snd){
				snd._nxt = fst;
				fst._pre = snd;
			}else{
				snd._nxt = fst_nxt;
				fst_nxt._pre = snd;
				
				snd_pre._nxt = fst;
				fst._pre = snd_pre;
			}
			fst._nxt = snd_nxt;
			snd_nxt._pre = fst;
		}
		
		public function swapChildAt(fst:uint, snd:uint):void{
		}

		public function getChildAt(idx:uint = uint.MAX_VALUE):AWVisualObject {
			var child:AWVisualObject = null;
			if(0 < _count){
				if(idx < _count){
					this.forward(function(member:AWVisualObject):Boolean{
						if(0 == idx--){
							child = member;
							return true;
						}
						return false;
					});
				}else{
					child = _pre;
				}
			}
			return child;
		}
		
		public function get numChildren():uint {
			return _count;
		}
		
		public function foreach(handler:Function):void{
			var nxt:AWVisualObject = _nxt;
			while(nxt != this){
				handler(nxt);
				nxt = nxt._nxt;
			}
		}
		
		public function forward(handler:Function):void{
			var nxt:AWVisualObject = _nxt;
			while(nxt != this){
				if(handler(nxt)){
					return;
				}
				nxt = nxt._nxt;
			}
		}
	}
}
