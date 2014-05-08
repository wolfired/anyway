package anyway.core {

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
	import flash.utils.getTimer;
	
	import anyway.constant.AWCoordinateConst;
	import anyway.constant.AWMathConst;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.shader.TextureShader;
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
		}

		private var _stage3D:Stage3D;
		private var _context3D:Context3D;

		private var _monitor_width:Number;
		private var _monitor_height:Number;

		private var _camera:AWCamera;

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
			var zNear:Number = 0.01;
			var zFar:Number = 1000;
			var fovy:Number = 90 * AWMathConst.DEG_2_RAD;
			return AWMathUtil.perspectiveFieldOfViewLH(fovy, aspect, zNear, zFar);
		}

		private var counter:Number = 0;
		public function refresh():void {
			var shader:TextureShader = new TextureShader();
			shader.upload(_context3D);
			
			var o:AWSpaceObject = Anyway.sington.world.getChildAt();
			
			var vb:VertexBuffer3D = _context3D.createVertexBuffer(o._model.numVertices, o._model.data32_per_vertex);
			vb.uploadFromVector(o._model.vertexData, 0, o._model.numVertices);
			_context3D.setVertexBufferAt(0, vb, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context3D.setVertexBufferAt(1, vb, 3, Context3DVertexBufferFormat.FLOAT_2);
			
			var ib:IndexBuffer3D = _context3D.createIndexBuffer(o._model.numIndices);
			ib.uploadFromVector(o._model.indexData, 0, o._model.numIndices);
			
			var t:Texture = _context3D.createTexture(o._model.bitmapdata.width, o._model.bitmapdata.height, Context3DTextureFormat.BGRA, false);
			t.uploadFromBitmapData(o._model.bitmapdata);
			_context3D.setTextureAt(0, t);
			
			var modelM:AWMatrix = new AWMatrix();
			modelM.translate(0,0,1);
//			modelM.scale(2,2);
//			modelM.rotate(getTimer()/60, AWCoordinateConst.AXIS_Z);
			
			var worldM:AWMatrix = new AWMatrix();
			
//			_camera.matrix.rotate(0.5, AWCoordinateConst.AXIS_Z);
			
			var result:AWMatrix = new AWMatrix();
			result.multiply(modelM).multiply(worldM).multiply(_camera.matrix).multiply(this.matrix);
			
			_context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, result._raw_data);
			
			_context3D.setProgram(shader.program);
			
			_context3D.clear(1,1,1);
			_context3D.drawTriangles(ib);
			_context3D.present();
		}
		
//		// Prepare a shader for rendering
//		var shader:LightedRender = new LightedRender();
//		shader.upload(_context3D);
//		
//		var o:AWSpaceObject = Anyway.sington.world.getChildAt();
//		shader.setGeometry(o._model.vertexData, o._model.indexData, o._model.bitmapdata);
//		
//		// The projection defines a 3D perspective to be rendered
//		var projection:PerspectiveMatrix3D = new PerspectiveMatrix3D();
//		projection.perspectiveFieldOfViewRH(45, _monitor_width / _monitor_height, 1, 500);
//		
//		// The pivot will keep track of the model's current rotation
//		var pivot:Vector3D = new Vector3D();
//		
//		var dt:Number = getTimer() / 30.0;
//		
//		// Prepare a matrix which we'll use to apply transformations to the model
//		var modelMatrix:Matrix3D = new Matrix3D();
//		modelMatrix.identity();
//		modelMatrix.appendRotation(dt, Vector3D.X_AXIS, pivot);
//		modelMatrix.appendRotation(dt, Vector3D.Y_AXIS, pivot);
//		modelMatrix.appendRotation(45 * AWMathConst.DEG_2_RAD, Vector3D.Z_AXIS, pivot);
//		//			modelMatrix.appendTranslation(0, 0, -2);
//		
//		// The view matrix will contain the concatenation of all transformations
//		var viewMatrix:Matrix3D = new Matrix3D();
//		
//		// Prepare lighting
//		var lightColor:Vector3D = new Vector3D(0.95, 0.80, 0.55, 0.8); // R,G,B,strength
//		var ambient:Vector3D = new Vector3D(0.00, 0.05, 0.1);
//		var lightPos:Vector3D = new Vector3D(1.0, 1.0, -4.0, 0.2);
//		
//		_context3D.clear(0.05, 0.12, 0.18); // Dark grey background
//		
//		// Rotate the model matrix
//		modelMatrix.appendRotation(0.4, Vector3D.X_AXIS, pivot);
//		modelMatrix.appendRotation(0.3, Vector3D.Y_AXIS, pivot);
//		
//		// Calculate the view matrix, and run the shader program!
//		viewMatrix.identity();
//		viewMatrix.append(modelMatrix);
//		viewMatrix.appendTranslation(0, 0, -2);
//		viewMatrix.append(projection);
//		viewMatrix.transpose();
//		
//		shader.render(viewMatrix, lightPos, lightColor, ambient);
//		
//		// Show the newly rendered frame on screen
//		_context3D.present();

		private function onContext3DCreate(event:Event):void {
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(_monitor_width, _monitor_height, 2);
		}

		private function onError(event:ErrorEvent):void {
			trace("error");
		}
	}
}
