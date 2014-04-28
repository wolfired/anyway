package anyway.geometry {

	import anyway.core.ns.anyway_internal_geometry;
	import anyway.utils.format;
	
	use namespace anyway_internal_geometry;

	/**
	 * <p>向量</p>
	 * <p>D3D使用行向量
	 * <img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{v} = \begin{pmatrix}v_{x} %26 v_{y} %26 v_{z} %26 0\end{pmatrix}"/>
	 * ，因此其转换矩阵为列矩阵
	 * <img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=M=\begin{bmatrix}m_{11} %26 m_{21} %26 m_{31} %26 m_{41}\\ m_{12} %26 m_{22} %26 m_{32} %26 m_{42}\\ m_{13} %26 m_{23} %26 m_{33} %26 m_{43}\\ m_{14} %26 m_{24} %26 m_{34} %26 m_{44}\end{bmatrix}"/>
	 * ，<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl={\vec{v}}' = \vec{v} \times M"/></p>
	 * <p>OGL使用列向量
	 * <img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{v} = \begin{pmatrix}v_{x} \\ v_{y} \\ v_{z} \\ 0\end{pmatrix}"/>
	 * ，因此其转换矩阵为行矩阵
	 * <img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=M=\begin{bmatrix}m_{11} %26 m_{12} %26 m_{13} %26 m_{14}\\ m_{21} %26 m_{22} %26 m_{23} %26 m_{24}\\ m_{31} %26 m_{32} %26 m_{33} %26 m_{34}\\ m_{41} %26 m_{42} %26 m_{43} %26 m_{44}\end{bmatrix}"/>
	 * ，<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl={\vec{v}}' = M \times \vec{v}"/></p>
	 * <p>性质</p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} %2B \vec{b} = \vec{b} %2B \vec{a}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} %2B \left ( \vec{b} %2B \vec{c} \right ) = \left ( \vec{a} %2B \vec{b} \right ) %2B \vec{c}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} %2B \vec{0} = \vec{0} %2B \vec{a} = \vec{a}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} %2B \left ( -\vec{a} \right ) = 0"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=k \times \left ( l \times \vec{a} \right ) = \left ( k \times l \right ) \times \vec{a} = \vec{a} \times \left ( k \times l \right )"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=k \times \left ( \vec{a} %2B \vec{b} \right ) = k \times \vec{a} %2B k \times \vec{b}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\left ( k %2B l \right ) \times \vec{a} = k \times \vec{a} %2B l \times \vec{a}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=1 \times \vec{a} = \vec{a}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} \cdot \vec{b} = \vec{b} \cdot \vec{a}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} \cdot \left ( \vec{b} %2B \vec{c} \right ) = \vec{a} \cdot \vec{b} %2B \vec{a} \cdot \vec{c}"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=k \times \left ( \vec{a} \cdot \vec{b} \right ) = \left ( k \time \vec{a} \right ) \cdot \vec{b} = \vec{a} \cdot \left ( k \time \vec{b} \right )"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{0} \cdot \vec{a} = 0"/></p>
	 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} \cdot \vec{a} = \left | \vec{a} \right |^{2}"/></p>
	 */	
	public class AWVector {
		private static const RAW_LENGTH:uint = 4;
		
		public function AWVector(x:Number = 0.0, y:Number = 0.0, z:Number = 0.0) {
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			_raw_data[3] = 0.0;
		}
		
		anyway_internal_geometry const _raw_data:Vector.<Number> = new Vector.<Number>(RAW_LENGTH, true);

		/**
		 * 向量长度（模）
		 * @return 
		 */		
		public function get length():Number {
			var result:Number = 0.0;

			result += Math.pow(_raw_data[0], 2);
			result += Math.pow(_raw_data[1], 2);
			result += Math.pow(_raw_data[2], 2);

			return Math.sqrt(result);
		}

		/**
		 * 归一化
		 */		
		public function normalize():void {
			var len:Number = this.length;
			
			_raw_data[0] /= len;
			_raw_data[1] /= len;
			_raw_data[2] /= len;
			
			return;
		}

		/**
		 * 向量加法
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} = \left ( a_{x}, a_{y}, a_{z} \right )"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{b} = \left ( b_{x}, b_{y}, b_{z} \right )"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} %2B \vec{b} = \left ( a_{x} %2B b_{x}, a_{y} %2B  b_{y}, a_{z} %2B b_{z} \right )"/></p>
		 * @param target
		 * @return 
		 */
		public function addition(left:AWVector):void {
			_raw_data[0] += left._raw_data[0];
			_raw_data[1] += left._raw_data[1];
			_raw_data[2] += left._raw_data[2];
			return;
		}
		/**
		 * 向量减法
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} = \left ( a_{x}, a_{y}, a_{z} \right )"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{b} = \left ( b_{x}, b_{y}, b_{z} \right )"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} - \vec{b} = \left ( a_{x} - b_{x}, a_{y} -  b_{y}, a_{z} - b_{z} \right )"/></p>
		 * @param target
		 * @return 
		 */
		public function subtraction(left:AWVector):void {
			_raw_data[0] -= left._raw_data[0];
			_raw_data[1] -= left._raw_data[1];
			_raw_data[2] -= left._raw_data[2];
			return;
		}

		/**
		 * 向量点积（数量积，内积）
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} \cdot \vec{b} = \left | \vec{a} \right | \cdot \left | \vec{b} \right | \cdot \cos \theta"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\theta"/>为两个向量的夹角</p>
		 * @param target
		 * @return 
		 */		
		public function dotProduct(left:AWVector):Number {
			var result:Number = 0.0;

			result += _raw_data[0] * left._raw_data[0];
			result += _raw_data[1] * left._raw_data[1];
			result += _raw_data[2] * left._raw_data[2];
			
			return result;
		}

		/**
		 * 向量叉积（向量积）
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a} \times \vec{b} = \left | \vec{a} \right | \times \left | \vec{b} \right | \times \sin \theta \times \vec{v} = \vec{c}"/></p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\theta"/>为两个向量的不大于180度夹角</p>
		 * <p><img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{v}"/>是垂直于两个向量所决定的平面的单位向量，其方向取决于：</p>
		 * <p>右手坐标系中，右手四指并拢从<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a}"/>经<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\theta"/>弯向<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{b}"/>时拇指伸直所指方向</p>
		 * <p>左手坐标系中，左手四指并拢从<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{a}"/>经<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\theta"/>弯向<img src="http://chart.apis.google.com/chart?cht=tx&#38;chl=\vec{b}"/>时拇指伸直所指方向</p>
		 * @param target
		 */		
		public function crossProduct(left:AWVector):void {
			var x:Number = _raw_data[1] * left._raw_data[2] - left._raw_data[1] * _raw_data[2];
			var y:Number = -_raw_data[0] * left._raw_data[2] + left._raw_data[0] * _raw_data[2];
			var z:Number =  _raw_data[0] * left._raw_data[1] - left._raw_data[0] * _raw_data[1];
			_raw_data[0] = x;
			_raw_data[1] = y;
			_raw_data[2] = z;
			return;
		}
		
		/**
		 * 向量是否一致
		 * @param target
		 * @return 
		 */		
		public function isCongruent(target:AWVector):Boolean{
			if(this == target){
				return true;
			}
			if(_raw_data[0] != target._raw_data[0]){
				return false;
			}
			if(_raw_data[1] != target._raw_data[1]){
				return false;
			}
			if(_raw_data[2] != target._raw_data[2]){
				return false;
			}
			return true;
		}

		public function toString():String {
			return "<" + format(_raw_data[0]) + ", " + format(_raw_data[1]) + ", " + format(_raw_data[2]) + ">";
		}
	}
}
