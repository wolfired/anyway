package anyway.face.controller{
	import anyway.face.AWIRotatable;

	public interface AWIRotateController{
		function lock(target:AWIRotatable):void;
		function rotate(angle_deg:Number, x:Number, y:Number, z:Number):void;
	}
}