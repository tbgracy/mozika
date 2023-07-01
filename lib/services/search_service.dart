import '../models/music_model.dart';
import 'cache_services.dart';
import 'filesystem_services.dart';

// create function distanceLevenshtein
int distanceLevenshtein(String a, String b) {
  // create list with dim a.length+1 * b.lenght+1
  List<List<int>> matrix = List.generate(
    a.length + 1,
    (index) => List.generate(
      b.length + 1,
      (index) => 0,
      growable: false,
    ),
    growable: false,
  );

  for (int i = 0; i <= a.length; i++) {
    matrix[i][0] = i;
  }
  for (int j = 0; j <= b.length; j++) {
    matrix[0][j] = j;
  }

  for (int i = 1; i <= a.length; i++) {
    for (int j = 1; j <= b.length; j++) {
      int substitutionCost = 0;
      if (a[i - 1] != b[j - 1]) {
        substitutionCost = 1;
      }
      matrix[i][j] = [
        matrix[i - 1][j] + 1,
        matrix[i][j - 1] + 1,
        matrix[i - 1][j - 1] + substitutionCost
      ].reduce((value, element) => value < element ? value : element);
    }
  }
  return matrix[a.length][b.length];
}

class SearchService {
  static Future<List<Music>> searchMusic(String keyword) async {
    List<Music> searchResult = [];
    keyword = keyword.toLowerCase();
    if (keyword.isEmpty) {
      return searchResult;
    } else {
      final musicDirectory_ = await CacheService.getMusicDirectory();
      final musics = await FileSystemService.getAllMusics(musicDirectory_!);

      searchResult = musics.where((music) {
        String result = music.filename
            .replaceAll('.mp3', '')
            .replaceAll("undefined - ", '');
        RegExp prefixRegex = RegExp(r'^\d+\s*-\s*');
        RegExp parenthesesRegex = RegExp(r'\([^)]*\)');
        result =
            result.replaceAll(parenthesesRegex, '').replaceAll(prefixRegex, '');

        final musicName = result.trim();
        int distance = distanceLevenshtein(musicName, keyword);
        final names = musicName.split(" - ");
        if (names.length >= 2) {
          final songName = names[1].trim();
          distance = distanceLevenshtein(songName, keyword);
        }
        return distance <= 3;
      }).toList();
      return searchResult;
    }
  }

  static Future<List<String>> getAutosuggestion(String keyword) async {
    throw UnimplementedError();
  }
}
