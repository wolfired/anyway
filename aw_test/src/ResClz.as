package {

	public class ResClz {
		[Embed(source='res/box.png')]
		private static var _boxClass:Class;
		
		[Embed(source='res/hero.png')]
		private static var _heroClass:Class;

		public static function get boxClass():Class {
			return _boxClass;
		}
		
		public static function get heroClass():Class {
			return _heroClass;
		}
	}
}
