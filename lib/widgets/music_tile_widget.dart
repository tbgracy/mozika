import 'package:flutter/material.dart';

import '../models/music_model.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    required this.music,
  });
  final Music music;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(music.filename),
    );
  }
}
