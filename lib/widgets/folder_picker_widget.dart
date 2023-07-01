import 'package:flutter/material.dart';

class FolderPickerWidget extends StatelessWidget {
  const FolderPickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.folder_open),
        Text('Appuyez ici pour choisir un dosser'),
      ],
    );
  }
}
