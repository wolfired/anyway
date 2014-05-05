package {

	public class ResClz {
		[Embed(source='res/box.png')]
		private static var _textureClass:Class;

		public static function get textureClass():Class {
			return _textureClass;
		}
	}
}
