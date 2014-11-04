package anyway.core{
	import anyway.geometry.AWMatrix;
	import anyway.utils.AWMathUtil;
	
	
	use namespace ns_aw;

	public final class AWMonitor{
		private static var IDX:uint = 0;
		
		private var _monitor_x:Number;
		private var _monitor_y:Number;
		private var _monitor_width:Number;
		private var _monitor_height:Number;
		
		private const _idx:uint = ++IDX;
		private const _perspectiveMatrix:AWMatrix = new AWMatrix();
		private var _isPerspectiveMatrixDirty:Boolean = true;
		private const _screenMatrix:AWMatrix = new AWMatrix();
		private var _isScreenMatrix:Boolean = true;
		
		public function AWMonitor(){
		}
		
		public function setup(monitor_x:Number, monitor_y:Number, monitor_width:Number, monitor_height:Number):AWMonitor{
			_monitor_x = monitor_x;
			_monitor_y = monitor_y;
			_monitor_width = monitor_width;
			_monitor_height = monitor_height;
			
			return this;
		}
		
		public function get idx():uint{
			return _idx;
		}
		
		public function getPerspectiveMatrix(camera:AWCamera):AWMatrix {
			if(_isPerspectiveMatrixDirty){
				_isPerspectiveMatrixDirty = false;
				AWMathUtil.makeProjectionMatrix(camera._fovx_deg, _monitor_width / _monitor_height, camera._near, camera._far).copyToMatrix(_perspectiveMatrix);
			}
			return _perspectiveMatrix;
		}
		
		public function getScreenMatrix():AWMatrix{
			if(_isScreenMatrix){
				_isScreenMatrix = false;
				AWMathUtil.makeScreenMatrix(_monitor_width, _monitor_width, _monitor_height, _monitor_height, _monitor_width / _monitor_height).copyToMatrix(_screenMatrix);
			}
			return _screenMatrix;
		}
	}
}
