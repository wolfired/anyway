package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.Anyway;
	import anyway.events.AWEventRouter;
	import anyway.manager.asset.AWAssetManager;
	import anyway.visual.AWVisualObject;
	import anyway.visual.AWVisualObjectContainer;

	[SWF(width="500", height="500", frameRate="24")]
	public class AWMain extends Sprite {
		public function AWMain() {
			super();

			if(this.stage) {
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
//			new AWAssetManager();
//			new AWEventRouter();
//			new Anyway().boot(this.stage);
//			var vo1:AWVisualObject = new AWVisualObject();
//			var vo2:AWVisualObject = new AWVisualObject();
//			var vo3:AWVisualObject = new AWVisualObject();
//			var vo4:AWVisualObject = new AWVisualObject();
//			var vo5:AWVisualObject = new AWVisualObject();
//			var voc1:AWVisualObjectContainer = new AWVisualObjectContainer();
//			voc1.addChild(vo1);
//			voc1.addChild(vo2);
//			voc1.addChild(vo3);
//			voc1.addChildAt(vo4);
//			voc1.addChildAt(vo1, 3);
		}
	}
}
