package {

	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;

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

		private var _stage3D:Stage3D;
		private var _context3D:Context3D;

		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			this.startup();
		}

		private function onRemovedFromStage(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function startup():void {
			this.stage.align = StageAlign.TOP;
			this.stage.quality = StageQuality.BEST;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if(!this.hasEventListener(Event.ENTER_FRAME)) {
				this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}

			if(this.stage.stage3Ds.length > 0) {
				_stage3D = this.stage.stage3Ds[0];
				_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
				_stage3D.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			}
		}

		private function onContext3DCreate(event:Event):void {
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);

			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(500, 500, 2);

			var vb_raw:Vector.<Number> = Vector.<Number>([
														 0, 0, 1, 0, 0,
														 1, 0, 0, 1, 0,
														 0, 1, 0, 0, 1
														 ]);
			var vb_wide:int = 5;
			var vb:VertexBuffer3D = _context3D.createVertexBuffer(vb_raw.length / vb_wide, vb_wide);
			vb.uploadFromVector(vb_raw, 0, vb_raw.length / vb_wide);
			_context3D.setVertexBufferAt(0, vb, 0, Context3DVertexBufferFormat.FLOAT_2); //va0
			_context3D.setVertexBufferAt(1, vb, 2, Context3DVertexBufferFormat.FLOAT_3); //va1

			var ib_raw:Vector.<uint> = Vector.<uint>([0, 1, 2]);
			var ib:IndexBuffer3D = _context3D.createIndexBuffer(ib_raw.length);
			ib.uploadFromVector(ib_raw, 0, ib_raw.length);

//			var vp:AGALMiniAssembler = new AGALMiniAssembler();
//			vp.assemble(Context3DProgramType.VERTEX,
//						"mov op, va0 \n" +
//						"mov v0, va1");
//
//			var fp:AGALMiniAssembler = new AGALMiniAssembler();
//			fp.assemble(Context3DProgramType.FRAGMENT, "mov oc, v0");
//
//			var p:Program3D = _context3D.createProgram();
//			p.upload(vp.agalcode, fp.agalcode);
//			_context3D.setProgram(p);
//
//			_context3D.clear(1, 1, 1);
//			_context3D.drawTriangles(ib);
//			_context3D.present();
		}

		private function onEnterFrame(event:Event):void {
		}
	}
}
