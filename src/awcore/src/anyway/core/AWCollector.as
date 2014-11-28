package anyway.core{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import anyway.face.AWIDispose;
	import anyway.geometry.AWVector;
	
	use namespace ns_aw;

	public class AWCollector {
		public static const KEY_STATUS_UP:uint = 0;
		public static const KEY_STATUS_DOWN:uint = 1;
		
		private var _stage:Stage;
		
		private var _key_status_map:Array;
		
		public function AWCollector(){
			_key_status_map = [];
		}
		
		public function setup(stage:Stage):AWCollector{
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
			
			down_pos = Anyway.ins.camera.screen2projection(new AWVector(event.stageX, event.stageY));
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
			up_pos = Anyway.ins.camera.screen2projection(new AWVector(event.stageX, event.stageY));
			
			var d_vec:AWVector = up_pos.copy.subtraction(down_pos);
			var len:Number = d_vec.length;
			
			Anyway.ins.camera.projection2camera(d_vec);
			d_vec.normalize();
			
			var n_vec:AWVector = Anyway.ins.camera._camera_point_to.copy.subtraction(Anyway.ins.camera._camera_place_at);
			n_vec.normalize();
			
			n_vec.crossProduct(d_vec);
			
			Anyway.ins.camera.rotate(len * 32, n_vec._raw_data[0], n_vec._raw_data[1], n_vec._raw_data[2]);
			
			down_pos = up_pos;
		}
	}
}