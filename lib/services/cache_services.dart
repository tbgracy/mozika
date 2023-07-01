import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static final sp = SharedPreferences.getInstance();

  static Future<String?> getMusicDirectory() async {
    String? result = await sp.then(
      (cache) {
        return cache.getString('musicDirectory');
      },
    );
    return result;
  }

  static Future<bool?> setMusicDirectory(String musicDirectory) async {
    bool? result = await sp.then(
      (cache) {
        return cache.setString('musicDirectory', musicDirectory);
      },
    );
    return result;
  }

  static Future<List<String>> getSearchHistory(){
    throw UnimplementedError();
  }
}
