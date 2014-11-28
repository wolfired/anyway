package anyway.core{
	import anyway.face.AWITranslateable;
	import anyway.face.controller.AWITranslateController;
	
	use namespace ns_aw;
	
	public class AWTranslateController implements AWITranslateController{
		ns_aw var _targets:Vector.<AWITranslateable> = new Vector.<AWITranslateable>();
		
		public function AWTranslateController(){
		}
		
		public function lock(target:AWITranslateable):void{
			_targets.push(target);
		}
		
		public function translate(tx:Number, ty:Number, tz:Number):void{
			for each (var target:AWITranslateable in _targets) {
				target.translate(tx, ty, tz);
			}
		}
	}
}