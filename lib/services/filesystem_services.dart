import 'dart:io';
import 'package:path/path.dart' as p;

import '../models/music_model.dart';

class FileSystemService {
  static Future<List<Music>> getAllMusics(String musicDirectory) async {
    final result = <Music>[];
    var dir = Directory(musicDirectory);

    for (var entity in dir.listSync(recursive: true)) {
      // print(p.extension(entity.path));
      if (p.extension(entity.path) == '.mp3') {
        result.add(Music(filename: p.basename(entity.path), path: entity.path));
      }
    }

    return result;
  }
}
