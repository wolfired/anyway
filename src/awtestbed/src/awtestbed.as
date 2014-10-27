package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.AWCamera;
	import anyway.core.AWMonitor;
	import anyway.core.AWScene;
	import anyway.core.Anyway;
	import anyway.display.AWDisplayObject;
	import anyway.model.AWModelStruct;
	
	import ocore.manager.asset.AssetManager;
	import ocore.manager.asset.AssetRegister;
	import ocore.manager.asset.category.AssetIMG;
	import ocore.manager.log.LogManager;
	import ocore.util.Callback;

	[SWF(width = 500, height = 500, frameRate = "24")]
	public class awtestbed extends Sprite {

		public function awtestbed() {
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
			AssetRegister.ins.registerAsset("png", "res/", AssetIMG);
			AssetManager.ins.setup(false);
			
			var urls:Vector.<String> = new Vector.<String>();
			urls.push(AssetRegister.ins.getAssetUrl("box", "png"));
			urls.push(AssetRegister.ins.getAssetUrl("hero", "png"));
			
			AssetManager.ins.fetchPackage(urls, false, 1, Callback.create(wait4asset), true);
		}
		
		private function wait4asset():void{
			LogManager.print();
			
			var pa:AssetIMG = AssetManager.ins.gainAsset(AssetRegister.ins.getAssetUrl("box", "png"), true) as AssetIMG;
			
			Anyway.ready(this.stage, this.stage.stageWidth, this.stage.stageHeight).go();
			var camera:AWCamera = Anyway.sington.getCamera(0);
			var monitor:AWMonitor = Anyway.sington.getMonitor(0);
			Anyway.sington.connect(0, 0);
			var scene:AWScene = new AWScene();
			camera.scene = scene;
			
			var model_struct3d:AWModelStruct = new AWModelStruct();
			model_struct3d.data32_per_vertex = 8;
			model_struct3d.bitmapdata =  pa.real_data;
			model_struct3d.vertexData = Vector.<Number>([
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
			model_struct3d.indexData = Vector.<uint>([
				0, 1, 2,		0, 2, 3,		// Front face
				4, 5, 6,		4, 6, 7,        // Bottom face
				8, 9, 10,		8, 10, 11,      // Back face
				14, 13, 12,		15, 14, 12,     // Top face
				16, 17, 18,		16, 18, 19,     // Left face
				20, 21, 22,		20, 22, 23      // Right face
			]);
			
			var o:AWDisplayObject = new AWDisplayObject();
			scene.addChildAt(o);
		}
	}
}
