package {

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.Anyway;
	import anyway.model.AWModelStruct;
	import anyway.space.AWSpaceObject;

	[SWF(width = CONST::width, height = CONST::height, frameRate = "24")]

	public class AWMain extends Sprite {

		public function AWMain() {
			if(null != this.stage) {
				this.startup();
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}

		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			this.startup();
		}

		private function onRemovedFromStage(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function startup():void {
			Anyway.ready(this.stage, CONST::width, CONST::height).go();
			
			var model_struct3d:AWModelStruct = new AWModelStruct();
			model_struct3d.data32_per_vertex = 8;
			model_struct3d.bitmapdata = (new ResClz.textureClass() as Bitmap).bitmapData;
			model_struct3d.vertexData = Vector.<Number>([
													  0.5, 0.5, -0.5, 0, 0, -1, 1, 0, // 	0Front
													  -0.5, 0.5, -0.5, 0, 0, -1, 0, 0, // 
													  -0.5, -0.5, -0.5, 0, 0, -1, 0, 1, // 
													  0.5, -0.5, -0.5, 0, 0, -1, 1, 1, // 

													  0.5, -0.5, -0.5, 0, -1, 0, 1, 0, //  4Bottom
													  -0.5, -0.5, -0.5, 0, -1, 0, 0, 0, // 
													  -0.5, -0.5, 0.5, 0, -1, 0, 0, 1, // 
													  0.5, -0.5, 0.5, 0, -1, 0, 1, 1, // 

													  -0.5, 0.5, 0.5, 0, 0, 1, 1, 0, // 	8Back
													  0.5, 0.5, 0.5, 0, 0, 1, 0, 0, // 
													  0.5, -0.5, 0.5, 0, 0, 1, 0, 1, // 
													  -0.5, -0.5, 0.5, 0, 0, 1, 1, 1, // 

													  -0.5, 0.5, 0.5, 0, 1, 0, 1, 0, // 	Top
													  0.5, 0.5, 0.5, 0, 1, 0, 0, 0, // 
													  0.5, 0.5, -0.5, 0, 1, 0, 0, 1, // 
													  -0.5, 0.5, -0.5, 0, 1, 0, 1, 1, // 

													  -0.5, 0.5, -0.5, -1, 0, 0, 1, 0, // 	Left
													  -0.5, 0.5, 0.5, -1, 0, 0, 0, 0, // 
													  -0.5, -0.5, 0.5, -1, 0, 0, 0, 1, // 
													  -0.5, -0.5, -0.5, -1, 0, 0, 1, 1, // 

													  0.5, 0.5, 0.5, 1, 0, 0, 1, 0, // 	Right
													  0.5, 0.5, -0.5, 1, 0, 0, 0, 0, // 
													  0.5, -0.5, -0.5, 1, 0, 0, 0, 1, // 
													  0.5, -0.5, 0.5, 1, 0, 0, 1, 1 // 	  	
													  ]);
			model_struct3d.indexData = Vector.<uint>([
												   0, 1, 2, 0, 2, 3, // Front face
												   4, 5, 6, 4, 6, 7, // Bottom face
												   8, 9, 10, 8, 10, 11, // Back face
												   14, 13, 12, 15, 14, 12, // Top face
												   16, 17, 18, 16, 18, 19, // Left face
												   20, 21, 22, 20, 22, 23 // Right face
												   ]);
			
			
			var model_struct2d:AWModelStruct = new AWModelStruct();
			model_struct2d.data32_per_vertex = 5;
			model_struct2d.bitmapdata = (new ResClz.textureClass() as Bitmap).bitmapData;
			model_struct2d.vertexData = Vector.<Number>([
				1,1,1,1,0,//Front0
				1,-1,1,1,1,//
				-1,-1,1,0,1,//
				-1,1,1,0,0//
//				1,1,1,1,0,//Back4
//				1,-1,1,1,1,//
//				-1,-1,1,0,1,//
//				-1,1,1,0,0,//
//				-1,1,1,1,0,//left8
//				-1,-1,1,1,1,//
//				-1,-1,-1,0,1,//
//				-1,1,-1,0,0,//
//				1,1,1,1,0,//right12
//				1,-1,1,1,1,//
//				1,-1,-1,0,1,//
//				1,1,-1,0,0//
			]);
			model_struct2d.indexData = Vector.<uint>([
				0,2,1,
				0,3,2
			]);
			
			var o:AWSpaceObject = new AWSpaceObject();
			o._model = model_struct2d;
			
			Anyway.sington.world.addChildAt(o);
		}
	}
}
