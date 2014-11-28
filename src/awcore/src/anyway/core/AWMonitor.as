package anyway.core{
	import anyway.geometry.AWMatrix;
	import anyway.utils.AWMathUtil;
	
	
	use namespace ns_aw;

	public final class AWMonitor{
		ns_aw var _monitor_x:Number;
		ns_aw var _monitor_y:Number;
		ns_aw var _monitor_width:Number;
		ns_aw var _monitor_height:Number;
		
		ns_aw var _perspectiveMatrix:AWMatrix = new AWMatrix();
		ns_aw var _perspectiveMatrixDirty:Boolean = true;
		ns_aw var _screenMatrix:AWMatrix = new AWMatrix();
		ns_aw var _screenMatrixDirty:Boolean = true;
		
		public function AWMonitor(){
		}
		
		public function setup(monitor_width:Number, monitor_height:Number, monitor_x:Number = 0, monitor_y:Number = 0):AWMonitor{
			_monitor_width = monitor_width;
			_monitor_height = monitor_height;
			_monitor_x = monitor_x;
			_monitor_y = monitor_y;
			
			return this;
		}
		
		public function getPerspectiveMatrix(camera:AWCamera):AWMatrix {
			if(_perspectiveMatrixDirty){
				_perspectiveMatrixDirty = false;
				AWMathUtil.makeProjectionMatrix(camera._fovx_deg, _monitor_width / _monitor_height, camera._near, camera._far).copyToMatrix(_perspectiveMatrix);
			}
			return _perspectiveMatrix;
		}
		
		public function getScreenMatrix():AWMatrix{
			if(_screenMatrixDirty){
				_screenMatrixDirty = false;
				AWMathUtil.makeScreenMatrix(_monitor_width, _monitor_width, _monitor_height, _monitor_height, _monitor_width / _monitor_height).copyToMatrix(_screenMatrix);
			}
			return _screenMatrix;
		}
	}
}
