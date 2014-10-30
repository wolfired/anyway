package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.AWCamera;
	import anyway.core.AWMonitor;
	import anyway.core.AWScene;
	import anyway.core.Anyway;
	import anyway.model.AWModelStruct;
	import anyway.model.obj.AWModelParser4Obj;
	import anyway.model.obj.AWModelStruct4Obj;
	import anyway.visual.AWQuad;
	
	import ocore.manager.asset.AssetBase;
	import ocore.manager.asset.AssetManager;
	import ocore.manager.asset.AssetRegister;
	import ocore.manager.asset.category.AssetIMG;
	import ocore.manager.log.LogManager;
	import ocore.util.Callback;

	[SWF(width = 400, height = 400, frameRate = "24")]
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
			
			
			Anyway.ins.setup(this.stage);
			
			
			var monitor:AWMonitor = new AWMonitor().setup(this.stage.stage3Ds[0], this.stage.stageWidth, this.stage.stageHeight);
			var camera:AWCamera = new AWCamera().setup();
			var scene:AWScene = new AWScene();

			var q:AWQuad = new AWQuad();
			q.z = 2;
			q.setSize(2, 2);
			q.ttt = ai.real_data;
			
			scene.addChild(q);
		}
	}
}
