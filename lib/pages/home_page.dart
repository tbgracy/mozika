import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/music_model.dart';
import '../services/cache_services.dart';
import '../services/search_service.dart';
import '../widgets/folder_picker_widget.dart';
import '../widgets/music_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                  ),
                ),
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
