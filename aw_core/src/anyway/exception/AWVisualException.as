package anyway.exception{
	public class AWVisualException extends AWException{
		
		public static const INDEX_OUTOF_RANGE:String = "index outof range!!";
		public static const NOT_A_CHILD:String = "not a child!!";
		
		public function AWVisualException(message:*="", id:*=0){
			super(message, id);
		}
	}
}