package anyway.core {

	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage3D;
	import flash.display.TriangleCulling;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import anyway.constant.AWMathConst;
	import anyway.core.ns.anyway_internal_geometry;
	import anyway.geometry.AWMatrix;
	import anyway.shader.LightedRender;
	import anyway.utils.AWMathUtil;
	
	use namespace anyway_internal_geometry;

	public final class AWMonitor {
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		
		private var _width:Number;
		private var _height:Number;
		
		public var _camera:AWCamera;
		
		public function AWMonitor(width:Number, height:Number) {
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
			_context3D.setCulling(Context3DTriangleFace.BACK);
		}
		
		private function onError(event:ErrorEvent):void{
			trace("error");
		}
		
		public function get matrix():AWMatrix{
			var aspect:Number = _width / _height;
			var zNear:Number = 0.01;
			var zFar:Number = 1000;
			var fov:Number = 45 * AWMathConst.DEG_2_RAD;
			return AWMathUtil.perspectiveFieldOfViewLH(fov, aspect, zNear, zFar);
		}
		
		
		private var _texture:BitmapData;
		public function refresh():void {
			if(null == _texture){
				var clz:Class = getDefinitionByName("ResClz") as Class;
				_texture = ((new clz["textureClass"]()) as Bitmap).bitmapData;
			}

			var vertexData:Vector.<Number> = Vector.<Number>([
				0.5,  0.5, -0.5,	0,0,-1,		1,0,	// 	Front
				-0.5,  0.5, -0.5,	0,0,-1,		0,0,	// 
				-0.5, -0.5, -0.5,	0,0,-1,		0,1,	// 
				0.5, -0.5, -0.5,	0,0,-1,		1,1,	// 
				
				0.5, -0.5, -0.5,	0,-1,0,		1,0,	//  Bottom
				-0.5, -0.5, -0.5,	0,-1,0,		0,0,	// 
				-0.5, -0.5,  0.5,	0,-1,0,		0,1,	// 
				0.5, -0.5,  0.5,	0,-1,0,		1,1,	// 
				
				-0.5,  0.5,  0.5,	0,0,1, 		1,0,	// 	Back
				0.5,  0.5,  0.5,	0,0,1,		0,0,	// 
				0.5, -0.5,  0.5,	0,0,1,		0,1,	// 
				-0.5, -0.5,  0.5,	0,0,1,		1,1,	// 
				
				-0.5,  0.5,  0.5,	0,1,0, 		1,0,	// 	Top
				0.5,  0.5,  0.5,	0,1,0,		0,0,	// 
				0.5,  0.5, -0.5,	0,1,0,		0,1,	// 
				-0.5,  0.5, -0.5,	0,1,0,		1,1,	// 
				
				-0.5,  0.5, -0.5,	-1,0,0,		1,0,	// 	Left
				-0.5,  0.5,  0.5,	-1,0,0,		0,0,	// 
				-0.5, -0.5,  0.5,	-1,0,0,		0,1,	// 
				-0.5, -0.5, -0.5,	-1,0,0,		1,1,	// 
				
				0.5,  0.5,  0.5,	1,0,0, 		1,0,	// 	Right
				0.5,  0.5, -0.5,	1,0,0,		0,0,	// 
				0.5, -0.5, -0.5,	1,0,0,		0,1,	// 
				0.5, -0.5,  0.5,	1,0,0,		1,1		// 	  	
			]);
			
			
			var indexData:Vector.<uint> = Vector.<uint>([
				0, 1, 2,		0, 2, 3,		// Front face
				4, 5, 6,		4, 6, 7,        // Bottom face
				8, 9, 10,		8, 10, 11,      // Back face
				14, 13, 12,		15, 14, 12,     // Top face
				16, 17, 18,		16, 18, 19,     // Left face
				20, 21, 22,		20, 22, 23      // Right face
			]);
			
			// Prep the bitmap data to be used as a texture
			
			// Prepare a shader for rendering
			var shader:LightedRender = new LightedRender();
			shader.upload(_context3D);
			shader.setGeometry(vertexData, indexData, _texture);
			
			// The projection defines a 3D perspective to be rendered
			var projection:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			projection.perspectiveFieldOfViewRH(45, _width / _height, 1, 500);
			
			// The pivot will keep track of the model's current rotation
			var pivot:Vector3D = new Vector3D();
			
			var dt:Number = getTimer() / 30.0;
			
			// Prepare a matrix which we'll use to apply transformations to the model
			var modelMatrix:Matrix3D = new Matrix3D();
			modelMatrix.identity();
			modelMatrix.appendRotation(dt, Vector3D.X_AXIS, pivot);
			modelMatrix.appendRotation(dt, Vector3D.Y_AXIS, pivot);
			modelMatrix.appendRotation(45 * AWMathConst.DEG_2_RAD, Vector3D.Z_AXIS, pivot);
			
			// The view matrix will contain the concatenation of all transformations
			var viewMatrix:Matrix3D = new Matrix3D();
			
			// Prepare lighting
			var lightColor:Vector3D = new Vector3D(0.95, 0.80, 0.55, 0.8);  // R,G,B,strength
			var ambient:Vector3D = new Vector3D(0.00, 0.05, 0.1);
			var lightPos:Vector3D = new Vector3D(1.0, 1.0, -4.0, 0.2);
			
			_context3D.clear(0.05, 0.12, 0.18);  // Dark grey background
			
			// Rotate the model matrix
			modelMatrix.appendRotation(0.4, Vector3D.X_AXIS, pivot);
			modelMatrix.appendRotation(0.3, Vector3D.Y_AXIS, pivot);
			
			// Calculate the view matrix, and run the shader program!
			viewMatrix.identity();
			viewMatrix.append(modelMatrix);
			viewMatrix.appendTranslation(0, 0, -2);
			viewMatrix.append(projection);
			viewMatrix.transpose();
			
			shader.render(viewMatrix, lightPos, lightColor, ambient);
			
			// Show the newly rendered frame on screen
			_context3D.present();
		}
	}
}
