package anyway.face.controller{
	import anyway.face.AWITranslateable;

	public interface AWITranslateController{
		function lock(target:AWITranslateable):void;
		function translate(tx:Number, ty:Number, tz:Number):void;
	}
}