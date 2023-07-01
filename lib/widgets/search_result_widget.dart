import 'package:flutter/material.dart';

import '../models/music_model.dart';

class SearchWidgetResult extends StatelessWidget {
  const SearchWidgetResult({
    super.key,
    required this.topMargin,
    required this.result,
  });

  final double topMargin;
  final List<Music> result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topMargin),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: result.map((e) => Text(e.filename)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}