import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/music_model.dart';
import '../services/cache_services.dart';
import '../services/search_service.dart';
import '../widgets/folder_picker_widget.dart';
import '../widgets/music_list_widget.dart';
import '../widgets/music_player_widget.dart';
import '../widgets/search_result_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var musicDirectory = CacheService.getMusicDirectory();
  final searchBarHeight = 70.0;
  final searchBarController = TextEditingController();
  List<Music> searchResult = [];

  void _chooseDirectory() async {
    setState(() {
      musicDirectory = FilePicker.platform.getDirectoryPath();
    });
    musicDirectory.then((value) {
      if (value != null) {
        CacheService.setMusicDirectory(value);
      }
    });
  }

  void _searchMusic(String keyword) async {
    final res = await SearchService.searchMusic(keyword);
    setState(() {
      searchResult = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: searchBarHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBar(
                      leading: const Icon(Icons.search),
                      onChanged: _searchMusic,
                      controller: searchBarController,
                    ),
                  ),
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
                          return MusicListWidget(
                            musicDirectory: snapshot.data!,
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                MusicPlayerWidget(),
              ],
            ),
            if (searchResult.isNotEmpty)
              SearchWidgetResult(
                  topMargin: searchBarHeight, result: searchResult),
          ],
        ),
      ),
    );
  }
}
