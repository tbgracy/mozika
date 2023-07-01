import '../models/music_model.dart';
import 'cache_services.dart';
import 'filesystem_services.dart';

class SearchService {
  static Future<List<Music>> searchMusic(String keyword) async {
    List<Music> searchResult = [];
    keyword = keyword.toLowerCase();
    if (keyword.isEmpty) {
      return searchResult;
    } else {
      final musicDirectory_ = await CacheService.getMusicDirectory();
      final musics = await FileSystemService.getAllMusics(musicDirectory_!);
        searchResult = musics.where(
          (music) {
            return music.filename.toLowerCase().contains(keyword);
          },
        ).toList();
    }
    return searchResult;
  }

  static Future<List<String>> getAutosuggestion(String keyword) async {
    throw UnimplementedError();
  }
}
