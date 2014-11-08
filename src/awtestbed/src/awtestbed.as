package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.Anyway;
	import anyway.model.AWModelStruct;
	import anyway.model.obj.AWModelParser4Obj;
	import anyway.model.obj.AWModelStruct4Obj;
	import anyway.visual3d.AWQuad;
	
	import ocore.manager.asset.AssetBase;
	import ocore.manager.asset.AssetManager;
	import ocore.manager.asset.AssetRegister;
	import ocore.manager.asset.category.AssetIMG;
	import ocore.manager.log.LogManager;
	import ocore.util.Callback;

	[SWF(width = 600, height = 600, frameRate = 60)]
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
			
			Anyway.ins.monitor.setup(600, 600);
			
			Anyway.ins.camera.place_at(0, 0, -4);
			Anyway.ins.camera.point_to(0, 0, 0);
//			Anyway.ins.camera.rotate(45, 0, 1, 0);

			var q1:AWQuad = new AWQuad();
			q1.x = -1;
			q1._vertexData = obj.vertexData;
			q1._indexData = obj.indexData;
			q1.ttt = ai.real_data;
			Anyway.ins.scene.addChild(q1);
			
			var q2:AWQuad = new AWQuad();
			q2.x = 1;
			q2._vertexData = obj.vertexData;
			q2._indexData = obj.indexData;
			q2.ttt = ai.real_data;
			Anyway.ins.scene.addChild(q2);
		}
	}
}
