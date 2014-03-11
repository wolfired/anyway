package anyway.utils {

	import by.blooddy.crypto.serialization.JSON;

	public function string2json(str:String):* {
		return by.blooddy.crypto.serialization.JSON.decode(str);
	}
}
