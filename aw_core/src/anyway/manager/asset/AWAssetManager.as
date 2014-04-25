package anyway.manager.asset {

	import flash.net.URLLoaderDataFormat;
	
	public class AWAssetManager {
		private static var _instance:AWAssetManager;

		public static function get instance():AWAssetManager {
			return _instance;
		}

		public function AWAssetManager() {
			SWITCH::debug{
				if(null != _instance){
					throw new Error("Duplicate instance:AWAssetManager");
				}
			}
			
			_asset_queue = new Vector.<AWAsset>();
			_asset_map = {};
			_asset_loader = new AWAssetLoader(_asset_queue);

			_instance = this;
		}

		private var _asset_queue:Vector.<AWAsset>;
		private var _asset_map:Object;
		private var _asset_loader:AWAssetLoader;

		/**
		 * @param url 资源地址
		 * @param callback 回调函数
		 * @param type 资源类型
		 * @return 资源包
		 */		
		public function fetch(url:String, callback:Function = null, type:String = URLLoaderDataFormat.TEXT):AWAsset {
			var asset:AWAsset = _asset_map[url] as AWAsset;
			if(null == asset){
				asset = new AWAsset(url, type);
				_asset_queue.push(asset);
				_asset_map[url] = asset;
			}
			
			if(asset.isFull){
				if(null != callback){
					callback(asset);
				}
			}else{
				if(null != callback){
					asset.pushCallback(callback);
				}
				
				if(_asset_loader.isIdle){
					_asset_loader.busy();
					_asset_loader.load();
				}
			}
			
			return asset;
		}
	}
}
