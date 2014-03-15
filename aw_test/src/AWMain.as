package {

	import flash.display.Sprite;
	import flash.events.Event;
	
	import anyway.core.Anyway;
	import anyway.events.AWEventRouter;
	import anyway.manager.asset.AWAssetManager;

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
			new AWAssetManager();
			new AWEventRouter();
			new Anyway().boot(this.stage);
		}
	}
}
