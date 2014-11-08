package anyway.geometry{
	import anyway.core.ns_aw;
	import anyway.utils.AWFormatUtil;
	
	use namespace ns_aw;
	
	/**
	 * 四元数
	 */
	public final class AWQuaternion{
		
		ns_aw const _raw_data:Vector.<Number> = new Vector.<Number>(4, true);

		public function AWQuaternion(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0, w:Number = 0.0){
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = w;
		}
		
		/**
		 * @return
		 */
		public function addition(right:AWQuaternion):AWQuaternion {
			_raw_data[0] += right._raw_data[0];
			_raw_data[1] += right._raw_data[1];
			_raw_data[2] += right._raw_data[2];
			_raw_data[3] += right._raw_data[3];
			
			return this;
		}
		
		public function subtraction(right:AWQuaternion):AWQuaternion {
			_raw_data[0] -= right._raw_data[0];
			_raw_data[1] -= right._raw_data[1];
			_raw_data[2] -= right._raw_data[2];
			_raw_data[3] -= right._raw_data[3];
			
			return this;
		}
		
		public function inverse():AWQuaternion{
			var N:Number = _raw_data[0] * _raw_data[0] + _raw_data[1] * _raw_data[1] + _raw_data[2] * _raw_data[2] + _raw_data[3] * _raw_data[3];
			var result:AWQuaternion = new AWQuaternion();
			result._raw_data[0] = -_raw_data[0] / N;
			result._raw_data[1] = -_raw_data[1] / N;
			result._raw_data[2] = -_raw_data[2] / N;
			result._raw_data[3] = _raw_data[3] / N;
			return result;
		}
		
		public function multiply(right:AWQuaternion):AWQuaternion{
			var x:Number = _raw_data[1] * right._raw_data[2] - right._raw_data[1] * _raw_data[2] + _raw_data[3] * right._raw_data[0] + right._raw_data[3] * _raw_data[0];
			var y:Number = -_raw_data[0] * right._raw_data[2] + right._raw_data[0] * _raw_data[2] + _raw_data[3] * right._raw_data[1] + right._raw_data[3] * _raw_data[1];
			var z:Number = _raw_data[0] * right._raw_data[1] - right._raw_data[0] * _raw_data[1] + _raw_data[3] * right._raw_data[2] + right._raw_data[3] * _raw_data[2];
			var w:Number = _raw_data[3] * right._raw_data[3] - _raw_data[0] * right._raw_data[0] - _raw_data[1] * right._raw_data[1] - _raw_data[2] * right._raw_data[2];
			
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = w;
			
			return this;
		}
		
		public function reset(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0, w:Number = 0.0):AWQuaternion{
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = w;
			
			return this;
		}
		
		public function copyToRawData(raw_data:Vector.<Number>):void {
			raw_data[0] = _raw_data[0];
			raw_data[1] = _raw_data[1];
			raw_data[2] = _raw_data[2];
			raw_data[3] = _raw_data[3];
		}
		
		public function get copy():AWQuaternion{
			var dst:AWQuaternion = new AWQuaternion();
			this.copyToRawData(dst._raw_data);
			return dst;
		}
		
		public function format():void {
			trace(AWFormatUtil.format_vector_in_raw_data(_raw_data));
		}
	}
}