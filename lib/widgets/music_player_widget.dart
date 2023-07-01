import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozika/providers.dart';
import 'package:path/path.dart';

class MusicPlayerWidget extends ConsumerStatefulWidget {
  const MusicPlayerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends ConsumerState<MusicPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final isPlaying = ref.watch(playStateProvider);
    final currentMusic = ref.watch(currentMusicProvider);

    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.pink,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (currentMusic != null)
              Text(currentMusic.filename),
            IconButton(
              onPressed: () {
                if (isPlaying) {
                  ref.read(playerProvider).pause();
                  ref.read(playStateProvider.notifier).state = false;
                } else {
                  ref.read(playerProvider).resume();
                  ref.read(playStateProvider.notifier).state = true;
                }
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
