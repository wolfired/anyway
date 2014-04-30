package{
	public class AWToolUtil{
		private static const SIGN_TABLE:Vector.<Object> = Vector.<Object>([
			{key:"CR", content:"\r", comment:"\\r"},
			{key:"LF", content:"\n", comment:"\\n"},
			{key:"SPACE", content:"\n", comment:"space"},
			{key:"POUND", content:"#", comment:"#"},
			{key:"MINUS", content:"-", comment:"-"},
			{key:"POINT", content:".", comment:"."},
			{key:"V", content:"v", comment:"v"},
			{key:"T", content:"t", comment:"t"},
			{key:"N", content:"n", comment:"n"},
			{key:"F", content:"f", comment:"f"}
		]);
		private static const SIGN_CODE_TEMPLATE:String = "private static const SIGN_{key}:uint = {code};//{comment}";
		
		public static function genSignCode():void{
			trace("/*This code gen by AWToolUtil::genSignCode()*/");
			var code:uint = 0;
			for each (var sign:Object in SIGN_TABLE){
				code = uint((sign.content as String).charCodeAt(0));
				trace(SIGN_CODE_TEMPLATE.replace(/\{key\}/g, sign.key).replace(/\{code\}/g, code).replace(/\{comment\}/g, sign.comment));
			}
			trace("/*------------------------------------------*/");
		}
	}
}