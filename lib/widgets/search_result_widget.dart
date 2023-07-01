import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/music_model.dart';
import '../providers.dart';

class SearchWidgetResult extends StatelessWidget {
  const SearchWidgetResult({
    super.key,
    required this.topMargin,
    required this.autosuggestions,
    required this.musics,
  });

  final double topMargin;
  final List<String> autosuggestions;
  final List<Music> musics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topMargin,
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          // color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...autosuggestions.map((e) {
                  return SuggestionTile(keyword: e);
                }).toList(),
                const Divider(),
                ...musics.map((e) {
                  return MusicTileWidget(music: e);
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuggestionTile extends ConsumerWidget {
  const SuggestionTile({
    super.key,
    required this.keyword,
  });

  final keyword;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        ref.read(keywordProvider.notifier).state = keyword;
      },
      child: Text(keyword),
    );
  }
}

class MusicTileWidget extends ConsumerWidget {
  const MusicTileWidget({
    super.key,
    required this.music,
  });

  final Music music;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        final source = DeviceFileSource(music.path);
        ref.read(playerProvider).play(source);
        ref.read(playStateProvider.notifier).state = true;
        ref.read(currentMusicProvider.notifier).state = music;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Row(
          children: [
            const Icon(Icons.music_note),
            const SizedBox(width: 20.0),
            Text(music.filename),
          ],
        ),
      ),
    );
  }
}
