package anyway.core{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	
	use namespace ns_aw;

	public class AWController{
		public static const KEY_STATUS_UP:uint = 0;
		public static const KEY_STATUS_DOWN:uint = 1;
		
		private var _stage:Stage;
		
		private var _key_status_map:Array;
		
		public function AWController(){
			_key_status_map = [];
		}
		
		public function setup(stage:Stage):AWController{
			_stage = stage;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			return this;
		}
		
		public function isKeyDonw(key_code:uint):Boolean{
			return KEY_STATUS_DOWN == _key_status_map[key_code];
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			_key_status_map[event.keyCode] = KEY_STATUS_DOWN;
		}
		
		private function onKeyUp(event:KeyboardEvent):void {
			_key_status_map[event.keyCode] = KEY_STATUS_UP;
		}
		
		private var down_pos:AWVector;
		private function onMouseDown(event:MouseEvent):void {
			_stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			down_pos = new AWVector(event.stageX / 600 * 2 - 1, (600 - event.stageY) / 600 * 2 - 1);
		}
		
		private var up_pos:AWVector;
		private function onMouseUp(event:MouseEvent):void {
			_stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onDeactivate(event:Event):void{
			_stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		
		private function onMouseMove(event:MouseEvent):void {
			up_pos = new AWVector(event.stageX / 600 * 2 - 1, (600 - event.stageY) / 600 * 2 - 1);
			
			var d_vec:AWVector = up_pos.copy.subtraction(down_pos);
			d_vec.normalize();
			
			var d_mat:AWMatrix = new AWMatrix();
			d_mat.copyRowFrom(0, d_vec._raw_data);
			var c:AWMatrix = Anyway.ins.camera.getCameraMatrix().copy.transpose();
			d_mat.multiply(c);
			d_mat.copyRowTo(0, d_vec._raw_data);
			
			var n_vec:AWVector = Anyway.ins.camera._camera_point_to.copy.subtraction(Anyway.ins.camera._camera_place_at);
			n_vec.normalize();
			
			n_vec.crossProduct(d_vec);
			
			Anyway.ins.camera.rotate(1, n_vec._raw_data[0], n_vec._raw_data[1], n_vec._raw_data[2]);
		}
	}
}