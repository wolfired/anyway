package worker{
	import flash.display.Sprite;
	
	public class ParserWorker extends Sprite{
		public function ParserWorker(){
			super();
			this.showMsg();
		}
		
		private function showMsg():void{
			trace("worker");
		}
	}
}