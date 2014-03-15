package anyway.core {

	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	
	import anyway.manager.asset.AWAsset;
	import anyway.manager.asset.AWAssetManager;
	import anyway.utils.string2json;

	public class Anyway {
		public function Anyway() {
		}

		private var _stage3D:Stage3D;
		private var _context3D:Context3D;

		public function boot(stage:Stage):void {
			stage.align = StageAlign.TOP;
			stage.quality = StageQuality.BEST;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			if(!stage.hasEventListener(Event.ENTER_FRAME)) {
				stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}

			if(stage.stage3Ds.length > 0) {
				_stage3D = stage.stage3Ds[0];
				_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
				_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			}
		}

		private function onContext3DCreate(event:Event):void {
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);

			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(500, 500, 2);
			
			_asset = AWAssetManager.instance.fetch("./res/box.def");
		}

		private var _asset:AWAsset;
		private function onEnterFrame(event:Event):void {
			if(!_asset.isFull) {
				return;
			}

			var def:Object = string2json(_asset.data as String);

			var vb_raw:Vector.<Number> = Vector.<Number>(def.vertex_raw);
			var vb_wide:int = def.coord_wide + def.color_wide;
			var vb:VertexBuffer3D = _context3D.createVertexBuffer(vb_raw.length / vb_wide, vb_wide);
			vb.uploadFromVector(vb_raw, 0, vb_raw.length / vb_wide);
			_context3D.setVertexBufferAt(0, vb, 0, Context3DVertexBufferFormat.FLOAT_2); //va0
			_context3D.setVertexBufferAt(1, vb, 2, Context3DVertexBufferFormat.FLOAT_3); //va1

			var ib_raw:Vector.<uint> = Vector.<uint>(def.index_raw);
			var ib:IndexBuffer3D = _context3D.createIndexBuffer(ib_raw.length);
			ib.uploadFromVector(ib_raw, 0, ib_raw.length);

			var vp:AGALMiniAssembler = new AGALMiniAssembler();
			vp.assemble(Context3DProgramType.VERTEX,
						"mov op, va0 \n" +
						"mov v0, va1");

			var fp:AGALMiniAssembler = new AGALMiniAssembler();
			fp.assemble(Context3DProgramType.FRAGMENT, "mov oc, v0");

			var p:Program3D = _context3D.createProgram();
			p.upload(vp.agalcode, fp.agalcode);
			_context3D.setProgram(p);

			_context3D.clear(1.0, 1.0, 1.0);
			_context3D.drawTriangles(ib);
			_context3D.present();
		}
	}
}
