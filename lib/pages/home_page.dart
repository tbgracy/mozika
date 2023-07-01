import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/cache_services.dart';

import '../widgets/folder_picker_widget.dart';
import '../widgets/music_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var musicDirectory = CacheService.getMusicDirectory();

  @override
  void initState() {
    // CacheService.
    super.initState();
  }

  void _chooseDirectory() async {
    setState(() {
      musicDirectory = FilePicker.platform.getDirectoryPath();
    });
    musicDirectory.then((value) {
      if (value != null) {
        CacheService.setMusicDirectory(value);
      }
    });
    // if (musicDirectory != null) {
    // CacheService.setMusicDirectory(musicDirectory);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBar(),
            ),
            Expanded(
              child: FutureBuilder(
                future: musicDirectory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return Center(
                          child: InkWell(
                        onTap: _chooseDirectory,
                        child: const FolderPickerWidget(),
                      ));
                    } else {
                      return MusicListWidget(musicDirectory: snapshot.data!);
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
