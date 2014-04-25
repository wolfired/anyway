package anyway.shader{
	import com.barliesque.agal.EasierAGAL;
	
	public class TestShader extends EasierAGAL{
		public function TestShader(debug:Boolean=true, assemblyDebug:Boolean=false){
			super(debug, assemblyDebug);
		}
		
		override protected function _fragmentShader():void{
			move(OUTPUT, VARYING[0]);
		}
		
		override protected function _vertexShader():void{
//			move(OUTPUT, ATTRIBUTE[0]);
			multiply4x4(OUTPUT, ATTRIBUTE[0], CONST[0]);
			move(VARYING[0], ATTRIBUTE[1]);
		}
		
		override public function dispose():void{
			super.dispose();
		}
	}
}