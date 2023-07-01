import 'package:flutter/material.dart';
import 'package:mozika/services/filesystem_services.dart';
import 'package:mozika/widgets/music_tile_widget.dart';

import '../models/music_model.dart';

class MusicListWidget extends StatefulWidget {
  const MusicListWidget({
    super.key,
    required this.musicDirectory,
  });

  final String musicDirectory;

  @override
  State<MusicListWidget> createState() => _MusicListWidgetState();
}

class _MusicListWidgetState extends State<MusicListWidget> {
  late final Future<List<Music>> musics;

  @override
  void initState() {
    musics = FileSystemService.getAllMusics(widget.musicDirectory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: musics,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {},
                child: MusicTile(
                  music: snapshot.data![i],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
