package anyway.shader{
	import com.barliesque.agal.EasierAGAL;
	import com.barliesque.agal.TextureFlag;
	
	public class TextureShader extends EasierAGAL{
		public function TextureShader(debug:Boolean=true, assemblyDebug:Boolean=false){
			super(debug, assemblyDebug);
		}
		
		override protected function _fragmentShader():void{
			sampleTexture(TEMP[0], VARYING[0], SAMPLER[0], [TextureFlag.TYPE_2D, TextureFlag.FILTER_LINEAR, TextureFlag.MIP_NO]);
			move(OUTPUT, TEMP[0]);
		}
		
		override protected function _vertexShader():void{
			move(VARYING[0], ATTRIBUTE[1]);
			multiply4x4(OUTPUT, ATTRIBUTE[0], CONST[0]);
		}
	}
}