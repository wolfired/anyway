package anyway.exception{
	public class AWException extends Error{
		public static const DUPLICATE_INSTANCE:String = "Duplicate instance!!";
		
		public function AWException(message:*="", id:*=0){
			super(message, id);
		}
	}
}