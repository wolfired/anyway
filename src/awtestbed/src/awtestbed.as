package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.AWCamera;
	import anyway.core.AWMonitor;
	import anyway.core.AWScene;
	import anyway.core.Anyway;
	import anyway.display.AWDisplayObject;
	import anyway.model.AWModelStruct;
	import anyway.model.obj.AWModelParser4Obj;
	import anyway.model.obj.AWModelStruct4Obj;
	
	import ocore.manager.asset.AssetBase;
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
			AssetRegister.ins.registerAsset("png", AssetIMG, "res/");
			AssetManager.ins.setup(false);
			
			var urls:Vector.<String> = new Vector.<String>();
			urls.push(AssetRegister.ins.getAssetUrl("box", "png"));
			urls.push(AssetRegister.ins.getAssetUrl("hero", "png"));
			urls.push(AssetRegister.ins.getAssetUrl("box", "def", "res/"));
			
			AssetManager.ins.fetchPackage(urls, false, 1, Callback.create(wait4asset), true);
		}
		
		private function wait4asset():void{
			LogManager.ins.print();
			
			var ab:AssetBase = AssetManager.ins.gainAsset(AssetRegister.ins.getAssetUrl("box", "def", "res/"), true);
			var obj:AWModelStruct = new AWModelParser4Obj().parser(ab.raw_data) as AWModelStruct4Obj;
			
			var ai:AssetIMG = AssetManager.ins.gainAsset(AssetRegister.ins.getAssetUrl("box", "png"), true) as AssetIMG;
			
			Anyway.ready(this.stage, this.stage.stageWidth, this.stage.stageHeight).go();
			var camera:AWCamera = Anyway.sington.getCamera(0);
			var monitor:AWMonitor = Anyway.sington.getMonitor(0);
			Anyway.sington.connect(0, 0);
			var scene:AWScene = new AWScene();
			camera.scene = scene;
			
			var o:AWDisplayObject = new AWDisplayObject();
			scene.addChildAt(o);
		}
	}
}
