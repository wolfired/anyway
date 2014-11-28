package anyway.core{
	import anyway.face.AWIRotatable;
	import anyway.face.controller.AWIRotateController;
	
	use namespace ns_aw;
	
	public class AWRotateController implements AWIRotateController{
		ns_aw var _targets:Vector.<AWIRotatable> = new Vector.<AWIRotatable>();
		
		public function AWRotateController(){
		}
		
		public function lock(target:AWIRotatable):void{
			_targets.push(target);
		}
		
		public function rotate(angle_deg:Number, x:Number, y:Number, z:Number):void{
		}
	}
}