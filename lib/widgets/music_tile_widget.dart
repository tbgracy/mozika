import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozika/providers.dart';

import '../models/music_model.dart';

class MusicTile extends ConsumerWidget {
  const MusicTile({
    super.key,
    required this.music,
  });
  final Music music;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: (){
        final source = DeviceFileSource(music.path);
        ref.read(playerProvider).play(source);
        ref.read(playStateProvider.notifier).state = true;
        ref.read(currentMusicProvider.notifier).state = music;
      },
      child: Card(
        child: Text(music.filename),
      ),
    );
  }
}
