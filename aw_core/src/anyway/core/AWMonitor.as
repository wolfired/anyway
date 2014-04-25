package anyway.core {

	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import anyway.constant.AWMathConst;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWPoint;
	import anyway.geometry.AWVector;
	import anyway.manager.asset.AWAsset;
	import anyway.manager.asset.AWAssetManager;
	import anyway.shader.TestShader;
	import anyway.utils.string2json;
	
	use namespace anyway_internal;

	public class AWMonitor {
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		private var _width:Number;
		private var _height:Number;
		
		public function AWMonitor(width:Number = 500.0, height:Number = 500.0) {
			_width = width;
			_height = height;
		}
		
		public function poweron(stage3d:Stage3D):void{
			_stage3D = stage3d;
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
			_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
		}
		
		public function poweroff():void{
			
		}
		
		private function onContext3DCreate(event:Event):void {
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_width, _height, 2);
			
			_asset = AWAssetManager.instance.fetch("./res/box.def");
		}
		
		private function onError(event:ErrorEvent):void{
			trace("error");
		}
		
		private var _asset:AWAsset;
		public function refresh():void {
			if(_asset.isNull) {
				return;
			}
			
			var def:Object = string2json(_asset.data as String) as Object;
			
			var vb_raw:Vector.<Number> = Vector.<Number>(def.vertex_raw);
			var vb_wide:int = def.coord_wide + def.color_wide;
			var vb:VertexBuffer3D = _context3D.createVertexBuffer(vb_raw.length / vb_wide, vb_wide);
			vb.uploadFromVector(vb_raw, 0, vb_raw.length / vb_wide);
			_context3D.setVertexBufferAt(0, vb, 0, Context3DVertexBufferFormat.FLOAT_3); //va0
			_context3D.setVertexBufferAt(1, vb, 3, Context3DVertexBufferFormat.FLOAT_3); //va1
			
			var ib_raw:Vector.<uint> = Vector.<uint>(def.index_raw);
			var ib:IndexBuffer3D = _context3D.createIndexBuffer(ib_raw.length);
			ib.uploadFromVector(ib_raw, 0, ib_raw.length);
			
			var aspect:Number = 500 / 500;
			var zNear:Number = 0.01;
			var zFar:Number = 1000;
			var fov:Number = 45 * AWMathConst.DEG_2_RAD;
			var magicNumber:Number = Math.tan(fov * 0.5);
			
			var prjC:AWCamera = new AWCamera();
			prjC.perspectiveFieldOfViewLH(fov, aspect, zNear, zFar);
			
			var lokC:AWCamera = new AWCamera();
			lokC.lookAtLH(new AWPoint(0, 0, (500 * 0.5) / magicNumber), new AWPoint(0,0,0), new AWVector(0,1,0));
			
			var m:AWMatrix = new AWMatrix();
//			m.rotate(getTimer()/30, AWCoordinateConst.AXIS_X);
//			m.rotate(getTimer()/30, AWCoordinateConst.AXIS_Y);
//			m.rotate(getTimer()/30, AWCoordinateConst.AXIS_Z);
			m.translate(0, 0, 2);
			
			var r:AWMatrix = prjC._cm.multiply(m);
//			r = prjC._cm.multiply(lokC._cm);
//			r.transpose();
			_context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, r._raw_data);
			
			var ts:TestShader = new TestShader();
			ts.upload(_context3D);
			
			_context3D.setProgram(ts.program);
			
			_context3D.clear(1.0, 1.0, 1.0);
			_context3D.drawTriangles(ib);
			_context3D.present();
		}
	}
}
