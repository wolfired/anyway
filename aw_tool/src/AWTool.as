package{
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import anyway.model.obj.AWModelParser4Obj;
	
	[SWF(width="500", height="500", frameRate="24")]
	public class AWTool extends Sprite{
		private var _drag_area:Sprite;
		
		public function AWTool(){
			super();
			
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
			_drag_area = new Sprite();
			this.addChild(_drag_area);
			_drag_area.graphics.beginFill(0xF0F0F0);
			_drag_area.graphics.drawRect(0,0,500,500);
			_drag_area.graphics.endFill();
			_drag_area.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnter);
			_drag_area.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onDragDrop);
			_drag_area.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, onDragExit);
		}
		
		private function onDragEnter(event:NativeDragEvent):void{
			NativeDragManager.acceptDragDrop(_drag_area);
		}
		
		private function onDragDrop(event:NativeDragEvent):void{
			var dropTargets:Array= event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each (var dropTarget:File in dropTargets){
				tree(dropTarget);
			}
		}
		
		private function tree(file:File):void{
			if(file.isDirectory){
				var files:Array = file.getDirectoryListing();
				for each (var f:File in files){
					tree(f);
				}
			}else{
				read(file);
			}
		}
		
		private function read(file:File):void{
			try{
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var bytes:ByteArray = new ByteArray();
				fs.readBytes(bytes);
				new AWModelParser4Obj().parser(bytes);
			}catch(error:Error){
			}
			
			fs.close();
		}
		
		private function onDragExit(event:NativeDragEvent):void{
		}
	}
}