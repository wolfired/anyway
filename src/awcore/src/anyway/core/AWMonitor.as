package anyway.core{
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import anyway.geometry.AWMatrix;
	import anyway.utils.AWMathUtil;
	
	use namespace ns_aw;

	public final class AWMonitor{
		
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		private var _monitor_width:Number;
		private var _monitor_height:Number;
		
		public function AWMonitor(){
		}
		
		public function setup(stage3D:Stage3D, monitor_width:Number, monitor_height:Number):AWMonitor{
			_stage3D = stage3D;
			_monitor_width = monitor_width;
			_monitor_height = monitor_height;
			
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
			
			_stage3D.requestContext3D();
			
			return this;
		}
		
		ns_aw function render():void{
			_context3D.clear(0.94, 0.94, 0.94);
			
			_context3D.present();
		}
		
		private function perspectiveMatrix():AWMatrix {
//			return AWMathUtil.makeProjectionMatrix(_camera._fovx_deg, _monitor_width / _monitor_height, _camera._near, _camera._far);
			return null;
		}
		
		private function screenMatrix():AWMatrix{
			return AWMathUtil.makeScreenMatrix(_monitor_width, _monitor_width, _monitor_height, _monitor_height, _monitor_width / _monitor_height);
		}
		
		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_monitor_width, _monitor_height, 8);
		}
		
		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}