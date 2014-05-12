package anyway.core {

	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import anyway.constant.AWMathConst;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.geometry.AWVector;
	import anyway.shader.LightedRender;
	import anyway.space.AWSpaceObject;
	import anyway.utils.AWMathUtil;

	use namespace anyway_internal_geometry;

	public final class AWMonitor {

		public function AWMonitor(stage3d:Stage3D, monitor_width:Number, monitor_height:Number) {
			_stage3D = stage3d;
			_monitor_width = monitor_width;
			_monitor_height = monitor_height;

			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage3D.addEventListener(ErrorEvent.ERROR, onError);
			
			this.init();
		}

		private var _stage3D:Stage3D;
		private var _context3D:Context3D;

		private var _monitor_width:Number;
		private var _monitor_height:Number;

		private var _camera:AWCamera;

		private var counter:Number =2.1;

		public function poweron():void {
			_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
		}

		public function poweroff():void {
			_context3D.dispose();
		}

		public function connect(camera:AWCamera):void {
			_camera = camera;
		}

		public function get matrix():AWMatrix {
			var aspect:Number = _monitor_width / _monitor_height;
			var zNear:Number = 1;
			var zFar:Number = 500;
			var fovy:Number = 90 * AWMathConst.DEG_2_RAD;
			return AWMathUtil.perspectiveFieldOfViewLH(fovy, aspect, zNear, zFar);
		}
		
		private var modelMatrix:Matrix3D;
		private var viewMatrix:Matrix3D;
		private var projection:PerspectiveMatrix3D;
		private var lightPos:AWVector;
		private var lightColor:AWVector;
		private var ambient:AWVector;
		private function init():void{
			modelMatrix = new Matrix3D();
			modelMatrix.identity();
			modelMatrix.appendRotation(45, Vector3D.X_AXIS);
			modelMatrix.appendRotation(45, Vector3D.Y_AXIS);
			modelMatrix.appendRotation(45, Vector3D.Z_AXIS);
			
			viewMatrix = new Matrix3D();
			viewMatrix.identity();
			
			projection = new PerspectiveMatrix3D();
			projection.perspectiveFieldOfViewRH(45, 500 / 500, 1, 500);
			
			lightPos = new AWVector(1.0, 1.0, -4.0, 0.2);
			lightColor = new AWVector(0.95, 0.80, 0.55, 0.8);  // R,G,B,strength
			ambient = new AWVector(0.00, 0.05, 0.1);
		}
		
		public function refresh():void {
			var shader:LightedRender = new LightedRender();
			shader.upload(_context3D);

			var o:AWSpaceObject = Anyway.sington.world.getChildAt();

			var vb:VertexBuffer3D = _context3D.createVertexBuffer(o._model.numVertices, o._model.data32_per_vertex);
			vb.uploadFromVector(o._model.vertexData, 0, o._model.numVertices);
			_context3D.setVertexBufferAt(0, vb, 0, Context3DVertexBufferFormat.FLOAT_3); // x,y,z
			_context3D.setVertexBufferAt(1, vb, 3, Context3DVertexBufferFormat.FLOAT_3); // nx,ny,nz
			_context3D.setVertexBufferAt(2, vb, 6, Context3DVertexBufferFormat.FLOAT_2); // u,v

			var ib:IndexBuffer3D = _context3D.createIndexBuffer(o._model.numIndices);
			ib.uploadFromVector(o._model.indexData, 0, o._model.numIndices);

			var t:Texture = _context3D.createTexture(o._model.bitmapdata.width, o._model.bitmapdata.height, Context3DTextureFormat.BGRA, false);
			t.uploadFromBitmapData(o._model.bitmapdata);
			_context3D.setTextureAt(0, t);
			
			// Rotate the model matrix
			modelMatrix.appendRotation(0.4, Vector3D.X_AXIS);
			modelMatrix.appendRotation(0.3, Vector3D.Y_AXIS);
			
			// Calculate the view matrix, and run the shader program!
			viewMatrix.identity();
			viewMatrix.append(modelMatrix);
			viewMatrix.appendTranslation(0, 0, -2);
			viewMatrix.append(projection);
			viewMatrix.transpose();
			
			// Pass viewMatrix into constant registers
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, viewMatrix);
			
			// Pass a vector for the (world space) location of the light
			_context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, lightPos._raw_data, 1);
			// Pass light parameters
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, lightColor._raw_data, 1);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, ambient._raw_data, 1);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, Vector.<Number>([0, 1/3, 1, 0.5]), 1);
			
			// Tell the 3D context that this is the current shader program to be rendered
			_context3D.setProgram(shader.program);
			
			// Clear away the old frame render
			_context3D.clear(0.05, 0.12, 0.18);  // Dark grey background
			// Render the shader!
			_context3D.drawTriangles(ib);
			// Show the newly rendered frame on screen
			_context3D.present();
		}

		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_monitor_width, _monitor_height, 2);
		}
		
		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}
