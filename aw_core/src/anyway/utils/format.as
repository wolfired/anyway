package anyway.utils {

	import flash.utils.ByteArray;

	public function format(number:Number):String {
		var temp:Array = number.toFixed(10).split(/\./g);

		var bytes:ByteArray = new ByteArray();
		bytes.writeUTFBytes("          .0000000000");

		bytes.position = 10 - temp[0].length;
		bytes.writeUTFBytes(temp[0]);
		bytes.position = 11;

		if(temp.length > 0) {
			bytes.writeUTFBytes(temp[1]);
		}

		bytes.position = 0;
		return bytes.readUTFBytes(bytes.bytesAvailable);
	}
}
