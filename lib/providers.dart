import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/music_model.dart';

final currentMusicProvider = StateProvider<Music?>((ref) {
  return;
});

final playerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

final playStateProvider = StateProvider<bool>((ref) {
  final player = ref.watch(playerProvider);
  if (player.state == PlayerState.paused) {
    return false;
  } else {
    return true;
  }
});