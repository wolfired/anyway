package anyway.core {

	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import anyway.constant.AWMathConst;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	import anyway.utils.AWMathUtil;

	use namespace anyway_internal_geometry;

	public final class AWCamera {

		public function AWCamera(stage3D:Stage3D, film_width:Number, film_height:Number, fovy:Number = 90.0, zNear:Number = 1.0, zFar:Number = 1000.0) {
			_stage3D = stage3D;
			_film_width = film_width;
			_film_height = film_height;
			_fovy = fovy;
			_zNear = zNear;
			_zFar = zFar;

			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
		}

		private var _stage3D:Stage3D;
		private var _context3D:Context3D;

		private var _fovy:Number;
		private var _zNear:Number;
		private var _zFar:Number;
		private var _film_width:Number;
		private var _film_height:Number;

		private const _camera_place_at:AWVector = new AWVector();
		private const _camera_point_to:AWVector = new AWVector();

		public function setup(place_at:AWVector, point_to:AWVector):void {
			_camera_place_at.copyRawData(place_at._raw_data);
			_camera_point_to.copyRawData(point_to._raw_data);
		}

		public function action():void {
			_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
		}

		private function cameraMatrix():AWMatrix {
			return AWMathUtil.lookAtLH(_camera_place_at, _camera_point_to, new AWVector(0.0, 1.0, 0.0));
		}

		private function perspectiveMatrix():AWMatrix {
			return AWMathUtil.perspectiveFieldOfViewLH(_fovy * AWMathConst.DEG_2_RAD, _film_width / _film_height, _zNear, _zFar);
		}

		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_film_width, _film_height, 8);
		}

		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}
